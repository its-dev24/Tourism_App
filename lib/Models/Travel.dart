// import 'dart:core';
//
// import '../Reusable/imagepull.dart';
// class Travel{
//   String name;
//   String desc;
//   String phn;
//   String url;
//   Travel(this.name,this.desc,this.phn,this.url);
//   ImagePull img = new ImagePull();
//   Future<Object> generateTravelBlog() async {
//     List<dynamic> images = await img.fetchImages();
//     var ln = images.length;
//     int i =0;
//       name =
//
//       //  print(images[i]["Name"]);
//       // return Travel(images[i]["Name"], images[i]["Description"], images[i]["Phn"], images[i]["image"]);
//
//     //print(images.map((image) => Travel(image["name"], image["desc"], image["phn"], image["url"])).toList());
//     return images.map((image) => Travel(image["name"], image["desc"], image["phn"], image["url"])).toList();
//
//   }
//
//
// }