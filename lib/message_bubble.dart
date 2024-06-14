import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final double maxWidth; // Added a maxWidth property

  const MessageBubble(
      {Key? key, required this.message,
      this.maxWidth = double.infinity}) : super(key: key); // Set default maxWidth to infinity

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      constraints:
          BoxConstraints(maxWidth: maxWidth), // Apply maxWidth constraint
      child: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
