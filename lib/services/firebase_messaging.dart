

import 'package:comancheo_cv/firebase_options.dart';
import 'package:comancheo_cv/models/app_notification.dart';
import 'package:comancheo_cv/utils/globals.dart' as globals;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("background process was called");

  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  debugPrint('Handling a background message ${message.messageId}');
}

class FirebaseService {
  Future<FirebaseService> init() async {
    await initializeFirebaseApp();
    await initializeFlutterFire();
    await initializeMessaging();
    return this;
  }
  

  Future<void> initializeFirebaseApp() async {
    // Firebase initialization - (for new project run 'flutterfire configure')
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  /// Initialize Firebase crashlytics
  Future<void> initializeFlutterFire() async {
      // Else only enable it in non-debug builds.
      // You could additionally extend this to allow users to opt-in.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);

    // Pass all uncaught errors to Crashlytics.
    Function? originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      // Forward to original handler.
      originalOnError!(errorDetails);
    };
  }
  /// Initialize Firebase messaging
  Future<void> initializeMessaging() async {

  // Register function for processing firebase push notifications on background (when the app is off or on background)
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Set how should be push notifications presented when the app is on foreground
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: false,
    badge: false,
    sound: false,
  );
    // Get token from Firebase
    String? token = await FirebaseMessaging.instance.getToken();
    debugPrint('FCM Token: $token');
    if (token != null) {
      // Upstream token to your backend via a service or directly
    }

    // If the FCM token was changed (it happens after reinstall, update, ..)
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      debugPrint('New FCM Token: $newToken');
      // Upstream new token to your backend via a service or directly
    });

    // If the app was started by the tap on notification
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) async {
      if (message != null) {
        if (message.data.isEmpty && kIsWeb) {
          debugPrint(message.data.toString());
          return;
        }

        await planFirebaseNotification(message, OpenNotificationFrom.backgound);
      }
    });

    // If the app is on foreground and receives push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint('Firebase message received');

      if (message.data.isEmpty && kIsWeb) {
        debugPrint(message.data.toString());
        return;
      }

      await planFirebaseNotification(message, OpenNotificationFrom.foreground);
    });

    // If the app was opened from background by the tap on notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      if (message.data.isEmpty && kIsWeb) {
        debugPrint(message.data.toString());
        return;
      }

      await planFirebaseNotification(message, OpenNotificationFrom.backgound);
    });
  }


  Future<void> planFirebaseNotification(RemoteMessage message, OpenNotificationFrom? openFrom) async {

    AppNotification? notificationPayload = AppNotification(
        id: 1,
        title: message.notification?.title,
        body: message.notification?.body,
        hiveId: message.data['objectId'],
        patientId: message.data['patientId'],
        objectType: message.data['objectType']?.toString().toLowerCase(),
        openNotificationFrom: openFrom);

    if (notificationPayload.title == null || notificationPayload.title == '') return;
    globals.notificationToShow = notificationPayload;
    globals.checkNotificationToShow.add(true);
  }
}