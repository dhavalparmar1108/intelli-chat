import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String? password;
  String? name;
  String? email;

  UserData({this.password, this.name, this.email});

  UserData.fromSnapshot(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> json = documentSnapshot.data() as Map<String, dynamic>;
    password = json['password'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}
