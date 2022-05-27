import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Reusable/detail_page.dart';
class Search extends StatefulWidget {

  final name;
  Search({required this.name});
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PLACES IN ${widget.name}".toUpperCase(),
          style: TextStyle(
              color: Colors.black,

          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body:
          StreamBuilder<QuerySnapshot>(
              stream:  FirebaseFirestore.instance.collection('Places').where('District',isEqualTo: widget.name).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
          {
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
            return ListView.builder(itemCount: data.size,itemBuilder: (BuildContext context, int index){
                  return SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width * .9,
                    child: Card(

                      child: GestureDetector(
                        onTap: ()async{
                          String img = data.docs[index]['image'];
                          String name = data.docs[index]['Name'];
                          String dis =  data.docs[index]['District'];
                          String desc =  data.docs[index]['Descrption'];
                          String img1 = data.docs[index]['fimg1'];
                          String img2 = data.docs[index]['fimg2'];
                          String img3= data.docs[index]['fimg3'];
                          await Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(image:img ,name: name, district: dis, desc: desc,img1: img1,img2: img2,img3: img3,)));
                        },
                        child: ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage("${data.docs[index]["image"]}",

                                ),

                              ),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Center(child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text("${data.docs[index]["Name"]}",
                                style: TextStyle(
                                  fontSize: 20
                                ),
                                ),
                              ),
                              Icon(Icons.arrow_forward,color: Colors.deepOrange,)
                          ],
                        )),
                            )),
                      ),
                    ),
                  );
            });
          }),

    );
  }
}
