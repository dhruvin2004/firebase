import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.signOut().whenComplete(
                      () => Navigator.pushReplacementNamed(context, '/'));
            },
            child: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text("This is a method we can access  collection"),
          Expanded(
            flex: 1,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('user').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      return ListTile(
                        leading: CircleAvatar(child: Text("${index + 1}"),),
                        title: Text("${data['name']}"),
                        subtitle: Text("${data['age']}"),

                      );
                    },

                  );
                }),
          ),

          Text("This is a method we can access a sub class of collection"),
          Expanded(
            flex: 1,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('user').doc('CJ64rTiP7YsqQuUjPwnI').collection('sub_data').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
                  
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      return ListTile(
                        leading: CircleAvatar(child: Text("${index + 1}"),),
                        title: Text("${data['name']}  ${data['surname']}"),
                        subtitle: Text("${data['age']}"),

                      );
                    },

                  );
                }),
          ),
        ],
      ),
    );
  }
}
