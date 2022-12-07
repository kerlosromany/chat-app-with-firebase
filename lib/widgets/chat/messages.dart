import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class Message extends StatelessWidget {
  const Message({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("chat")
          .orderBy("createdAt", descending: true)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          List<QueryDocumentSnapshot<Object?>> docs;
          docs = snapshot.data!.docs;
          return ListView.builder(
            reverse: true,
            itemCount: docs.length,
            itemBuilder: (ctx, index) {
              return MessageBubble(
                docs[index]["text"],
                docs[index]["username"],
                docs[index]["userId"] == FirebaseAuth.instance.currentUser!.uid,
                // key: ValueKey(docs[index].documentID),
              );
            },
          );
        }
      },
    );
  }
}
