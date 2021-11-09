import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_chat_app/widget/chat/messages.dart';
import 'package:my_chat_app/widget/chat/new_messages.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          DropdownButton(
            icon: const Icon(Icons.more_vert, color: Colors.orange),
            items: [
              DropdownMenuItem(
                child: Row(
                  children: const [
                    Icon(
                      Icons.exit_to_app,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 8),
                    Text('Logout')
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                value: 'Logout',
              )
            ],
            onChanged: (value) {
              if (value == 'Logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
        title: const Text('FlutterChat'),
      ),
      body: Column(
        children: const [
          Expanded(child: Messages()),
          NewMessages(),

        ],
      ),

    );
  }
}
