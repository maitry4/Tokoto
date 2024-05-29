import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokoto/firebase_options.dart';
import 'package:tokoto/pages/auth_page.dart';
import 'package:tokoto/pages/onboarding_screen.dart';
import 'package:tokoto/responsive/size_config.dart';
import 'package:tokoto/themes/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final pres = await SharedPreferences.getInstance();
  final onboarding = pres.getBool('onboarding') ?? false;
  
  runApp(MyApp(onboarding: onboarding),);
}

class MyApp extends StatelessWidget {
  final bool onboarding;

  const MyApp({Key? key, this.onboarding = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: onboarding ? AuthPage() : OnBoardingScreen()
    );
  }
}
