import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var email, password;
  GlobalKey<FormState> formState = new GlobalKey<FormState>();
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("Tasks");

  getCollectionUid() {
    var currentCollectionUid = collectionReference.doc().id;
    print(currentCollectionUid);
  }

  signIn() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      print("validate");
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: "i5aledzeid@gmail.com",
          password: "i5aledzeid1996#",
        );
      } on FirebaseAuthException catch (e) {
        print(e.toString());
      }
    } else {
      print("not validate");
    }
    print("sin in");
  }

  insertMultipleCollection({String? id}) {
    CollectionReference updateCollection =
        FirebaseFirestore.instance.collection("Tasks");
    var uid = updateCollection.id;
    updateCollection.doc(uid).set({
      'uid': '123',
      'title': 'title task update',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset("assets/images/king.png"),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: formState,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    child: ElevatedButton(
                        onPressed: () async {
                          /*var user = await signIn();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                          );*/
                          getCollectionUid();
                        },
                        child: Text("Add")),
                  ),
                  Container(
                    child: ElevatedButton(
                        onPressed: () async {
                          /*var user = await signIn();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                          );*/
                          insertMultipleCollection(id: '0');
                          print("updated");
                        },
                        child: Text("Update")),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
