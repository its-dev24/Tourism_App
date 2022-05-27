import 'package:flutter/material.dart';

import 'b_search.dart';
import 'hbookings.dart';

class Buisness extends StatefulWidget {
  const Buisness({Key? key}) : super(key: key);

  @override
  State<Buisness> createState() => _BuisnessState();
}

class _BuisnessState extends State<Buisness> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOTELS",
          style: TextStyle(
              color: Colors.black
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10,),
                GestureDetector(
                    child: DistCard("Alappuzha"),
                    onTap: (){
                     Navigator.push(context, MaterialPageRoute(
                         builder: (context) => BSearch(name: "Alappuzha",)));
                    }
                ),
                Ges("Ernakulam"),
                Ges("Idukki"),
                Ges("Kannur"),
                Ges("Kasaragod"),
                Ges("Kollam"),
                Ges("Kottayam"),
                Ges("Kozhikode"),
                Ges("Malappuram"),
                Ges("Palakkad"),
                Ges("Pathanamthitta"),
                Ges("Thiruvananthapuram"),
                Ges("Thrissur"),
                Ges("Wayanad"),
                SizedBox(height: 100,
                child: TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => HBookings()));
                }, child: Text('My bookings')),
                ),
                Text("My Bookings"),
                SizedBox(height: 50,)
              ],
            ),
          ),
        ),
      ),
    );
  }
  Card DistCard(name){
    return Card(
      child: ListTile(title: Center(child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text("$name"),
          Icon(Icons.arrow_forward,color: Colors.deepOrange,)
        ],
      ))),
    );
  }
  GestureDetector Ges(name){
    return GestureDetector(
        child: DistCard("$name"),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => BSearch(name: "$name",)));
        }
    );
  }
}
