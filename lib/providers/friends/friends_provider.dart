import 'package:chat_app/core/base/provider/base_provider.dart';
import 'package:chat_app/core/constants/navigation/navigation_constants.dart';
import 'package:chat_app/core/init/firebase/firebase_helper.dart';
import 'package:chat_app/providers/friends/model/friends_model.dart';
import 'package:chat_app/providers/room/model/room_model.dart';
import 'package:flutter/material.dart';

class FriendsProvider extends BaseProvider with ChangeNotifier {
  @override
  void init() async {}

  @override
  void setContext(BuildContext context) {
    // ignore: todo
    // TODO: implement setContext
  }

  List<FirendsModel> _firends = [];
  List<FirendsModel> get firends => _firends;
  List<RoomsModel> _rooms = [];
  List<RoomsModel> get rooms => _rooms;

  void navigateToChatView(int index) {
    navigation.navigateToPage(path: NavigationConstants.CHATVIEW, data: _rooms[index]);
  }

  Future<void> getAllFriends() async {
    _firends = await FirebaseHelper().getUsers();
    notifyListeners();
  }

  Future<void> getAllRooms(String userId) async {
    _rooms = await FirebaseHelper().getRooms(userId);
    notifyListeners();
  }

  Future<void> createRoom(List<String> userIDS) async {
    FirebaseHelper().createRoom(userIDS);
  }
}
