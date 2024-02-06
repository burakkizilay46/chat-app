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

  RoomsModel? checkRoomExists(List<RoomsModel> _rooms, List<String> userIDS) {
    for (var room in _rooms) {
      var roomUserSet = room.users.toSet(); // Oda kullanıcılarını bir Set'e çevir.
      var userIdsSet = userIDS.toSet(); // Gelen kullanıcı ID'lerini bir Set'e çevir.

      if (roomUserSet.length == userIdsSet.length &&
          roomUserSet.intersection(userIdsSet).length == roomUserSet.length) {
        print('Tam eşleşen bir oda var!');
        return room; // Tam eşleşme sağlanan oda.
      }
    }

    print('Tam eşleşen bir oda yok!'); // Eşleşme bulunamazsa bu mesajı yazdır.
    return null; // Eşleşme bulunamazsa null döndür.
  }

  Future<void> createRoom(List<String> userIDS) async {
    var room = checkRoomExists(_rooms, userIDS);
    if (room != null) {
      navigateToAlreadyChat(room); // Eğer room null değilse, o odaya navigasyon yap.
    } else {
      await FirebaseHelper().createRoom(userIDS); // Yeni oda oluştur.
      getAllRooms(userIDS.first); // Arkadaş listesini güncelle/getir.
    }
  }

  void navigateToAlreadyChat(RoomsModel room) {
    navigation.navigateToPage(path: NavigationConstants.CHATVIEW, data: room);
  }
}
