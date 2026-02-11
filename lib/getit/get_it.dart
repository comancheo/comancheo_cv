import 'package:comancheo_cv/services/chat.dart';
import 'package:comancheo_cv/services/connection.dart';
import 'package:comancheo_cv/services/ctk_news.dart';
import 'package:comancheo_cv/services/firebase_messaging.dart';
import 'package:comancheo_cv/services/local_notification.dart';
import 'package:comancheo_cv/services/local_storage.dart';
import 'package:comancheo_cv/services/permission.dart';
import 'package:comancheo_cv/services/weather.dart';
import 'package:comancheo_cv/utils/geolocation.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  getIt.registerSingletonAsync<ConnectionService>(() async => ConnectionService().init());
  getIt.registerSingletonAsync<LocalStorageService>(() async => LocalStorageService().init());
  await getIt.allReady();
  getIt.registerSingletonAsync<FirebaseService>(() async => FirebaseService().init());
  getIt.registerSingletonAsync<LocalNotificationService>(() async => LocalNotificationService().init());
  getIt.registerSingletonAsync<PermissionService>(() async => PermissionService().init());
  getIt.registerSingletonAsync<CtkNewsService>(() async => CtkNewsService().init());
  getIt.registerSingletonAsync<WeatherService>(() async => WeatherService().init());
  getIt.registerSingletonAsync<ChatService>(() async => ChatService().init());

  getIt.registerLazySingletonAsync<GeolocationService>(() async => GeolocationService().init());
  await getIt.allReady();
}