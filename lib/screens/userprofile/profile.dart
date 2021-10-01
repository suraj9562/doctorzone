import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Profile',
          style: TextStyle(
            letterSpacing: 1.6,
          ),),
        backgroundColor: Colors.grey[800],
        centerTitle:true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/suraj.jpg'),
                radius: 50.0,
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'Name :',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  letterSpacing: 1.4
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Suraj Wadikar',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                  color: Colors.amber,
                  letterSpacing: 1.6
              ),
            ),
            SizedBox(height: 30.0,),
            Text(
              'Age :',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  letterSpacing: 1.4
              ),
            ),
            SizedBox(height: 10.0,),
            Text(
              '19',
              style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                  letterSpacing: 1.6
              ),
            ),
            SizedBox(height: 30.0,),
            Text(
              'Status :',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                letterSpacing:1.4,
              ),
            ),
            SizedBox(height: 10.0,),
            Text(
              'Single',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
                letterSpacing: 1.6,
              ),
            ),
            SizedBox(height: 30.0,),
            Row(
              children: [
                Icon(
                  Icons.email_outlined,
                  color: Colors.grey,
                ),
                SizedBox(width: 10.0,),
                Text(
                  'Email :',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    letterSpacing: 1.4,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0,),
            Text(
              'wadikarsuraj02@gmail.com',
              style: TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.4,
                fontSize: 22.0,
              ),
            ),
            SizedBox(height: 30.0,),
            Center(
              child: FlatButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.update_outlined,
                ),
                label: Text(
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
