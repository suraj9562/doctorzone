import 'package:doctorzone/components/heading.dart';
import 'package:doctorzone/components/subheading.dart';
import 'package:doctorzone/screens/userprofile/updateprofile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  Profile({Key? key, required this.email, required this.name}) : super(key: key);

  String name ;
  String email ;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String uid  = FirebaseAuth.instance.currentUser!.uid;

  String sex = "Loading....";
  String contact = "Loading....";

  void getDataLater() async{
    await FirebaseFirestore.instance
        .collection('/users')
        .doc(uid)
        .collection('/personalInfo')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        setState(() {
          sex = result['sex'];
          contact = result['phone'];
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getDataLater();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'Profile',
          style: TextStyle(
            letterSpacing: 1.6,
          ),
        ),
        backgroundColor: Colors.grey[800],
        centerTitle: true,
      ),
      body:
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Center(
                  child: CircleAvatar(
                    child: Text(
                      widget.name[0],
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    radius: 50.0,
                    backgroundColor: Colors.amber,
                  ),
                ),
                const SizedBox(height: 30.0),
                Heading(
                  title: "Name",
                ),
                const SizedBox(height: 10.0),
                SubHeading(
                  subtitle: widget.name,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Heading(
                  title: "Contact No.",
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SubHeading(
                  subtitle: contact,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Heading(
                  title: "Sex",
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SubHeading(
                  subtitle: sex,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Heading(
                      title: "Email-Id",
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SubHeading(
                  subtitle: widget.email,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: FlatButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TakeInfo()));
                    },
                    icon: const Icon(
                      Icons.update_outlined,
                    ),
                    label: const Text(
                      'Update Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
