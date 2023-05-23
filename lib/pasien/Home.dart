import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:anti_anxiety/Firebase/login_register_auth/auth.dart';
import 'Detaildokter.dart';
import 'Detailberita.dart';
import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';

final User? user = Auth().currentUser;
String selectedDoctor = '';

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

int _current = 0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription<DocumentSnapshot>? connectUserSubscription;

  List<Map<String, dynamic>> _beritaList = [];

  void getBeritaList() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('informasi').get();

    setState(() {
      _beritaList = querySnapshot.docs.map((doc) {
        return {
          'judul': doc['judul'],
          'gambar': doc['gambar'],
          'konten': doc['isi'],
        };
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    checkConnectID();
    getBeritaList();
  }

  @override
  void dispose() {
    connectUserSubscription?.cancel();
    super.dispose();
  }

  void checkConnectID() async {
    final currentUserUid =
        user?.uid; // Assuming 'user' is the current user object

    if (currentUserUid != null) {
      final currentUserSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserUid)
          .get();

      if (currentUserSnapshot.exists) {
        final connectID = currentUserSnapshot['connect_id'];

        if (connectID.isNotEmpty) {
          final connectUserRef =
              FirebaseFirestore.instance.collection('users').doc(connectID);

          connectUserSubscription =
              connectUserRef.snapshots().listen((snapshot) {
            if (snapshot.exists) {
              setState(() {
                selectedDoctor = snapshot['nama'];
              });
            }
          });
        } else {
          setState(() {
            selectedDoctor = '';
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Visibility(
                    visible: selectedDoctor.isNotEmpty,
                    child: CardButton(
                      title: selectedDoctor,
                      imagePath: 'assets/psikolog.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailDokter()),
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: selectedDoctor.isEmpty,
                    child: CardButton(
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
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Visibility(
                visible: selectedDoctor.isEmpty,
                child: CardButton(
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
              ),
              SizedBox(height: 16),
              Text(
                'BERITA', // Text berita
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              CarouselSlider(
                items: _beritaList.map((berita) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text(berita['judul']),
                            content: Text(berita['konten']),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Tutup'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          berita['gambar'],
                          fit: BoxFit.cover,
                          width: 500,
                          height: 200,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
              ),
              SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _beritaList.map((berita) {
                  int index = _beritaList.indexOf(berita);
                  return Container(
                    width: 10,
                    height: 10,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          _current == index ? Colors.blueAccent : Colors.grey,
                    ),
                  );
                }).toList(),
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

    // Fetch users with the specified role and empty connect_id from Firestore
    QuerySnapshot userSnapshot;
    DocumentSnapshot selectedUser;

    do {
      userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: role)
          .where('connect_id', isEqualTo: "")
          .get();

      if (userSnapshot.docs.isEmpty) {
        selectedDoctor =
            "Maaf tidak ditemukan!"; // No user with empty connect_id found
        return; // Return without making any changes to the database
      }

      // Select a random user from the fetched list
      final randomIndex = random.nextInt(userSnapshot.docs.length);
      selectedUser = userSnapshot.docs[randomIndex];
    } while (selectedUser['connect_id'] != "");

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


//!====================================== Diatas kode yang berhasil, tapi belum diupdate realtime, jadi harus refresh aplikasi, yg bawah jelek ===========================================

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:math';
// import 'package:anti_anxiety/Firebase/login_register_auth/auth.dart';
// import 'Detaildokter.dart';
// import 'Detailberita.dart';
// import 'dart:async';

// final User? user = Auth().currentUser;
// String selectedDoctor = '';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Stack(
//                 children: [
//                   StreamBuilder<DocumentSnapshot>(
//                     stream: getConnectUserStream(),
//                     builder: (context, snapshot) {
//                       if (snapshot.hasData && snapshot.data!.exists) {
//                         final connectID = snapshot.data!['connect_id'];
//                         if (connectID.isNotEmpty) {
//                           selectedDoctor = snapshot.data!['nama'];
//                           return CardButton(
//                             title: selectedDoctor,
//                             imagePath: 'assets/psikolog.png',
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => DetailDokter(),
//                                 ),
//                               );
//                             },
//                           );
//                         }
//                       }
//                       return CardButton(
//                         title: 'Consult Now\nPsikiater',
//                         imagePath: 'assets/psikiater.png',
//                         onTap: () async {
//                           await updateConnectId('Dokter');
//                           showDialog(
//                             context: context,
//                             builder: (_) => AlertDialog(
//                               content: Text(
//                                 'Anda telah tersambung dengan dokter $selectedDoctor',
//                               ),
//                               actions: [
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   },
//                                   child: Text('Close'),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               ),

//               SizedBox(height: 16),
//               Text(
//                 'BERITA', // Text berita
//                 style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 6),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Indicators for berita carousel
//                 ],
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => DetailNews(),
//                     ),
//                   );
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

//   Stream<DocumentSnapshot> getConnectUserStream() {
//     final currentUserUid = user?.uid;
//     if (currentUserUid != null) {
//       final currentUserRef =
//           FirebaseFirestore.instance.collection('users').doc(currentUserUid);

//       return currentUserRef.snapshots();
//     }
//     return Stream.empty();
//   }

//   Future<void> updateConnectId(String role) async {
//     final random = Random();

//     // Fetch users with the specified role and empty connect_id from Firestore
//     QuerySnapshot userSnapshot;
//     DocumentSnapshot selectedUser;

//     do {
//       userSnapshot = await FirebaseFirestore.instance
//           .collection('users')
//           .where('role', isEqualTo: role)
//           .where('connect_id', isEqualTo: "")
//           .get();

//       if (userSnapshot.docs.isEmpty) {
//         selectedDoctor = "Maaf tidak ditemukan!";
//         return;
//       }

//       final randomIndex = random.nextInt(userSnapshot.docs.length);
//       selectedUser = userSnapshot.docs[randomIndex];
//     } while (selectedUser['connect_id'] != "");

//     final selectedUserId = selectedUser.id;
//     final currentUserUid = user?.uid;
//     selectedDoctor = selectedUser['nama'];

//     final currentUserSnapshot = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(currentUserUid)
//         .get();

//     if (currentUserSnapshot.exists) {
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(currentUserUid)
//           .update({'connect_id': selectedUserId});
//     }

//     await FirebaseFirestore.instance
//         .collection('users')
//         .doc(selectedUserId)
//         .update({'connect_id': currentUserUid});
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