import 'package:firebase/widget/myButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Home Page"),
        centerTitle: true,
      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyButton(
                onTap: () async {
                  await FirebaseAuth.instance.signOut().whenComplete(() =>Navigator.pushReplacementNamed(context, '/'));
                },
                text: "Log Out"),
          ],
        )
      ),
    );
  }
}
