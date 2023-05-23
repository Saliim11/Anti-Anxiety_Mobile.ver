import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TextComposer extends StatefulWidget {
  const TextComposer({
    Key? key,
    required this.sendMessage,
  }) : super(key: key);

  final Function({BuildContext? context, String? text}) sendMessage;

  @override
  State<StatefulWidget> createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  final _controller = TextEditingController();
  bool _isComposing = false;

  void _reset() {
    _controller.clear();
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration.collapsed(
                hintText: 'Send Message...',
              ),
              onChanged: (text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: (text) {
                widget.sendMessage(text: text, context: context);
                _reset();
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.green),
            onPressed: _isComposing
                ? () {
                    widget.sendMessage(
                        text: _controller.text, context: context);
                    _reset();
                  }
                : null,
          ),
        ],
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final firestoreCollection = FirebaseFirestore.instance.collection('messages');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Chat App'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestoreCollection.orderBy('time').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }
                final documents = snapshot.data?.docs.reversed.toList() ??
                    <QueryDocumentSnapshot>[];
                return ListView.builder(
                  itemCount: documents.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    final document = documents[index];
                    return ChatMessage(
                      data: document.data() as Map<String, dynamic>,
                      isMine: document['uid'] ==
                          FirebaseAuth.instance.currentUser?.uid,
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          TextComposer(
            sendMessage: _sendMessage,
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessage({String? text, BuildContext? context}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context!).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Unable to login. Try again...',
          ),
        ),
      );
      return;
    }

    var data = <String, dynamic>{
      'uid': user.uid,
      'senderName': user.displayName,
      'senderPhotoUrl': user.photoURL,
      'time': Timestamp.now(),
      'text': text,
    };

    firestoreCollection.add(data);
  }
}

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    Key? key,
    required this.data,
    required this.isMine,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Row(
        children: <Widget>[
          isMine
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: CircleAvatar(
                    // Use colors instead of images for profile pictures
                    backgroundColor: Colors.grey,
                  ),
                ),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data['text'],
                  textAlign: isMine ? TextAlign.end : TextAlign.start,
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  data['senderName'],
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          isMine
              ? Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: CircleAvatar(
                    // Use colors instead of images for profile pictures
                    backgroundColor: Colors.grey,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatScreen(),
    );
  }
}

void main() {
  runApp(const ChatApp());
}
