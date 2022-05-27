import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tourism_app/screens/reg_screen.dart';
import 'package:flutter/material.dart';
import 'package:tourism_app/Reusable/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'nav.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override

  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  final prefs =  SharedPreferences.getInstance();
  Widget build(BuildContext context) {
    var hgt= MediaQuery.of(context).size.height;
    var wdt= MediaQuery.of(context).size.width;
    if(FirebaseAuth.instance.currentUser!=null){
      return Home_Screen();
    }
    else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: hgt,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/login2.jpg'),
                fit: BoxFit.fill
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              height: hgt * 2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: hgt * 0.18,
                    ),
                    Center(
                      child: CircleAvatar(
                        foregroundImage: AssetImage("assets/images/logo.jpg"),
                        backgroundColor: Colors.white,
                        radius: 45.0,
                      ),
                    ),
                    SizedBox(
                      height: hgt * 0.05,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(50)
                      ),
                      width: wdt * 0.9,
                      height: hgt * 0.5,
                      child: Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                            children: [
                              SizedBox(
                                height: hgt * 0.09,
                              ),

                              SizedBox(

                                width: 300.0,

                                child: reusableEmailTextFiled(
                                    "Username", Icons.person_outlined, false,
                                    _emailTextController),
                              ),
                              SizedBox(
                                height: hgt * 0.05,
                              ),
                              SizedBox(

                                width: 300.0,

                                child: reusablePassTextFiled(
                                    "Password", Icons.vpn_key_outlined, true,
                                    _passwordTextController),
                              ),
                              SizedBox(
                                height: hgt * 0.07,
                              ),
                              signInSignOut(context, true, () {

                                FirebaseAuth.instance.signInWithEmailAndPassword(
                                    email: _emailTextController.text.trim(),
                                    password: _passwordTextController.text.trim())
                                    .then((value) {
                                  Fluttertoast.showToast(msg: "Login Sucessfull");
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => Home_Screen()));
                                }).catchError((e){
                                  Fluttertoast.showToast(msg: e!.message);
                                });
                              }),
                              SizedBox(
                                  height: hgt * 0.07,
                                  child: reg()
                              ),
                            ]),
                      ),
                    ),

                  ],

                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  Container reg(){
    return Container(
      width: 250,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Dont Have An Account?    "),
          GestureDetector(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> RegScreen()));
            },
            child: const Text("SignUP?",
              style: TextStyle(color: Color(0xff7FD1AE), fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

