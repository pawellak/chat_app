import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/widget/chat/messages.dart';
import 'package:my_chat_app/widget/chat/new_messages.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
@override
  void initState() {
  final fbm = FirebaseMessaging.instance;
  fbm.requestPermission();

  FirebaseMessaging.onMessage.listen((message) {
    print('onMessage ####TO JEST MOJA WIADOMOSC');
    print(message);
    return;
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print('onMessageOpenedApp ####TO JEST MOJA WIADOMOSC');
    print(message);
    return;
  });
  fbm.subscribeToTopic('chat');
    super.initState();
  }

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
