import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'edit_p.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  NetworkImage? img;
  NetworkImage? image = NetworkImage("https://cdn-icons-png.flaticon.com/512/3135/3135715.png");
  String? Name;
  String? Phn;
  String mail = "null";
  Widget build(BuildContext context) {
    getImage();
    return Scaffold(
      appBar:AppBar(
        title: Text("SETTINGS",
          style: TextStyle(
              color: Colors.black
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Column(
            children: [
              SizedBox(height: 20,),
              Container(
                height: 120,
                width: MediaQuery.of(context).size.width *.97,

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: CircleAvatar(
                        backgroundImage: image,
                        radius: 40,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20,top: 10),
                            child: Text("$Name",
                            style: TextStyle(
                              fontSize: 25
                            ),
                            ),
                          ),
                          Text("$Phn",
                            style: TextStyle(
                              fontSize: 15
                            ),
                          )
                        ],

                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Column(

                    children: [

                            //Edit Profile
                      GestureDetector(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => SettingsUI(name: Name, image: image,phn: Phn,)));
                        },
                        child: Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width *0.97,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: CircleAvatar(
                                  child: Image.asset("assets/images/user.png")
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: Text("Edit Profile",
                                style: TextStyle(
                                  fontSize: 20
                                ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      //Change Password
                      GestureDetector(
                        onDoubleTap: (){
                          FirebaseAuth.instance.sendPasswordResetEmail(email: mail);
                          Fluttertoast.showToast(msg: 'Password change email Sent');
                        },
                        child: Container(height: 70,
                          width: MediaQuery.of(context).size.width *0.97,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: Image.asset("assets/images/key.png"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: Text("Change Password",
                                  style: TextStyle(
                                      fontSize: 20
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
              ),
              SizedBox(height: 10,),
              Column(
                children: [

                  Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width *0.97,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Image.network("https://cdn-icons-png.flaticon.com/512/1161/1161388.png"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Text("Privacy",
                            style: TextStyle(
                                fontSize: 20
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      logout();
                    },
                    child: Container(height: 70,
                      width: MediaQuery.of(context).size.width *0.97,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Image.asset("assets/images/logout.png"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: Text("Log Out",
                              style: TextStyle(
                                  fontSize: 20
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      openDialog();
                    },
                    child: Container(height: 70,
                      width: MediaQuery.of(context).size.width *0.97,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Image.asset("assets/images/delete-account.png"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: Text("Delete Account",
                              style: TextStyle(
                                  fontSize: 20
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width * 0.97,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.transparent,
                    child: Image.asset("assets/images/twitter.png"),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent,
                    child: Image.asset("assets/images/instagram.png"),
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.transparent,
                    child: Image.network("https://cdn-icons-png.flaticon.com/512/5968/5968764.png"),
                  ),
                ],
              ),
            )
            ],
          ),
        )
        ),
      );

  }
  void logout(){
    FirebaseAuth.instance.signOut();
    Fluttertoast.showToast(msg: "Logged Out");
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => Login()));
  }
  Future getImage() async {

    String uid= FirebaseAuth.instance.currentUser!.uid;
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc('$uid').get();
      var data = docSnapshot.data() as Map;
      var v = data?['image'];
      var n = data?['name'];
      var e = data?['phn'];
      var reset = data?['email'];
      img = NetworkImage('$v');
      // print(img);
      setState(() {
        image = img;
      });
    setState(() {
      Name = n;
    });
    setState(() {
      Phn = e;
    });
    setState(() {
      mail = reset;
    });

  }
  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are You Sure?"),
        actions: [
          ElevatedButton(
              onPressed: ()async{
                User? user = await FirebaseAuth.instance.currentUser!;
                user.delete();
                Fluttertoast.showToast(msg: "Account Deleted");
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Login()));
              },
              child: Text("Yes"))
        ],

      )
  );

}

