import 'package:communication_app/models/message.dart';
import 'package:communication_app/providers/change_notifiers/auth_notifier.dart';
import 'package:communication_app/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({Key? key, required this.message}) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<AuthNotifier>(context).currentUser!.uid;
    return Row(
      mainAxisAlignment: message.userId == userId
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: message.userId == userId
                ? AppColors.kPrimary
                : AppColors.kSecondary,
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            child: Text(
              message.message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
