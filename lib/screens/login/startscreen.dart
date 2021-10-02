import 'package:doctorzone/screens/db/usermanagement.dart';
import 'package:doctorzone/screens/home.dart';
import 'package:doctorzone/screens/login/otpcontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  String contCode = "+91";
  final storage = new FlutterSecureStorage();

  final googleSignIn = GoogleSignIn();

  late GoogleSignInAccount _user;
  GoogleSignInAccount get user => _user;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      User? p = FirebaseAuth.instance.currentUser;
      await storage.write(key: 'uid', value: p!.uid);
      await setUserByEmail(p.email.toString(), p.displayName.toString());
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Colors.lightBlue],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Logo",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "DotorZone",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    decoration: const BoxDecoration(),
                    child: const Image(
                      image: AssetImage('images/1.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.limeAccent],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      children: [
                        CountryCodePicker(
                          onChanged: (country) {
                            setState(() {
                              contCode = country.dialCode!;
                            });
                          },
                          initialSelection: "IN",
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: "Enter Your No.",
                            prefix: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(contCode),
                            ),
                            prefixIcon: const Icon(
                              Icons.contact_phone_outlined,
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _textEditingController,
                          maxLength: 10,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.green, Colors.greenAccent],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            ),
                            border: Border.all(
                                color: Colors.black45,
                                style: BorderStyle.solid),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OtpController(
                                            phone: _textEditingController.text,
                                            contCode: contCode,
                                          )));
                            },
                            child: const Text(
                              "Continue",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        const Text(
                          "Or Quick Start...",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.green, Colors.greenAccent],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            ),
                            border: Border.all(
                                color: Colors.black45,
                                style: BorderStyle.solid),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: TextButton(
                            onPressed: () async{
                              await googleLogin();
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home()));
                            },
                            child: const Text(
                              "Login With E-Mail",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
