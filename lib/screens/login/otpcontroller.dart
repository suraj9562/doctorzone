import 'package:doctorzone/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OtpController extends StatefulWidget {
  const OtpController({Key? key, required this.phone, required this.contCode}) : super(key: key);

  final String phone;
  final String contCode;

  @override
  _OtpControllerState createState() => _OtpControllerState();
}

class _OtpControllerState extends State<OtpController> {

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String? verificationCode;

  final BoxDecoration pinOtpDecoration = BoxDecoration(
    color: Colors.blueAccent,
    border: Border.all(
      color: Colors.grey
    ),
    borderRadius: BorderRadius.circular(10.0),
  );

  @override
  void initState() {
    super.initState();
    verifyPhone();
  }

  verifyPhone() async{
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "${widget.contCode + widget.phone}",
        verificationCompleted: (PhoneAuthCredential credential) async{
          await FirebaseAuth.instance.signInWithCredential(credential).then((value){
            if(value.user != null){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Home()));
            }
          });
        },
        verificationFailed: (FirebaseAuthException exception){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(exception.message.toString()),duration: const Duration(seconds: 2),)
           );
        },
        codeSent: (String vId, int ? resendToken){
          setState(() {
          verificationCode = vId;
          });
        },
        codeAutoRetrievalTimeout: (String vId){
          setState(() {
              verificationCode = vId;
          });
        },
      timeout: const Duration(seconds: 60),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: const Text("OTP Verification"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Verifying ${widget.contCode}-${widget.phone}........."
            ),
          ),
          const SizedBox(height: 20.0,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: PinPut(
              fieldsCount: 6,
              textStyle: TextStyle(fontSize: 25, color: Colors.white54),
              eachFieldWidth: 40.0,
              eachFieldHeight: 50.0,
              focusNode: _focusNode,
              controller: _pinEditingController,
              submittedFieldDecoration: pinOtpDecoration,
              selectedFieldDecoration: pinOtpDecoration,
              followingFieldDecoration: pinOtpDecoration,
              pinAnimationType: PinAnimationType.slide,
              onSubmit: (pin) async{
                try{
                  await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(
                      verificationId: verificationCode!, smsCode: pin)).then((value) {
                        if(value.user != null){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Home()));
                        }
                  });
                }catch(err){
                  FocusScope.of(context).unfocus();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Invalid OTP..."),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

