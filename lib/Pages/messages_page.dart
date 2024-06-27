import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_tolet/Dimension.dart';
import 'package:the_tolet/Pages/home_page.dart';
import 'package:the_tolet/Pages/loading_page.dart';
import 'package:the_tolet/Pages/login_signup_page.dart';
import 'package:the_tolet/Pages/personal_data.dart';
import 'package:the_tolet/custom_widgets.dart';

Color changinText1 = Colors.amber;

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  _MessagePage createState() => _MessagePage();
}

class _MessagePage extends State<MessagePage> with TickerProviderStateMixin {
  @override
  void initState() {}

  TextEditingController _messageController = TextEditingController();
  List<Message> _messages = List.generate(
    10,
    (index) => Message(
      sender: index % 2 == 0 ? 'Friend' : 'Me',
      text: 'Message $index',
    ),
  );

  @override
  Widget build(BuildContext context) {
    Dimensions.myWidth = MediaQuery.of(context).size.width;
    Dimensions.myHieght = MediaQuery.of(context).size.height;
    Dimensions.sth = Dimensions.myHieght / 788;
    Dimensions.stw = Dimensions.myWidth / 360;
    Dimensions.standardHieght = Dimensions.sth;
    Dimensions.standardWidth = Dimensions.stw;
    return Container(
      color: Color(0xFF2E2250),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(
                  message: _messages[index],
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey[300]!,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.0),
          FloatingActionButton(
            onPressed: () {
              _sendMessage();
            },
            child: Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      setState(() {
        _messages.add(Message(sender: 'Me', text: messageText));
        _messageController.clear();
      });
    }
  }
}

class Message {
  final String sender;
  final String text;

  Message({required this.sender, required this.text});
}

class MessageBubble extends StatelessWidget {
  final Message message;

  MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Align(
        alignment: message.sender == 'Me'
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: message.sender == 'Me' ? Colors.blue : Colors.grey[200],
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (message.sender == 'Friend')
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    message.sender.substring(0, 1),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              SizedBox(width: 8.0),
              Flexible(
                child: Text(
                  message.text,
                  style: TextStyle(
                    color: message.sender == 'Me'
                        ? Color.fromARGB(255, 232, 108, 108)
                        : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
