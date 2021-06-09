import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:kuickmeat_app/Screens/welcome_screen.dart';
import 'package:kuickmeat_app/services/user_services.dart';

class StoreProvider with ChangeNotifier {
  UserServices _userServices = UserServices();
  User user = FirebaseAuth.instance.currentUser;
  var userLatitude = 0.0;
  var userLongitude = 0.0;
  String selectedStore;
  String selectedStoreId;

  getSelectedStore(storeName,storeId){
    this.selectedStore =storeName;
    this.selectedStoreId = storeId;
    notifyListeners();
  }

  Future<void> getUserLocationData(context) async {
    _userServices.getUserById(user.uid).then((result) {
      if (user != null) {
        this.userLatitude = result['latitude'];
        this.userLongitude = result['longitude'];
        notifyListeners();
      } else {
        Navigator.pushReplacementNamed(context, WelcomeScreen.id);
      }
    });
  }
}
