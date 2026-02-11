import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:comancheo_cv/auto_route/app_router.gr.dart';
import 'package:comancheo_cv/getit/get_it.dart';
import 'package:flutter/material.dart';
import 'package:comancheo_cv/utils/globals.dart' as globals;

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    if (globals.loaded) {
      context.router.replace(const HomeRoute());
    }
    super.initState();
    initialize().then((_) {
      globals.loaded = true;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await Future.delayed(const Duration(seconds: 10));
        if(mounted && context.mounted){context.router.replace(const HomeRoute());}  
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    globals.loaded = false;
  }

  @override
  void activate() {
    if (globals.loaded) {
      context.router.replace(const HomeRoute());
    }
    super.activate();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.asset("assets/logo.png"),
              const SizedBox(height: 20),
              const LinearProgressIndicator(),
              const SizedBox(height: 20),
              Text("Loading...", style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> initialize() async {
    await configureDependencies();
  }
}
