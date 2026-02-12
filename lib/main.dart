import 'package:comancheo_cv/auto_route/app_router.dart';
import 'package:comancheo_cv/styles/theme.dart';
import 'package:comancheo_cv/styles/util.dart';
import 'package:comancheo_cv/utils/globals.dart' as globals;
import 'package:flutter/material.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      View.of(context).platformDispatcher.onPlatformBrightnessChanged = () {
        setState(() {});
      };
    });
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  final brightness = View.of(context).platformDispatcher.platformBrightness;

    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(context, "Lato", "Roboto");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp.router(
      routerConfig: globals.appRouter.config(),
      title: 'Comancheos CV',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
    );
  }
}

