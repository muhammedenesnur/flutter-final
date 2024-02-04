import 'package:final_odev/screens/home_page.dart';
import 'package:final_odev/screens/login_page.dart';
import 'package:final_odev/screens/onboarding_page.dart';
import 'package:final_odev/screens/profile_page.dart';
import 'package:final_odev/screens/register_page.dart';
import 'package:final_odev/screens/welcome_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      //uygulamanın başlayacağı sayfa
      initialRoute: '/onboarding',
      //Navigatorlar yani sayfaların ismi isimlere göre geçiş yapılıyor
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/profile': (context) => const ProfilePage(),
        '/onboarding': (context) => const OnboardingPage(),
        '/welcome': (context) => const WelcomePage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
