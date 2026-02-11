# comancheo_cv

A Flutter mobile app to show my skills.

## Main used packages

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Firebase messaging](https://pub.dev/packages/firebase_messaging)
- [Firebase craslytics](https://pub.dev/packages/firebase_crashlytics)
- [Flutter map](https://pub.dev/packages/flutter_map)
- [Geolocator](https://pub.dev/packages/geolocator)
- [GetIt](https://pub.dev/packages/get_it)
- [Build runner](https://pub.dev/packages/build_runner)
- [Auto Route](https://pub.dev/packages/auto_route)
- [HTTP](https://pub.dev/packages/http)
- [Cached network image](https://pub.dev/packages/cached_network_image)
- [RSS dart](https://pub.dev/packages/rss_dart)
- [Google Fonts](https://pub.dev/packages/google_fonts)

## Main used packages

- [Free Weather API](https://open-meteo.com/)
- [ČTK - rss kanál ceskenoviny.cz](https://www.ceskenoviny.cz/)
- [GitHub storage](https://github.com/comancheo)

## Run

Just hit: `fvm flutter run`

## Build

### Android
If you add key.properties, you can build it in release mode.
`fvm flutter build apk --release`

### iOS
You have to change team in XCode
`fvm flutter build ios --release`

## Rebuild app_router.dart
In order to rebuild or just build `app_router.dart` you need to hit `fvm dart run build_runner build --delete-conflicting-outputs`

## GetIt & Services
All Services are made with __async__ init. Services are initialized in `splash.dart`. Instances are hold by GetIt, so you can access them whenever you want. Be careful with heavy loads inside __init__, it can cause too slow load of app.

## Chat
This part is not ready yet. But it will ask you to pass your email adress and then authorize it by clicking to link inside email. Then you can go to chat and write some messages, or maybe chat with other users. Messages will be deleted within 5 days. In the future you will be able to send pictures. Also, you will be able to delete all your data on server by just one click inside APP.

## Geolocator
All your location data are used only inside app and for app purpouse only. There is one API call with your __location__ data, and it is only to get proper weather data, you can always disable permissions for geolocation.

## [Bloc](https://pub.dev/packages/bloc)
Im planning to add Bloc and Cubit, you I will be able to show loading status, update data inside widget such as weather and ČTK news or your location on the map.

## [AutoRoute](https://pub.dev/packages/auto_route)
All navigation inside app is made by AutoRoute package. It's ease way (is it possible to say its ease to use flutter navigation?) to make navigation inside app.

### Navigation
Its provided by AutoRoute. App is basicaly just HomeScreen with `AutoTabsScaffold`, where are other nested routes. So you can open NewsScreen inside DashboarScreen.

## Images
Images are loaded from internet via CachedNetworkImage, it's used to show my profile pic from GitHub. Also you can open picture inside ImageWidget, where you pass path (it can be URL or asset path) and Widget decide if it is Asset image or Network image. Also this widget provides method to open it "bigger" inside Dialog.

## Firebase Messaging
Firebase provides way to send push notification to apps (web, iOS and Android, maybe more?). If app is backgrounded or simply not opened, your OS will show you notification. If you click at it my APP will open and show this notification. There is a way to send some data, so APP can navigate to some Screen or do some stuff i.e. reload messages inside Chat or anyother data.