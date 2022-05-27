import 'package:flutter/material.dart';
import 'package:tourism_app/Reusable/explore_page.dart';
import 'package:tourism_app/Reusable/most_popular.dart';
import 'package:tourism_app/Reusable/reusable_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../Reusable/travel_blog.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25,top: 35),
            child: Text(
                'Explore',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
            ),
          ),
        Expanded(
            flex: 2,
            child:TravelBlog(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Most Popular',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
              ),
              Text('View All',
                    style: TextStyle(
                      color: Colors.orange[800],
                      fontSize: 16
                    ),
              ),
            ],
          ),
        ),
          Expanded(
            flex: 1,
            child: MostPopular(),
          ),
        ],
      ),
    );
  }
}

class FireStorageService extends ChangeNotifier{
  FireStorageService();
  static Future<dynamic> LoadImage(BuildContext context, String Image) async{
    return FirebaseStorage.instance.ref().child(Image).getDownloadURL();

  }
}
Future<Widget> _getimage(BuildContext context, String imageName) async{
  Image image = Image.network('https://socialistmodernism.com/wp-content/uploads/2017/07/placeholder-image.png');
  await FireStorageService.LoadImage(context, imageName).then((value){
    image = Image.network(value.toString(),
      fit: BoxFit.cover,
    );
  });
  return image;
}