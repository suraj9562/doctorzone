import 'package:doctorzone/screens/home.dart';
import 'package:doctorzone/screens/login/startscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleProcessingScreen extends StatefulWidget {
  const GoogleProcessingScreen({Key? key}) : super(key: key);

  @override
  _GoogleProcessingScreenState createState() => _GoogleProcessingScreenState();
}

class _GoogleProcessingScreenState extends State<GoogleProcessingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else if(snapshot.hasData){
            return const Home();
          }else if(snapshot.hasError){
            return const Center(
              child: Text('Something Went Wrong'),
            );
          }else{
            return const StartScreen();
          }
          }
      ),
    );
  }
}


