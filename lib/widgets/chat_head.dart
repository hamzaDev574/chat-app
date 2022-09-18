import 'package:flutter/material.dart';
class ChatHead extends StatelessWidget {
   ChatHead({ Key? key,required this.image,required this.title }) : super(key: key);
  String title;
  Image image;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          height: 55,
          width: 55,
          decoration: const BoxDecoration(
            
            
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child:  ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
            
              child: image,
            ),
          )
          // ClipOval(
          //   child: SizedBox.fromSize(
          //     size: const Size.fromRadius(40),
          //     child: image),
          // ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(title,style: const TextStyle(color: Colors.black),),

    ],
    );
  }
}