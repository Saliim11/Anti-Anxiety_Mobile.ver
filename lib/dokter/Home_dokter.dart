import 'package:anti_anxiety/login_register_auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';

List<Map<String, dynamic>> _beritaList = [
  {
    'judul': 'Berita 1',
    'gambar': 'https://picsum.photos/id/102/400/200',
    'konten':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
  },
  {
    'judul': 'Berita 2',
    'gambar': 'https://picsum.photos/id/102/400/200',
    'konten':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
  },
  {
    'judul': 'Berita 3',
    'gambar': 'https://picsum.photos/id/102/400/200',
    'konten':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
  },
  {
    'judul': 'Berita 4',
    'gambar': 'https://picsum.photos/id/102/400/200',
    'konten':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
  },
  {
    'judul': 'Berita 5',
    'gambar': 'https://picsum.photos/id/102/400/200',
    'konten':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
  },
];

int _current = 0;

final User? user = Auth().currentUser;

class HomePageDokter extends StatefulWidget {
  const HomePageDokter({super.key});

  @override
  State<HomePageDokter> createState() => _HomePageDokterState();
}

class _HomePageDokterState extends State<HomePageDokter> {
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
                title: 'Consult Now\nPatient',
                imagePath: 'assets/pasien.png',
                onTap: () {
                  // untuk trigger
                },
              ),
              SizedBox(height: 180),
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
                onTap: () {},
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
