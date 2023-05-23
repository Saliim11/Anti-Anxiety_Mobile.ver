// import 'package:anti_anxiety/Firebase/login_register_auth/auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'text_composer.dart';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({Key? key}) : super(key: key);

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   final firestoreCollection = FirebaseFirestore.instance.collection('messages');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         elevation: 0,
//         centerTitle: true,
//         title: const Text('Chat App'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: firestoreCollection.orderBy('time').snapshots(),
//               builder: (context, snapshot) {
//                 switch (snapshot.connectionState) {
//                   case ConnectionState.none:
//                   case ConnectionState.waiting:
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   default:
//                     var documents = snapshot.data?.docs.reversed.toList() ??
//                         <QueryDocumentSnapshot>[];
//                     return ListView.builder(
//                       itemCount: documents.length,
//                       reverse: true,
//                       itemBuilder: (context, index) {
//                         final document = documents[index];
//                         return ChatMessage(
//                           data: document.data() as Map<String, dynamic>,
//                           isMine: document['uid'] == Auth().currentUser?.uid,
//                         );
//                       },
//                     );
//                 }
//               },
//             ),
//           ),
//           const SizedBox(height: 8),
//           TextComposer(
//             sendMessage: _sendMessage,
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _sendMessage({BuildContext? context, String? text}) async {
//     final user = await Auth().currentUser;
//     if (user == null) {
//       ScaffoldMessenger.of(context!).showSnackBar(
//         const SnackBar(
//           backgroundColor: Colors.red,
//           content: Text(
//             'Unable to login. Try again...',
//           ),
//         ),
//       );
//       return;
//     }

//     var data = <String, dynamic>{
//       'uid': user.uid,
//       'senderName': user.displayName,
//       'senderPhotoUrl': user.photoURL,
//       'time': Timestamp.now(),
//       'text': text,
//     };

//     firestoreCollection.add(data);
//   }
// }

// class ChatMessage extends StatelessWidget {
//   const ChatMessage({
//     Key? key,
//     required this.data,
//     required this.isMine,
//   }) : super(key: key);

//   final Map<String, dynamic> data;
//   final bool isMine;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//       child: Row(
//         children: <Widget>[
//           isMine
//               ? const SizedBox()
//               : Padding(
//                   padding: const EdgeInsets.only(right: 16),
//                   child: CircleAvatar(
//                     backgroundImage: NetworkImage(
//                       data['senderPhotoUrl'],
//                     ),
//                   ),
//                 ),
//           Expanded(
//             child: Column(
//               crossAxisAlignment:
//                   isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   data['text'],
//                   textAlign: isMine ? TextAlign.end : TextAlign.start,
//                   style: const TextStyle(fontSize: 18),
//                 ),
//                 Text(
//                   data['senderName'],
//                   style: const TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           isMine
//               ? Padding(
//                   padding: const EdgeInsets.only(left: 16),
//                   child: CircleAvatar(
//                     backgroundImage: NetworkImage(
//                       data['senderPhotoUrl'],
//                     ),
//                   ),
//                 )
//               : const SizedBox(),
//         ],
//       ),
//     );
//   }
// }

// class ChatApp extends StatelessWidget {
//   const ChatApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Chat App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: ChatScreen(),
//     );
//   }
// }

// void main() {
//   runApp(const ChatApp());
// }
