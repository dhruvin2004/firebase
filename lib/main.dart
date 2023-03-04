
import 'package:firebase/homepage.dart';
import 'package:firebase/loginScreen/Register.dart';
import 'package:firebase/loginScreen/loginpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     routes: {
       '/' : (context) => LoginPage(),
       'home' : (context) => HomePage(),
       'register' : (context) => RegisterPage(),
     },
    );
  }
}
