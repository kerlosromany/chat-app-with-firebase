import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({Key? key}) : super(key: key);

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final TextEditingController _controller = TextEditingController();
  String _enteredMessage = "";
  _sendMessage() async{
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance.collection("users").doc(user!.uid).get();
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance.collection("chat").add({
      "text": _enteredMessage,
      "createdAt": Timestamp.now(),
      "username" : userData["username"],
      "userId" : user.uid,
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                label: Text("Enter a message"),
              ),
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
              
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: const Icon(Icons.send),
            onPressed: _enteredMessage.trim().isEmpty? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}
