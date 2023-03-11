import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/CRUD.dart';
import 'package:firebase/widget/mytextfield.dart';
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
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Home Page"),
        actions: [
          GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.signOut().whenComplete(
                    () => Navigator.pushReplacementNamed(context, '/'),
                  );
            },
            child: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Text("This is a method we can access  collection"),
          SizedBox(
            height: 5,
          ),
          MyTextField(
              controller: DatabaseHelper.instance.name,
              hintText: "name",
              obscureText: false),
          SizedBox(
            height: 5,
          ),
          MyTextField(
              controller: DatabaseHelper.instance.age,
              hintText: "Age",
              obscureText: false),
          SizedBox(
            height: 5,
          ),
          Expanded(
            flex: 1,
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('user').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: Container(
                            height: 100,
                            width: 100,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator()));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text("${index + 1}"),
                          backgroundColor: Colors.black,
                        ),
                        title: Text("${data['name']}"),
                        subtitle: Text("Age : ${data['age']}"),
                        trailing: Container(
                          height: 50,
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    DatabaseHelper.instance
                                        .updateData(index: index);
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                  )),
                              IconButton(
                                onPressed: () {
                                  DatabaseHelper.instance
                                      .deleteData(index: index);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
          ),

          MaterialButton(
            onPressed: () {
              DatabaseHelper.instance.insertData();
              DatabaseHelper.instance.name.clear();
              DatabaseHelper.instance.age.clear();
            },
            child: Text("insert"),
            color: Colors.purpleAccent.shade100,
          )

          // Text("This is a method we can access a sub class of collection"),
          // Expanded(
          //   flex: 1,
          //   child: StreamBuilder(
          //       stream: FirebaseFirestore.instance.collection('user').doc(
          //           'CJ64rTiP7YsqQuUjPwnI').collection('sub_data').snapshots(),
          //       builder: (context, snapshot) {
          //         if (snapshot.hasError) {
          //           return Text('Something went wrong');
          //         }
          //         if (snapshot.connectionState == ConnectionState.waiting) {
          //           return Center(child: Container(height: 100,width: 100,alignment: Alignment.center,child: CircularProgressIndicator()));
          //         }
          //
          //         return ListView.builder(
          //           itemCount: snapshot.data!.docs.length,
          //           itemBuilder: (context, index) {
          //             var data = snapshot.data!.docs[index];
          //             return ListTile(
          //               leading: CircleAvatar(child: Text("${index + 1}"),),
          //               title: Text("${data['name']}  ${data['surname']}"),
          //               subtitle: Text("${data['age']}"),
          //
          //             );
          //           },
          //
          //         );
          //       }),
          // ),
        ],
      ),
    );
  }
}
