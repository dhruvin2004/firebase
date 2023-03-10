
import 'package:firebase/widget/myButton.dart';
import 'package:firebase/widget/mytextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController rpassword = TextEditingController();
  TextEditingController remail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register Page",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextField(
                controller: remail, hintText: "Email", obscureText: false),
            SizedBox(
              height: 20,
            ),
            MyTextField(
                controller: rpassword, hintText: "Password", obscureText: false),
            SizedBox(
              height: 20,
            ),
            MyButton(
                text: "Sign Up",
                onTap: () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: remail.text, password: rpassword.text);
                  remail.clear();
                  rpassword.clear();
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("You are already member?",style: TextStyle(fontWeight: FontWeight.bold),),
                TextButton(onPressed: (){
                  setState(() {
                    Navigator.pushReplacementNamed(context, 'login');
                  });
                }, child: Text("Sign In"),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}