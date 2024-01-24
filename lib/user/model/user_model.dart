import 'package:hive_flutter/hive_flutter.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  String? uid;
  @HiveField(1)
  String? displayName;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? photoUrl;

  UserModel({this.displayName, this.email, this.photoUrl, this.uid});

  UserModel.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    email = json['email'];
    photoUrl = json['photoUrl'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = this.displayName;
    data['email'] = this.email;
    data['photoUrl'] = this.photoUrl;
    data['uid'] = this.uid;
    return data;
  }
}
