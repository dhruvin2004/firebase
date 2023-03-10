
import 'package:firebase/homepage.dart';
import 'package:firebase/loginScreen/Register.dart';
import 'package:firebase/loginScreen/loginpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'main_page.dart';


Future<void> main() async{
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
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
      theme: ThemeData(
        useMaterial3: true
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
     routes: {
       '/' : (context) => MainPage(),
       'login' : (context) => LoginPage(),
       'home' : (context) => HomePage(),
       'register' : (context) => RegisterPage(),
     },
    );
  }
}
