

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
class HBookings extends StatefulWidget {
  const HBookings({Key? key}) : super(key: key);

  @override
  State<HBookings> createState() => _HBookingsState();
}

class _HBookingsState extends State<HBookings> {
  final String auth = FirebaseAuth.instance.currentUser!.uid;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Bookings",
            style: TextStyle(
                color: Colors.black
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        backgroundColor: Colors.grey[200],
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("BookingsHotel").where('UserID',isEqualTo: "$auth").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            final data = snapshot.requireData;
            var len = snapshot.data!.size;
            if(snapshot.hasError){
              return Text("Something Went Wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.redAccent,
                ),
              );
            }
            else if(len==0){
              return SizedBox(
                height: 70,
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Card(
                      elevation: 4,
                      child: ListTile(
                        title: Center(
                          child: Text("Nothing to Show",
                            style: TextStyle(
                                color: Colors.grey
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
            return ListView.builder(
                itemCount: data.size,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Card(
                      elevation: 4,
                      child: Container(

                        child: ExpansionTile(
                          title: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage("${data.docs[index]["Image"]}",

                              ),

                            ),
                            title: Text("${data.docs[index]["Place"]}",
                              style: TextStyle(
                                fontSize: 20,

                              ),
                            ),

                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 40),
                                    child: Text("SLOT:${data.docs[index]["SlotTime"]}"),
                                  ),
                                  Text("NO OF SLOTS:${data.docs[index]["No of Peope"]}"),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: GestureDetector(
                                      onTap: ()async{
                                        data.docs[index].reference.id;
                                        await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                          await myTransaction.delete(data.docs[index].reference);
                                        }).whenComplete(() {
                                          Fluttertoast.showToast(
                                              msg: 'Deleted');
                                        });
                                      },
                                      child: Icon(Icons.delete_forever,
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });



          },

        )
    );
  }

}

