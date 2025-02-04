import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paws/navigation/navigation.dart';
import 'package:paws/screens/home.dart';
import 'package:paws/screens/login_screen.dart';
import 'package:paws/screens/register_screen.dart';
import 'package:paws/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( Provider(create: (BuildContext context){
    return AuthService();
  },
    child: MyApp()));
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,
      ),
      getPages : [
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/register', page: () => const RegisterScreen()),
        GetPage(name: '/home', page: () => const Home()),
        GetPage(name: '/navigation', page: () => const Navigation())
      ],
      home: const LoginScreen(),
    );
  }
}

