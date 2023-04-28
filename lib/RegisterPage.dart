// import 'package:anti_anxiety/LoginPage.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:anti_anxiety/login_register_auth/auth.dart';

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   String? errorMessage = '';

//   final TextEditingController _controllerEmail = TextEditingController();

//   final TextEditingController _controllerPassword = TextEditingController();

//   Future<void> createUserWithEmailAndPassword() async {
//     try {
//       await Auth().createUserWithEmailAndPassword(
//           email: _controllerEmail.text, password: _controllerPassword.text);
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => LoginPage(),
//         ),
//       );
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         errorMessage = e.message;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: SingleChildScrollView(
//             child: Column(children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: const [
//                   Text(
//                     "Welcome!",
//                     style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
//                   ),
//                 ],
//               ),

//               Image.asset(
//                 'assets/background.png',
//                 height: 300,
//                 width: 300,
//               ),

//               // input password
//               TextField(
//                 controller: _controllerEmail,
//                 decoration: InputDecoration(
//                   label: Text('Email'),
//                 ),
//               ),
//               // input email
//               TextField(
//                 controller: _controllerPassword,
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   label: Text('Password'),
//                 ),
//               ),

//               const RadioUsers(),

//               ElevatedButton(
//                 onPressed: () {
//                   createUserWithEmailAndPassword();
//                 },
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFF01365A),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10))),
//                 child: Container(
//                     height: 50,
//                     width: 300,
//                     child: const Center(child: Text("Sign Up"))),
//               ),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Already have account?"),
//                   TextButton(
//                       onPressed: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => LoginPage()));
//                       },
//                       child: const Text(
//                         "Login",
//                         style: TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.bold),
//                       ))
//                 ],
//               )
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
// }

// enum RoleUsers { Pasien, Dokter }

// class RadioUsers extends StatefulWidget {
//   const RadioUsers({super.key});

//   @override
//   State<RadioUsers> createState() => _RadioUsersState();
// }

// class _RadioUsersState extends State<RadioUsers> {
//   RoleUsers? _character = RoleUsers.Pasien;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ListTile(
//           title: const Text('Pasien'),
//           leading: Radio<RoleUsers>(
//             value: RoleUsers.Pasien,
//             groupValue: _character,
//             onChanged: (RoleUsers? value) {
//               setState(() {
//                 _character = value;
//               });
//             },
//           ),
//         ),
//         ListTile(
//           title: const Text('Dokter'),
//           leading: Radio<RoleUsers>(
//             value: RoleUsers.Dokter,
//             groupValue: _character,
//             onChanged: (RoleUsers? value) {
//               setState(() {
//                 _character = value;
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:anti_anxiety/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:anti_anxiety/login_register_auth/auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? errorMessage = '';

  final TextEditingController _controllerEmail = TextEditingController();

  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    "Welcome!",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                ],
              ),

              Image.asset(
                'assets/background.png',
                height: 300,
                width: 300,
              ),

              // input password
              TextField(
                controller: _controllerEmail,
                decoration: InputDecoration(
                  label: Text('Email'),
                ),
              ),
              // input email
              TextField(
                controller: _controllerPassword,
                obscureText: true,
                decoration: InputDecoration(
                  label: Text('Password'),
                ),
              ),

              // const SizedBox(height: 20),
              const RadioUsers(),

              ElevatedButton(
                onPressed: () {
                  createUserWithEmailAndPassword();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF01365A),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Container(
                    height: 50,
                    width: 300,
                    child: const Center(child: Text("Sign Up"))),
              ),

              const SizedBox(height: 20),

              Text(errorMessage == '' ? '' : 'Error: $errorMessage'),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: const Text(
                  "Already have an account? Sign In",
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

enum RoleUsers { Pasien, Dokter }

class RadioUsers extends StatefulWidget {
  const RadioUsers({super.key});

  @override
  State<RadioUsers> createState() => _RadioUsersState();
}

class _RadioUsersState extends State<RadioUsers> {
  RoleUsers? _character = RoleUsers.Pasien;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Pasien'),
          leading: Radio<RoleUsers>(
            value: RoleUsers.Pasien,
            groupValue: _character,
            onChanged: (RoleUsers? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Dokter'),
          leading: Radio<RoleUsers>(
            value: RoleUsers.Dokter,
            groupValue: _character,
            onChanged: (RoleUsers? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
