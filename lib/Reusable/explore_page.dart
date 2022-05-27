import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:tourism_app/Reusable/detail_page.dart';
import '../Models/Travel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../screens/nav.dart';
class TravelBlog extends StatefulWidget {

  final _pageCtrl = PageController(viewportFraction: 0.9);

  @override
  State<TravelBlog> createState() => _TravelBlogState();
}

class _TravelBlogState extends State<TravelBlog> {
  final Stream<QuerySnapshot> places = FirebaseFirestore.instance.collection('Places').snapshots();
  @override
  final _pageCtrl = PageController(viewportFraction: 0.9);
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: places,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError){
            return Text('Something Went Wrong');
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(
                color: Colors.redAccent,
              ),
            );
          }
          final data = snapshot.requireData;

          return PageView.builder(

            itemCount: 5,
              controller: _pageCtrl,
              itemBuilder: (context, index){
                String img = data.docs[index]['image'];
                String name = data.docs[index]['Name'];
                String dis =  data.docs[index]['District'];
                String desc =  data.docs[index]['Descrption'];
                String img1 = data.docs[index]['fimg1'];
                String img2 = data.docs[index]['fimg2'];
                String img3= data.docs[index]['fimg3'];
            return GestureDetector (
              onTap: () async =>
                await Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(image: img, name: name, district: dis, desc: desc,img1: img1,img2: img2,img3: img3,))),

              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20, bottom: 30,top: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network('${data.docs[index]['image']}',
                      fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height:  MediaQuery.of(context).size.height,
                      ),

                    ),
                  ),
                  Positioned(
                      bottom: 80,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Material(
                            color: Colors.transparent,
                            child: Text('${data.docs[index]['District']}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: Text('${data.docs[index]['Name']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),),
                  Positioned(
                      bottom: 0,
                      right: 30,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.orange[800]
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 30,
                        ),
                      )

                  ),
                ],
              ),
            );
          });
        }
    );
  }
}
