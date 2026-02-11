import 'dart:io';

import 'package:comancheo_cv/utils/globals.dart' as globals;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PermissionService {
  Future<PermissionService> init() async {
    await requestPermissions();
    return this;
  }
  /// Request permissions
  Future<void> requestPermissions() async {
    if (Platform.isAndroid) {
      // LocalNotification package needs permission to plan and show notifications
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation = globals.flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

      await androidImplementation?.requestNotificationsPermission();
    }

    if (Platform.isIOS) {
      await globals.flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(alert: true, badge: true, sound: true);
    }
  }
}
