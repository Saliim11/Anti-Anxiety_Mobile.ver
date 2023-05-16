import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<String> messages = [
    'Hi, how are you?',
    'I\'m good, thanks for asking. How about you?',
    'I\'m fine, thanks.',
    'What are you doing today?',
  ].toList();

  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 54, 90),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: false,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Align(
                    alignment: messages[index].startsWith('I\'m')
                        ? Alignment
                            .centerRight // jika pesan diawali dengan "I'm" muncul di kanan
                        : Alignment.centerLeft, // jika tidak di kiri
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: messages[index].startsWith('I\'m')
                            ? Colors.greenAccent[400]
                            : Colors.grey[300],
                      ),
                      child: Text(
                        messages[index],
                        style: TextStyle(fontSize: 16),
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
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  FloatingActionButton(
                    backgroundColor: Color.fromARGB(255, 1, 54, 90),
                    child: Icon(Icons.send),
                    onPressed: () {
                      String message = messageController.text;
                      if (message.isNotEmpty) {
                        setState(() {
                          messages.add(message);
                          messageController.clear();
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
