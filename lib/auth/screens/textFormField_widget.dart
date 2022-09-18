import 'package:flutter/material.dart';

class AuthTextFormFieldWidget extends StatelessWidget {
  const AuthTextFormFieldWidget(
      {Key? key, required this.hint, required this.isObsecure})
      : super(key: key);
  final String hint;
  final bool isObsecure;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
      child: TextFormField(
          style: const TextStyle(color: Colors.black),
          obscureText: isObsecure,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
    );
    
  }
}
