import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:tourism_app/screens/sub-screens/bookings.dart';
import 'package:tourism_app/screens/sub-screens/buisness.dart';
import 'package:tourism_app/screens/sub-screens/home_screen.dart';
import 'package:tourism_app/screens/sub-screens/places.dart';
import 'package:tourism_app/screens/sub-screens/profile.dart';
import 'login_screen.dart';
class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);


  @override
  _Home_ScreenState createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {

  int index = 2;
  final screens = [
    Bookings(),
    Places(),
    Home(),
    Buisness(),
    Profile()

  ];
  @override
  Widget build(BuildContext context) {
    //Nav Bar
    final item = <Widget>[
      Icon(Icons.check_circle_outline ),
      Icon(Icons.place_outlined),
      Icon(Icons.home_filled),
      Icon(Icons.business),
      Icon(Icons.person),
    ];


    return SafeArea(
      child: Scaffold(
        extendBody: true,
      backgroundColor: Colors.redAccent,
      bottomNavigationBar: CurvedNavigationBar(
        items: item,
        index: index,
        backgroundColor: Colors.transparent,
        onTap: (index) => setState(() => this.index = index),
      ),
        body: screens[index]
      ),
    );
  }
}
