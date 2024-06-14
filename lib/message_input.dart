// message_input.dart
import 'package:flutter/material.dart';

class MessageInput extends StatefulWidget {
  final Function(String) onSendMessage;

  const MessageInput({Key? key, required this.onSendMessage}) : super(key: key);

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    widget.onSendMessage(_controller.text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Enter message...'),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}