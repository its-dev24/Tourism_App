import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tourism_app/screens/nav.dart';

import 'login_screen.dart';
class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 1000), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Login()));
    });
    return Scaffold(
        body: Center(
          child: SpinKitFadingCube(
            color: Colors.redAccent,
            size: 70.0,
          ),
        ),
    );
  }
}
