import 'package:communication_app/auth/screens/login_page.dart';
import 'package:communication_app/auth/screens/signup_page.dart';
import 'package:communication_app/main_screen.dart';
import 'package:communication_app/providers/change_notifiers/auth_notifier.dart';
import 'package:communication_app/providers/change_notifiers/chat_notifier.dart';
import 'package:communication_app/providers/change_notifiers/home_notifier.dart';
import 'package:communication_app/splash/splash_screen.dart';
import 'package:communication_app/widgets/chat_head.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AuthNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => HomeNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => ChatNotifier(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          MainScreen.routeName: (context) => const MainScreen(),
          SignUpPage.routeName: (context) => SignUpPage(),
        });
  }
}
