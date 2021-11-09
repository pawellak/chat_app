import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;

  const MessageBubble({Key? key,required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Container(
        width: 140,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(12),
        ),
        child:  Text(message,style: const TextStyle(color: Colors.black),),
      )],
    );
  }
}
