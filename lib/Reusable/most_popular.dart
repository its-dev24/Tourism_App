

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'detail_page.dart';
class MostPopular extends StatefulWidget {


  @override
  State<MostPopular> createState() => _MostPopularState();
}

class _MostPopularState extends State<MostPopular> {
  final Stream<QuerySnapshot> places = FirebaseFirestore.instance.collection('Places').where('District',isEqualTo: 'Idukki').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: places,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something Went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.redAccent,
              ),
            );
          }
          final data = snapshot.requireData;
          var len = snapshot.data!.size;

          return ListView.separated(
            scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 15,right: 15,bottom: 15),
              itemBuilder: (context, index) {
                String img = data.docs[index]['image'];
                String name = data.docs[index]['Name'];
                String dis =  data.docs[index]['District'];
                String desc =  data.docs[index]['Descrption'];
                String img1 = data.docs[index]['fimg1'];
                String img2 = data.docs[index]['fimg2'];
                String img3= data.docs[index]['fimg3'];
            return GestureDetector(
              onTap: () async =>
              await Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(image:img ,name: name, district: dis, desc: desc,img1: img1,img2: img2,img3: img3,))),
              child: Stack(
                children: [
                  ClipRRect(
                    child: Image.network('${data.docs[index]['image']}',
                    height: 140,
                    width: 140,
                    fit: BoxFit.cover,),
                    borderRadius: BorderRadius.circular(5),

                  ),
                  Positioned(
                      bottom: 100,
                      left: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: Text('${data.docs[index]['District']}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10
                            ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: Text('${data.docs[index]['Name']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15
                              ),
                            ),
                          )
                        ],
                      ),
                  )
                ],
              ),
            );
          }, separatorBuilder: (_, index) => SizedBox(width: 15,),
              itemCount: len);
        }
    );

  }
}
