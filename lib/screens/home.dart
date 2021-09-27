import 'package:doctorzone/screens/login/startscreen.dart';
import 'package:doctorzone/screens/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final storage = new FlutterSecureStorage();
  final googleSignIn = GoogleSignIn();

  void logOut() {
    googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Abc"),
              accountEmail: Text("Abc"),
              currentAccountPicture: CircleAvatar(
                child: Text(
                  "A",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                backgroundColor: Colors.black45,
              ),
              decoration: BoxDecoration(color: Colors.amber),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle_outlined),
              title: const Text("Profile"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Profile()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Log Out"),
              onTap: () {
                logOut();
                storage.delete(key: 'uid');
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>StartScreen()), (route) => false);
              },
            )
          ],
        ),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.green, Colors.greenAccent],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            border: Border.all(color: Colors.black45, style: BorderStyle.solid),
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          ),
          child: TextButton(
            onPressed:(){
              print("Smile Please");
            } ,
            child: const Text("Log Out"),
          ),
        ),
      ),
    );
  }
}
