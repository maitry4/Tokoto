import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokoto/firebase_options.dart';
import 'package:tokoto/pages/auth_page.dart';
import 'package:tokoto/pages/forgot_password_page.dart';
import 'package:tokoto/pages/home_page.dart';
import 'package:tokoto/pages/logged_in_user_pages/all_product_page.dart';
import 'package:tokoto/pages/logged_in_user_pages/cart_page.dart';
import 'package:tokoto/pages/logged_in_user_pages/chat_page.dart';
import 'package:tokoto/pages/logged_in_user_pages/explore_page.dart';
import 'package:tokoto/pages/logged_in_user_pages/favorites_page.dart';
import 'package:tokoto/pages/logged_in_user_pages/profile_page.dart';
import 'package:tokoto/pages/login_page.dart';
import 'package:tokoto/pages/login_sucess_page.dart';
import 'package:tokoto/pages/onboarding_screen.dart';
import 'package:tokoto/pages/register_page.dart';
import 'package:tokoto/providers/category_provider.dart';
import 'package:tokoto/providers/user_provider.dart';
import 'package:tokoto/responsive/size_config.dart';
import 'package:tokoto/themes/light_theme.dart';
import 'package:get/get.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final pres = await SharedPreferences.getInstance();
  final onboarding = pres.getBool('onboarding') ?? false;
  
  runApp(
   MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),   
        // Add more providers if needed
      ],
      child: MyApp(onboarding: onboarding),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool onboarding;

  const MyApp({Key? key, this.onboarding = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetMaterialApp(
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: onboarding ? AuthPage() : OnBoardingScreen(),
      getPages: [
        GetPage(name: "/login", page: () => LoginPage()),
        GetPage(name: "/login_success", page: () => LoginSuccessPage()),
        GetPage(name: "/register", page: () => RegisterPage()),
        GetPage(name: "/forgot_password", page: () => ForgotPasswordPage()),
        GetPage(name: "/cart", page: () => CartPage()),
        GetPage(name: "/wishlist", page: () => FavoritePage()),
        GetPage(name: "/chat", page: () => ChatPage()),
        GetPage(name: "/profile", page: () => ProfilePage()),
        GetPage(name: "/explore", page: () => ExplorePage()),
        GetPage(name: "/home", page: () => HomePage()),
        GetPage(name: "/products", page: () => AllProductPage()),
      ],
    );
  }
}
