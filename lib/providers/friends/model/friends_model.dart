class FirendsModel {
  String? userId;
  String? photoURL;

  FirendsModel({this.userId, this.photoURL});

  FirendsModel.fromJson(Map<String, dynamic> json) {
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
