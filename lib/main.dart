import 'package:camera/camera.dart';
import 'package:dovtron/pages/home_page.dart';
import 'package:dovtron/pages/login_page.dart';
import 'package:dovtron/pages/detection_page.dart';
import 'package:dovtron/pages/result_page.dart';
import 'package:dovtron/pages/settings_page.dart';
import 'package:dovtron/pages/splash_page.dart';
import 'package:dovtron/providers/google_sign_in_provider.dart';
import 'package:dovtron/utils/route_animation.dart';
import 'package:dovtron/utils/route_arguments.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  await Firebase.initializeApp(
    name: 'Dovtron',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create: (context) => GoogleSignInProvider(),
    child: MaterialApp(
      theme: ThemeData(fontFamily: 'Inter'),
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      onGenerateRoute: (settings) {
        final arguments = settings.arguments;
        if (settings.name == '/splash') {
          return RouteAnimation.slide(settings, const SplashPage());
        } else if (settings.name == '/login') {
          return RouteAnimation.slide(settings, const LoginPage());
        } else if (settings.name == '/') {
          return RouteAnimation.slide(
              settings,
              HomePage(
                cameras: cameras,
              ));
        } else if (settings.name == '/detection') {
          DetectionPageArguments args = arguments as DetectionPageArguments;
          return RouteAnimation.slide(
              settings, DetectionPage(image: args.image));
        } else if (settings.name == '/result') {
          DiseasePageArguments args = arguments as DiseasePageArguments;
          return RouteAnimation.slide(settings, ResultPage(name: args.name));
        } else if (settings.name == '/settings') {
          return RouteAnimation.slide(settings, const SettingsPage());
        } else {
          return RouteAnimation.slide(settings, const SplashPage());
        }
      },
    ),
  ));
}
