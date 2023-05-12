import 'package:anti_anxiety/Firebase/login_register_auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardButton(
                title: 'Patient Consult',
                imagePath: 'assets/pasien.png',
                onTap: () {
                  // untuk trigger
                },
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        // untuk trigger
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFBCBCBC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Chat Pasien',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        // untuk trigger
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFBCBCBC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Consultation Notes',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 20,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    // untuk trigger
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFBCBCBC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Finish Consultation',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
