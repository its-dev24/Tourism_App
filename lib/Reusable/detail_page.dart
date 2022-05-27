import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:like_button/like_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
class DetailPage extends StatefulWidget {
  final image;
  final name;
  final district;
  final expandedHeight = 300.0;
  final roundedContainerHeight = 30.0;
  final desc;
  final img1;
  final img2;
  final img3;
  DetailPage({required this.image, required this.name, required this.district, required this.desc, required this.img1, required this.img2, required this.img3});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isLiked = false;
  var time = ["10:30","12:30","2:30","4:30"];
  String? _timeController;
  String? _numberController;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            //For the whole Page
            body: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    //The header(Image,rounded box)
                    _buildSliverHead(),
                    SliverToBoxAdapter(
                      //For the rest of the details
                      child:_buildDetails(),
                    ),
                  ],
                ),
                Padding(
                  padding:  EdgeInsets.only(top: MediaQuery.of(context).padding.top,
                  right: 15, left: 15),
                  //For top bar
                  child: SizedBox(
                    height: kToolbarHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.menu,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
        //for header
  Widget _buildSliverHead (){
    return SliverPersistentHeader(delegate:
    DetailDeligateSliver(image: widget.image, expandedHeight: widget.expandedHeight, roundedContainerHeight: widget.roundedContainerHeight, name: widget.name, district: widget.district));
    }
    //for rest of the details
  Widget _buildDetails(){
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          //place info
          _buildPlaceInfo(),
          //book now and call button
          //Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
            child: Text("${widget.desc}",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
              height: 1.5
            ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Featured",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5
                ),
                ),

              ],

            ),
          ),
          SizedBox(height: 20,),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Image.network(widget.img1,
                      fit: BoxFit.cover,),
                      height: 120,
                      width: 120,
                    ),
                    SizedBox(width: 5,),
                    Container(
                        child: Image.network(widget.img2,
                        fit: BoxFit.cover,),
                      height: 120,
                      width: 120,
                    ),
                    SizedBox(width: 5,),
                    Container(
                        child: Image.network(widget.img3,
                        fit: BoxFit.cover,),
                      height: 120,
                      width: 120,
                    ),
                  ]
              )
          ),
          SizedBox(height: 40,),
          _buildButton(),
          SizedBox(height: 100,)
        ],
      ),
    );
  }
  //place info
  Widget _buildPlaceInfo(){
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network('${widget.image}',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text("About Place",
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey
          ),
          ),
          Spacer(),
          LikeButton(),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.share,color: Colors.grey,)
        ],
      ),
    );
  }
  //book now and call button
  Widget _buildButton(){
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          TextButton(
          onPressed: (){
            openDialog();

          },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("BOOK NOW",
                  style: TextStyle(
                      color: Colors.deepOrange
                  ),
                ),
              ),
            style: TextButton.styleFrom(
              primary: Colors.black,
              side: BorderSide(
                style: BorderStyle.solid,
                color: Colors.deepOrange

              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)
              )
            ),

          ),
          Spacer(),
          TextButton(
            onPressed: (){},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
              child: Text("CALL",
              style: TextStyle(
                color: Colors.deepOrange
              ),
              ),
            ),
            style: TextButton.styleFrom(
              primary: Colors.black,
                side: BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.deepOrange
                ),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)
    )

            ),

          ),
        ],
      ),
    );
  }
  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Choose Time and Number"),
        content:SizedBox(
          height: 100,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _timeController,
                  items: time.map((label) => DropdownMenuItem(
                    child: Text(label.toString()),
                    value: label,
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _timeController = value;
                    });
                  },
                hint: Text("Choose Time"),
              ),
              DropdownButtonFormField<String>(
                value: _numberController,
                items: ["1","2","3","4","5","6","7","8","9","10"].map((label) => DropdownMenuItem(
                  child: Text(label.toString()),
                  value: label,
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _numberController = value;
                  });
                },
                hint: Text("Number of People"),
              ),
            ],
          ),
        ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: TextButton(
              onPressed: (){
                bookNow(widget.name, _timeController, _numberController,context,widget.image);

              },
              child: Text("Book",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            style: TextButton.styleFrom(
              onSurface: Colors.amber,
              backgroundColor: Colors.deepOrange

            ),
          ),
        )
      ],
      )
  );
  }
Future bookNow(name,slottime,slotno,context,image) async{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user?.uid;

  final uemail = user?.email;

  var collection = FirebaseFirestore.instance.collection('users');
  var docSnapshot = await collection.doc('$uid').get();
  var data = docSnapshot.data() as Map;
  var n = data?['name'];
  print(uid);
  dynamic currentTime = DateFormat.jm().format(DateTime.now());
  print(currentTime);
  await FirebaseFirestore.instance.collection('Bookings').add({
    'Place': '${name}',
    'UserID': '${uid}',
    'Email': '${uemail}',
    'BookingTime': '${currentTime}',
    'SlotTime': '${slottime}',
    'No of Peope': '${slotno}',
    'Image':'${image}',
    'Name':'${n}'
  });
  Navigator.of(context).pop();
}


class DetailDeligateSliver extends SliverPersistentHeaderDelegate{
  final image;
  final expandedHeight;
  final roundedContainerHeight;
  final name;
  final district;
  DetailDeligateSliver({required this.image, required this.expandedHeight, required this.roundedContainerHeight, required this.name, required this.district});
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        Opacity(opacity: 0.8,
          child: Image.network('${image}'
          ,height: expandedHeight,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),

        ),
        Positioned(
            top: expandedHeight - roundedContainerHeight - shrinkOffset,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: roundedContainerHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
              ),
            ),
        ),
        Positioned(
            top: expandedHeight-shrinkOffset - 100,
            left: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(district,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  )
                )
              ],
            )
        )
      ],
    );
  }

  @override

  double get maxExtent => expandedHeight;

  @override

  double get minExtent => 0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
