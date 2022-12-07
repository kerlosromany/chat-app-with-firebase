import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String username;
  //final Key key;
  final bool isMe;

  const MessageBubble(this.message, this.username, this.isMe,
      /* {required this.key} */);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.grey[300] : Colors.deepPurple,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(14.0),
              topRight: const Radius.circular(14.0),
              bottomLeft:
                  isMe ? const Radius.circular(14) : const Radius.circular(0),
              bottomRight: !isMe
                  ? const Radius.circular(14)
                  : const Radius.circular(0),
            ),
          ),
          width: 140,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isMe ? Colors.black : Colors.white,
                ),
              ),
              Text(
                message,
                style: TextStyle(
                  color: isMe ? Colors.black : Colors.white,
                ),
                textAlign: isMe ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
