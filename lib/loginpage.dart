import 'package:firebase/widget/myButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyButton(
              text: "Anonymous LogIn",
              onTap: () async {
                try {
                  final userCredential =
                      await FirebaseAuth.instance.signInAnonymously();
                  print("Signed in with temporary account.");
                } catch (error) {
                  print("Error : $Error");
                }
              },
            ),
            SizedBox(
              height: 30,
            ),
            MyButton(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                },
                text: "Log Out from Anonymous"),
          ],
        ),
      ),
    );
  }
}
