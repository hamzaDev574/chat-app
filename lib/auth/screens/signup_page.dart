
import 'package:flutter/material.dart';
import 'textFormField_widget.dart';
class SignUpPage extends StatelessWidget {
  const SignUpPage({ Key? key }) : super(key: key);
  static const routeName='/SignUpPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width:MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
             const  AuthTextFormFieldWidget(hint: 'User name', isObsecure: false),
             const AuthTextFormFieldWidget(hint: 'Enter your name', isObsecure: false),
             const AuthTextFormFieldWidget(hint: 'Enter your password', isObsecure: true),
             const AuthTextFormFieldWidget(hint: 'confirm your password', isObsecure: true),
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
                 ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          primary: const Color.fromARGB(255, 182, 127, 145)),
                      onPressed: (
                        
                      ) {
                      
                 
                 
                      },
                      child: const Text('Sign up'))
            
          ],),
        ),
      ),


    );
  }
}