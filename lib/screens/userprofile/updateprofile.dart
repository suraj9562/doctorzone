import 'package:doctorzone/screens/db/usermanagement.dart';
import 'package:doctorzone/screens/home.dart';
import 'package:flutter/material.dart';

class TakeInfo extends StatefulWidget {
  const TakeInfo({Key? key}) : super(key: key);

  @override
  _TakeInfoState createState() => _TakeInfoState();
}

class _TakeInfoState extends State<TakeInfo> {

  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Male"),value: "Male"),
      const DropdownMenuItem(child: Text("Female"),value: "Female"),
    ];
    return menuItems;
  }
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile Info"),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(top: 20),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:  CrossAxisAlignment.center,
              children: [
                Container(
                  padding:const EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(
                      hintText: "Enter You Name",
                      prefixIcon: Icon(
                        Icons.account_circle_outlined
                      ),
                      border: OutlineInputBorder()
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(height:5),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: DropdownButtonFormField(
                      decoration:  InputDecoration(
                        hintText: "Select Gender",
                        enabledBorder: OutlineInputBorder(
                          // borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                      dropdownColor: Colors.white,
                      value: selectedValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                      items: dropdownItems),
                ),
               const SizedBox(height: 5,),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _phone,
                    decoration: const InputDecoration(
                      hintText: "Enter Your Contact No.",
                      prefixIcon: Icon(
                        Icons.contact_phone_outlined
                      ),
                      border: OutlineInputBorder()
                    ),
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                  ),
                ),
               const SizedBox(height:5),
                Container(
                  padding : const EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                      hintText: "Enter Your E-mail Id",
                      prefixIcon: Icon(
                        Icons.mail_outline
                      ),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                  ),
                ),
               const SizedBox(height: 20.0,),
                Container(
                  height: 50,
                  width: double.infinity,
                  margin:const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.greenAccent, Colors.lightGreen],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: TextButton(
                    onPressed: () async{
                      await setUserByMobile(_name.text, _phone.text, _email.text, selectedValue.toString());
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Home()));
                    },
                    child: const Text("Proceed"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
