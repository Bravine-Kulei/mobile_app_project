import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'bluetooth_helper.dart';
import 'message.dart'; // Import the Message class

class ChatScreen extends StatefulWidget {
  final BluetoothHelper bluetoothHelper;
  final BluetoothDevice device;

  const ChatScreen(
      {Key? key, required this.bluetoothHelper, required this.device})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Message> _messages = [];

  @override
  void dispose() {
    _messageController.dispose();
    widget.bluetoothHelper.disconnect();
    super.dispose();
  }

  void _sendMessage() {
    String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      Message message = Message(
        content: messageText,
        sender: 'Me',
        timestamp: DateTime.now(),
      );
      setState(() {
        _messages.add(message);
      });
      widget.bluetoothHelper.sendMessage(messageText);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat with ${widget.device.name}')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(message: _messages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMe = message.sender == 'Me';
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.sender,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              message.content,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 5),
            Text(
              message.timestamp.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
