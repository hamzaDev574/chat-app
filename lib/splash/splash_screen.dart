import 'package:communication_app/auth/screens/login_page.dart';
import 'package:communication_app/main_screen.dart';
import 'package:communication_app/providers/change_notifiers/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static final routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(const Duration(seconds: 2)).then((_) async {
        await Provider.of<AuthNotifier>(context, listen: false)
            .getCurrentUser();
        if (Provider.of<AuthNotifier>(context, listen: false).currentUser ==
            null) {
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        } else {
          Navigator.pushReplacementNamed(context, MainScreen.routeName);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(image: AssetImage('assets/images/a2.jpeg')),
      ),
    );
  }
}
