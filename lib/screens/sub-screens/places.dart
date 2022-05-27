import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tourism_app/screens/sub-screens/search.dart';
import '../../Models/Travel.dart';
import '../../Reusable/imagepull.dart';
import '../../Reusable/reusable_widget.dart';

class Places extends StatefulWidget {
  const Places({Key? key}) : super(key: key);

  @override
  State<Places> createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  @override
  TextEditingController _searchTextController = TextEditingController();
  //Travel img = new Travel('sf','sdfsdf','sdfsdf','sdfsdf');
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PLACES",
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
                    builder: (context) => Search(name: "Alappuzha",)));
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
                SizedBox(height: 120,)
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
              builder: (context) => Search(name: "$name",)));
        }
    );
  }
}
