import 'dart:async';
import 'dart:convert';

import 'package:comancheo_cv/models/app_notification.dart';
import 'package:comancheo_cv/models/received_notification.dart';
import 'package:comancheo_cv/utils/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
final StreamController<ReceivedNotification> didReceiveLocalNotificationSubject = StreamController<ReceivedNotification>();
@pragma('vm:entry-point')
final StreamController<String> selectNotificationSubject = StreamController<String>();
@pragma('vm:entry-point')
void onDidReceiveNotificationResponse(NotificationResponse response) async {
  if (response.payload != null) {
    debugPrint('notification response: ${response.payload}');
    selectNotificationSubject.add(response.payload!);
  } else {
    debugPrint('response: $response');
  }
}

class LocalNotificationService {

  Future<LocalNotificationService> init() async {
    await initNotificationPlugin();
    return this;
  }

  Future<void> initNotificationPlugin() async {
    try {
      _configureDidReceiveLocalNotificationSubject();
      _configureSelectNotificationSubject();

      final NotificationAppLaunchDetails? notificationAppLaunchDetails = await globals.flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

      if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
        selectNotificationSubject.add((notificationAppLaunchDetails?.notificationResponse?.payload ?? ''));
      }

      const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('ic_stat_comancheo_notif_icon');

      final DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

      final InitializationSettings initializationSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      globals.flutterLocalNotificationsPluginIsInitialized = await globals.flutterLocalNotificationsPlugin.initialize(settings:initializationSettings, onDidReceiveNotificationResponse:onDidReceiveNotificationResponse, onDidReceiveBackgroundNotificationResponse: onDidReceiveNotificationResponse );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _configureDidReceiveLocalNotificationSubject() {
    debugPrint('_configureDidReceiveLocalNotificationSubject');
    didReceiveLocalNotificationSubject.stream.listen((ReceivedNotification receivedNotification) async {
      debugPrint('didReceiveLocalNotificationSubject: $receivedNotification');
      _processNotification(receivedNotification.payload);
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      debugPrint('selectNotificationSubject: $payload');
      _processNotification(payload);
    });
  }

  Future<void> _processNotification(String? payload) async {
    if (payload == null || payload.isEmpty) return;

    AppNotification? notificationPayload = AppNotification.fromJson(jsonDecode(payload));

    if (notificationPayload.title == null || notificationPayload.title == '') return;

    globals.notificationToShow = notificationPayload;
    globals.checkNotificationToShow.sink.add(true);
    debugPrint('_processNotification');
  }
}