import 'package:chat_app/core/base/provider/base_provider.dart';
import 'package:chat_app/core/constants/navigation/navigation_constants.dart';
import 'package:chat_app/core/init/firebase/firebase_helper.dart';
import 'package:chat_app/providers/friends/model/friends_model.dart';
import 'package:chat_app/providers/room/model/room_model.dart';
import 'package:flutter/material.dart';

class FriendsProvider extends BaseProvider with ChangeNotifier {
  @override
  void init() async {
    await getAllRooms();
  }

  @override
  void setContext(BuildContext context) {
    // TODO: implement setContext
  }

  List<FirendsModel> _firends = [];
  List<FirendsModel> get firends => _firends;
  List<RoomsModel> _rooms = [];
  List<RoomsModel> get rooms => _rooms;

  void navigateToChatView() {
    navigation.navigateToPage(path: NavigationConstants.CHATVIEW);
  }

  Future<void> getAllFriends() async {
    _firends = await FirebaseHelper().getUsers();
    print(_firends.toList().first);
    notifyListeners();
  }

  Future<void> getAllRooms() async {
    /* _rooms = await FirebaseHelper().getRooms(); */
    print(_rooms);
    notifyListeners();
  }
}
