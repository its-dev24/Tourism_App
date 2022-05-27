import 'dart:io';
import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tourism_app/Models/user_model.dart';
import 'package:tourism_app/Reusable/reusable_widget.dart';
import 'package:tourism_app/screens/nav.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  FirebaseStorage storage = FirebaseStorage.instance;
  String? downloadURL;
  ImagePicker picker = ImagePicker();
  File? _image;
  Future getimage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        _image = File(image.path);
        print('inside');
      } else {
        Fluttertoast.showToast(msg: 'No image selected');
      }
    });
  }
  @override
  TextEditingController _usernameTextController = new TextEditingController();
  TextEditingController _emailTextController = new TextEditingController();
  TextEditingController _passwordTextController = new TextEditingController();
  TextEditingController _cPasswordTextController = new TextEditingController();
  TextEditingController _PhnTextController = new TextEditingController();
  Widget build(BuildContext context) {
    var wdt = MediaQuery.of(context).size.width;
    var hgt = MediaQuery.of(context).size.height;


    Future getimage2()async{
      final image = await picker.pickImage(source: ImageSource.camera);
    };
    return Scaffold(


        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: hgt*0.34,
                  width: wdt,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/regpic.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),


                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)
                  ),

                  height: MediaQuery.of(context).size.height*0.7,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      children:[
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children:[
                            SizedBox(
                              width: 40,
                            ),
                            CircleAvatar(
                                  radius: 45,
                                  backgroundImage:  (_image == null)
                                      ? AssetImage("assets/images/team.png",

                                  ) as ImageProvider
                                      : FileImage(_image!,

                                  ) as ImageProvider,
                            ),
                            SizedBox(
                                width: 30,),
                            Form(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              child: Column(
                                children: [
                                  ElevatedButton(

                                    onPressed:getimage,
                                    child: Text('Select Image From Gallery '),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      onPrimary: Colors.grey,
                                      elevation: 0,
                                      side: BorderSide(
                                        width: 1,
                                        color: Colors.black,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed:getimage2,
                                    child: Text('Select Image From Camera'),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      onPrimary: Colors.grey,
                                      elevation: 0,
                                      side: BorderSide(
                                        width: 1,
                                        color: Colors.black,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]
                        ),

                        SizedBox(
                          height: 45,
                        ),
                        
                        SizedBox(

                            width: 320,
                            child: reusableEmailTextFiled("Enter Name", Icons.person_outline, false, _usernameTextController)
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(

                            width: 320,
                            child: reusableEmailTextFiled("Enter Email", Icons.email_outlined, false, _emailTextController)
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(

                            width: 320,
                            child: reusableEmailTextFiled("Enter Phone", Icons.phone, false, _PhnTextController)
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(

                            width: 320,
                            child: reusablePassTextFiled("Enter Password", Icons.vpn_key_outlined, true, _passwordTextController)
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(

                            width: 320,
                            child: reusablePassTextFiled("Confirm Password", Icons.vpn_key_outlined, true, _cPasswordTextController)
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(

                          width: 320,
                          child: signInSignOut(context, false, () {

                            if(_passwordTextController.text.trim()!= _cPasswordTextController.text.trim()){
                                  Fluttertoast.showToast(msg: 'Password does not match');
                            }
                            else {
                              FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                  email: _emailTextController.text.trim(),
                                  password: _passwordTextController.text.trim())
                                  .then((value) {
                                    postDetailsToFirestore();
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => Home_Screen()));
                              }).catchError((e){
                                Fluttertoast.showToast(msg: e!.message);
                              });
                            }
                          }),
                        ),


                      ]
                  ),
                ),
              ],
            ),
          ),
        ),
      
    );
  }
  postDetailsToFirestore() async{
  //call firebase firestore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    UserModel userModel = UserModel();

    //writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = _usernameTextController.text.trim();
    userModel.phn = _PhnTextController.text.trim();
    Reference reference = storage.ref().child("Users/${user.uid}/");
    await reference.putFile(_image!);
    downloadURL = await reference.getDownloadURL();
    userModel.image = downloadURL;
    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.toMap());
        Fluttertoast.showToast(msg: 'Account Created Sucessfully');


  }
}
