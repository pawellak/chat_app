import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({Key? key}) : super(key: key);

  @override
  _NewMessagesState createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  var _messageController = TextEditingController();
  var _enteredMessages = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    await FirebaseFirestore.instance.collection('chat').add({'text':_enteredMessages,'createdAt':Timestamp.now()});
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                setState(() {
                  _enteredMessages = value;
                });
              },
            ),
          ),
          IconButton(
              color: Theme.of(context).primaryColor,
              onPressed: _enteredMessages.trim().isEmpty ? null : _sendMessage,
              icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
