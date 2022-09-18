import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/change_notifiers/auth_notifier.dart';
import 'textFormField_widget.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  static const routeName = '/SignUpPage';

  final formkey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                  key: formkey,
                  child: Column(
                    children: [
                      AuthTextFormFieldWidget(
                        controller: userNameController,
                        hint: 'User name',
                        isObsecure: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Invalid username';
                          }
                          return null;
                        },
                      ),
                      AuthTextFormFieldWidget(
                        controller: emailController,
                        hint: 'Email',
                        isObsecure: false,
                        validator: (value) {
                          if (!(value!.contains('@') &&
                              value.contains('.com'))) {
                            return 'Invalid Email';
                          }
                          return null;
                        },
                      ),
                      AuthTextFormFieldWidget(
                        controller: passwordController,
                        hint: 'Enter your password',
                        isObsecure: true,
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'password must be greater than 6';
                          }
                          return null;
                        },
                      ),
                      AuthTextFormFieldWidget(
                        controller: confirmPasswordController,
                        hint: 'confirm your password',
                        isObsecure: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Passwords do not match';
                          }
                          if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ],
                  )),
              // TextField(
              //       style: const TextStyle(color: Colors.black),
              //       decoration: InputDecoration(
              //         border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(20.0)),
              //         hintText: 'Enter your name',
              //         hintStyle: const TextStyle(color: Colors.grey),
              //         filled: true,
              //         fillColor: Colors.white,
              //       ),
              //     ),
              //     const SizedBox(height: 10,),
              //     TextField(
              //       style: const TextStyle(color: Colors.black),
              //       decoration: InputDecoration(
              //         border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(20.0)),
              //         hintText: 'Enter your email',
              //         hintStyle: const TextStyle(color: Colors.grey),
              //         filled: true,
              //         fillColor: Colors.white,
              //       ),
              //     ),
              //     const SizedBox(height: 10,),
              //     TextField(
              //       style: const TextStyle(color: Colors.black),
              //       decoration: InputDecoration(
              //         border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(20.0)),
              //         hintText: 'Enter your password',
              //         hintStyle: const TextStyle(color: Colors.grey),
              //         filled: true,
              //         fillColor: Colors.white,
              //       ),
              //     ),
              //     const SizedBox(height: 10,),
              //     TextField(
              //       style: const TextStyle(color: Colors.black),
              //       decoration: InputDecoration(
              //         border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(20.0)),
              //         hintText: 'Confirm your password',
              //         hintStyle: const TextStyle(color: Colors.grey),
              //         filled: true,
              //         fillColor: Colors.white,
              //       ),
              //     ),
              //     const SizedBox(height: 20,),
              Consumer<AuthNotifier>(
                builder: (context, notifier, child) => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        primary: const Color.fromARGB(255, 182, 127, 145)),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        notifier.signupUser(
                            email: emailController.text,
                            password: passwordController.text,
                            userName: userNameController.text,
                            context: context);
                      }
                    },
                    child: notifier.isLoading == true
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Sign up')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
