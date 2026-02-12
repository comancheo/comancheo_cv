import 'dart:async';

import 'package:comancheo_cv/auto_route/app_router.dart';
import 'package:comancheo_cv/models/app_notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

bool loaded = false;
AppRouter appRouter = AppRouter();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
bool? flutterLocalNotificationsPluginIsInitialized;
const String notificationsChannelId = 'cz.comancheo.cv';
const String notificationsChannelName = 'ComancheosCV';
AppNotification? notificationToShow;
StreamController<bool> checkNotificationToShow = StreamController<bool>();