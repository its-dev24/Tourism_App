class UserModel {
  String? uid;
  String? email;
  String? name;
  String? image;
  String? phn;
  UserModel({this.uid, this.email, this.name, this.image, this.phn});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      image: map['image'],
      phn: map['phn'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'image': image,
      'phn' : phn
    };
  }
}