import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../Models/Travel.dart';

class ImagePull {

  QuerySnapshot? data;
  Future<List> fetchImages() async{


    List value = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Places').get();
    value = querySnapshot.docs.map((doc) => doc.data()).toList();
    // print(value);
    return value.toList();
  }

}