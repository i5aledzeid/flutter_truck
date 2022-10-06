import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List tasks = [];
  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection("Orders");

  getUser() {
    var currentUser = FirebaseAuth.instance.currentUser;
    print("Current User: ${currentUser?.email}");
  }

  getData() async {
    // initialze responseBody to get all docs of collections
    var responseBody = await _collectionReference.get();
    responseBody.docs.forEach(
      (element) {
        setState(() {
          tasks.add(element.data());
        });
      },
    );
    print("getData: $tasks");
  }

  addCollection() async {
    CollectionReference addCollectionReference =
        FirebaseFirestore.instance.collection("Tasks");
    var result = await addCollectionReference.add({
      'uid': '123',
      'title': 'title task',
    });
    // addMultipleCollection(id: result.id);
    addEmptyMultipleCollection(id: result.id);
    return '$result created';
  }

  addMultipleCollection({String? id}) async {
    CollectionReference addMultipleCollectionReference =
        FirebaseFirestore.instance.collection("Tasks");
    addMultipleCollectionReference.doc(id).collection("Confirm Task").add({
      'id': id,
      'title': 'title confirm task',
      'confirm date': DateTime.now(),
    });
  }

  addEmptyMultipleCollection({String? id}) async {
    CollectionReference addEmptyMultipleCollectionReference =
        FirebaseFirestore.instance.collection("Tasks");
    addEmptyMultipleCollectionReference.doc(id).collection("Confirm Task").add({
      'id': id,
      'username': id,
      'title': '',
      'confirm date': '' /*DateTime.now()*/,
    });
    addEmptyMultipleCollectionReference.doc(id).collection("Task").add({
      'id': id,
      'username': id,
      'title': '',
      'create date': '' /*DateTime.now()*/,
    });
    print("addEmptyMultipleCollection: $id");
  }

  insertMultipleCollection({String? id}) {
    var updateCollection = FirebaseFirestore.instance.collection("Tasks");
    updateCollection.doc(id).set({
      'uid': '123',
      'title': 'title task',
    });
    print("insertMultipleCollection");
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    addCollection();
    // addMultipleCollection();
    // addEmptyMultipleCollection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text("Tasks Page ${getUser()}"),
        centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            //
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Scheduled Tasks',
                  ),
                ],
              ),
            ),
            //
            Expanded(
              child: StreamBuilder(
                stream: _collectionReference.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      // itemCount: tasks.length,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        // return Text("Car Number: ${tasks[index]['car number']}");
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                          child: Container(
                            width: 100,
                            height: 150,
                            decoration: BoxDecoration(
                              // color: FlutterFlowTheme.of(context).secondaryBackground,
                              color: Color(0xFFB2D0D5),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 8, 16, 0),
                                    child: Text(
                                      "Uid: ${snapshot.data?.docs[index].reference.id.toString()}",
                                      // style: FlutterFlowTheme.of(context).bodyText1,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 8, 16, 0),
                                    child: Text(
                                      "Car Number: ${snapshot.data?.docs[index]['car number']}",
                                      // style: FlutterFlowTheme.of(context).bodyText1,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 8, 16, 0),
                                    child: Text(
                                      "Start Point: ${snapshot.data?.docs[index]['start location']}",
                                      // style: FlutterFlowTheme.of(context).bodyText1,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 8, 16, 0),
                                    child: Text(
                                      "End Point: ${snapshot.data?.docs[index]['end location']}",
                                      // style: FlutterFlowTheme.of(context).bodyText1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                        // return Text("Car Number: ${snapshot.data?.docs[index]['car number']}");
                      },
                    );
                  }
                  return Text("Loading..");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
