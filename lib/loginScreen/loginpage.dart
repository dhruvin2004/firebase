import 'package:firebase/AppString.dart';
import 'package:firebase/widget/myButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widget/mytextfield.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                MyTextField(controller: lemail, hintText: 'Email',obscureText: false),
                SizedBox(height: 20,),
                MyTextField(controller: lpassword, hintText: 'Password',obscureText: false),
                SizedBox(height: 20,),
                MyButton(
                  text: "LogIn",
                  onTap: () async {
                    FirebaseAuth.instance.signInWithEmailAndPassword(email: lemail.text, password: lpassword.text).whenComplete(() => Navigator.pushReplacementNamed(context, 'home'));
                    lemail.clear();
                    lpassword.clear();
                  },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not yet member?",style: TextStyle(fontWeight: FontWeight.bold),),
                    TextButton(onPressed: (){
                      setState(() {
                        Navigator.pushReplacementNamed(context, 'register');
                      });
                    }, child: Text("Create a account"))
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
