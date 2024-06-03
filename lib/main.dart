import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokoto/firebase_options.dart';
import 'package:tokoto/local_strings.dart';
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

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? storedLocale = prefs.getString('locale');
  Locale? locale;
  if (storedLocale != null) {
    locale = Locale(storedLocale);
  }else{
    locale = Locale('en', 'US');
  }
  
  runApp(MyApp(onboarding: onboarding, locale: locale),);
}

class MyApp extends StatelessWidget {
  final bool onboarding;
  final Locale locale;
  const MyApp({Key? key, this.onboarding = false, this.locale = const Locale('en','US')}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetMaterialApp(
      locale: locale,
      translations: LocalString(),
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: onboarding ? AuthPage() : OnBoardingScreen()
    );
  }
}
