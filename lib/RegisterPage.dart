import 'package:anti_anxiety/LoginPage.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text("Welcome!", 
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
            
                  Image.asset('assets/background.png',
                  height: 300,
                  width: 300,),
            
                  // input password
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text('Email'),
                    ),
                  ),
                  // input email
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text('Password'),
                    ),
                  ),
                  
                  const RadioUsers(),

                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF01365A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                      ), 
                    child: Container(
                      height: 50,
                      width: 300,
                      child: const Center(child: Text("Sign Up"))),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginPage()
                            ));
                        }, 
                        child: const Text("Login",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),))
                    ],
                  )

              ]),
            ),
          ),
        ),
      );
  }
}

enum RoleUsers {Pasien, Dokter}

class RadioUsers extends StatefulWidget {
  const RadioUsers({super.key});

  @override
  State<RadioUsers> createState() => _RadioUsersState();
}

class _RadioUsersState extends State<RadioUsers> {
  RoleUsers? _character = RoleUsers.Pasien;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
    ],);
  }
}