// import 'package:anti_anxiety/Firebase/login_register_auth/auth.dart';
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:anti_anxiety/LoginPage.dart';
// import 'Detaildokter.dart';
// import 'Detailberita.dart';

// List<Map<String, dynamic>> _beritaList = [
//   {
//     'judul': 'Berita 1',
//     'gambar': 'https://picsum.photos/id/102/400/200',
//     'konten':
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
//   },
//   {
//     'judul': 'Berita 2',
//     'gambar': 'https://picsum.photos/id/102/400/200',
//     'konten':
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
//   },
//   {
//     'judul': 'Berita 3',
//     'gambar': 'https://picsum.photos/id/102/400/200',
//     'konten':
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
//   },
//   {
//     'judul': 'Berita 4',
//     'gambar': 'https://picsum.photos/id/102/400/200',
//     'konten':
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
//   },
//   {
//     'judul': 'Berita 5',
//     'gambar': 'https://picsum.photos/id/102/400/200',
//     'konten':
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
//   },
// ];

// int _current = 0;

// final User? user = Auth().currentUser;

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   // Future<void> signOut() async {
//   //   Auth auth = Auth();
//   //   await auth.signOut();
//   //   // Navigate to login page after signing out
//   //   Navigator.pushReplacement(
//   //     context,
//   //     MaterialPageRoute(builder: (context) => LoginPage()),
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               CardButton(
//                 title: 'Consult Now\nPsikolog',
//                 imagePath: 'assets/psikolog.png',
//                 onTap: () {
//                   Navigator.of(context).push(
//                       MaterialPageRoute(builder: (context) => DetailDokter()));
//                 },
//               ),
//               SizedBox(height: 16),
//               CardButton(
//                 title: 'Consult Now\nPsikiater',
//                 imagePath: 'assets/psikiater.png',
//                 onTap: () {
//                   Navigator.of(context).push(
//                       MaterialPageRoute(builder: (context) => DetailDokter()));
//                 },
//               ),
//               SizedBox(height: 16),
//               Text(
//                 'BERITA', // Text berita
//                 style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//               CarouselSlider(
//                 items: _beritaList.map((berita) {
//                   return GestureDetector(
//                     onTap: () {
//                       showDialog(
//                         context: context,
//                         builder: (_) {
//                           return AlertDialog(
//                             title: Text(berita['judul']),
//                             content: Text(berita['konten']),
//                             actions: [
//                               ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: Text('Tutup'),
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     },
//                     child: Container(
//                       margin: EdgeInsets.all(5),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.network(
//                           berita['gambar'],
//                           fit: BoxFit.cover,
//                           width: 500,
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//                 options: CarouselOptions(
//                   autoPlay: true,
//                   enlargeCenterPage: true,
//                   aspectRatio: 2.0,
//                   onPageChanged: (index, reason) {
//                     setState(() {
//                       _current = index;
//                     });
//                   },
//                 ),
//               ),
//               SizedBox(height: 6),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: _beritaList.map((berita) {
//                   int index = _beritaList.indexOf(berita);
//                   return Container(
//                     width: 10,
//                     height: 10,
//                     margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color:
//                           _current == index ? Colors.blueAccent : Colors.grey,
//                     ),
//                   );
//                 }).toList(),
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.of(context).push(
//                       MaterialPageRoute(builder: (context) => DetailNews()));
//                 },
//                 child: Text(
//                   'Selengkapnya..', // Text berita
//                   style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.center,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CardButton extends StatelessWidget {
//   final String title;
//   final String imagePath;
//   final VoidCallback onTap;

//   const CardButton({
//     Key? key,
//     required this.title,
//     required this.imagePath,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       child: InkWell(
//         onTap: onTap,
//         child: Container(
//           height: 160,
//           width: double.infinity,
//           padding: EdgeInsets.all(16),
//           child: Row(
//             children: [
//               Image.asset(
//                 imagePath,
//                 height: 95,
//                 width: 95,
//               ),
//               SizedBox(width: 16),
//               Text(
//                 title,
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:anti_anxiety/Firebase/login_register_auth/auth.dart';
import 'Detaildokter.dart';
import 'Detailberita.dart';

final User? user = Auth().currentUser;
String selectedDoctor = '';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardButton(
                title: 'Consult Now\nPsikolog',
                imagePath: 'assets/psikolog.png',
                onTap: () async {
                  await updateConnectId('Dokter');
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      content: Text(
                          'Anda telah tersambung dengan dokter $selectedDoctor'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              CardButton(
                title: 'Consult Now\nPsikiater',
                imagePath: 'assets/psikiater.png',
                onTap: () async {
                  await updateConnectId('Dokter');
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      content: Text(
                          'Anda telah tersambung dengan dokter $selectedDoctor'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              Text(
                'BERITA', // Text berita
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              // CarouselSlider and other berita-related code
              SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Indicators for berita carousel
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DetailNews()));
                },
                child: Text(
                  'Selengkapnya..', // Text berita
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateConnectId(String role) async {
    final random = Random();

    // Fetch users with the specified role from Firestore
    final userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: role)
        .get();

    if (userSnapshot.docs.isEmpty) {
      return; // No user with the specified role found
    }

    // Select a random user from the fetched list
    final randomIndex = random.nextInt(userSnapshot.docs.length);
    final selectedUser = userSnapshot.docs[randomIndex];
    final selectedUserId = selectedUser.id;
    final currentUserUid =
        user?.uid; // Assuming 'user' is the current user object
    selectedDoctor = selectedUser['nama'];

    // Fetch the document for the current user
    final currentUserSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserUid)
        .get();

    if (currentUserSnapshot.exists) {
      // Update the 'connect_id' field for the current user
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserUid)
          .update({'connect_id': selectedUserId});
    }

    // Update the 'connect_id' field for the selected user
    await FirebaseFirestore.instance
        .collection('users')
        .doc(selectedUserId)
        .update({'connect_id': currentUserUid});
  }
}

class CardButton extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const CardButton({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 160,
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Image.asset(
                imagePath,
                height: 95,
                width: 95,
              ),
              SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
