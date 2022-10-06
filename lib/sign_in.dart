import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_truck/dashboard_sreen.dart';
import 'package:flutter_truck/home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var email, password;
  GlobalKey<FormState> formState = new GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset("assets/images/truck.png"),
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
                  Row(
                    children: [
                      Container(
                        child: ElevatedButton(
                            onPressed: () async {
                              var user = await signIn();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()),
                              );
                            },
                            child: Text("Sign In")),
                      ),
                      Container(
                        child: ElevatedButton(
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DashboardScreen()),
                              );
                            },
                            child: Text("Admin")),
                      ),
                    ],
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
