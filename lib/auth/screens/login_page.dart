import 'package:communication_app/auth/screens/signup_page.dart';
import 'package:provider/provider.dart';

import '../../providers/change_notifiers/auth_notifier.dart';
import 'textFormField_widget.dart';
import 'package:communication_app/main_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(padding: EdgeInsets.all(30)),
              Container(
                height: 250,
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/a2.jpeg'),
                        fit: BoxFit.fill)),
              ),

              Form(
                key: formKey,
                child: Column(
                  children: [
                    AuthTextFormFieldWidget(
                      controller: emailController,
                      hint: 'Enter your email',
                      isObsecure: false,
                      validator: (value) {
                        if (!(value!.contains('@') && value.contains('.com'))) {
                          return 'Invalid email';
                        }
                        return null;
                      },
                    ),
                    AuthTextFormFieldWidget(
                      controller: passwordController,
                      hint: 'Enter Passsword',
                      isObsecure: true,
                      validator: (value) {
                        if (value!.length < 6) {
                          return 'Password must be greater than 6';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 50.0,
              //   width: 300.0,
              //   child: TextField(
              //     style: const TextStyle(color: Colors.black),
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(20.0)),
              //       hintText: 'Enter your password',
              //       hintStyle:const TextStyle(color: Colors.grey),
              //       filled: true,
              //       fillColor: Colors.white,

              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<AuthNotifier>(
                    builder: (context, notifier, child) => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            primary: const Color.fromARGB(255, 182, 127, 145)),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            print('Go for login');

                            await notifier.loginUser(
                                email: emailController.text,
                                password: passwordController.text,
                                context: context);
                          }
                        },
                        child: notifier.isLoading == true
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : const Text('Sign in')),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignUpPage.routeName);
                      },
                      child: const Text(
                        'New User? Sign Up',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                      ))
                ],
              ),
              const SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        ' Help?',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
