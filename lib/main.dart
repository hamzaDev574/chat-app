import 'package:communication_app/auth/screens/login_page.dart';
import 'package:communication_app/auth/screens/signup_page.dart';
import 'package:communication_app/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData.dark(),


      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName:(context) => const LoginScreen(),
        MainScreen.routeName:(context) => const MainScreen(),
        SignUpPage.routeName:(context) => const SignUpPage(),


      }
    
      


      
    );
  }
}

