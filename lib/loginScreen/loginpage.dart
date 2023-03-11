import 'package:firebase/widget/myButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../widget/mytextfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController lemail = TextEditingController();
  TextEditingController lpassword = TextEditingController();

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  final _formKey = GlobalKey<FormState>();


  Future signUserIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: lemail.text,
      password: lpassword.text,
    );

  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    lemail.dispose();
    lpassword.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Icon(Icons.android,size: 180,),
                MyTextField(controller: lemail, hintText: 'Email',obscureText: false),
                SizedBox(height: 20,),
                MyTextField(controller: lpassword, hintText: 'Password',obscureText: false),
                SizedBox(height: 20,),
                MyButton(
                  text: "LogIn",
                  onTap: ()  {
                    signUserIn();
                  },
                ),
                SizedBox(height: 20,),
                MyButton(
                  text: "Google SignIn",
                  onTap: ()  {
                    signInWithGoogle();
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
