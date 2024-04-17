import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocation/router.locator.dart';
import 'package:geolocation/screens/splash_screen/splash_screen.dart';
import 'package:stacked_services/stacked_services.dart';
import 'router.router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            // colorScheme: lightScheme,
            // extensions: [lightCustomColors],
              primarySwatch: Colors.green
          ),

          debugShowCheckedModeBanner: false,
          navigatorKey: StackedService.navigatorKey,
          onGenerateRoute: StackedRouter().onGenerateRoute,
          home: const SplashScreen(),
        );
      }

  }





