class UserModel {
  String? userId;
  String? photoURL;

  UserModel({this.userId, this.photoURL});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    photoURL = json['photoURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['photoURL'] = this.photoURL;
    return data;
  }
}
