import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                "Home Page",
                style: TextStyle(fontSize: 40, color: Colors.black),
              ),
              RaisedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pop();
                },
                child: Text("Log-Out"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
