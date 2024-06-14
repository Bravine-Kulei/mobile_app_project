import 'package:flutter/material.dart';
import 'bluetooth_helper.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ChatScreen extends StatefulWidget {
  final BluetoothHelper bluetoothHelper;
  final BluetoothDevice device;

  const ChatScreen({Key? key, required this.bluetoothHelper, required this.device}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<String> messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage(String message) {
    setState(() {
      messages.add(message);
    });
    widget.bluetoothHelper.sendMessage(message, widget.device);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.device.name}'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade200,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        messages[index],
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Colors.blueAccent,
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _sendMessage(_controller.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
