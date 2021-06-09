import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kuickmeat_app/Screens/welcome_screen.dart';
import 'package:kuickmeat_app/services/user_services.dart';

class StoreProvider with ChangeNotifier {
  UserServices _userServices = UserServices();
  User user = FirebaseAuth.instance.currentUser;
  var userLatitude = 0.0;
  var userLongitude = 0.0;
  String selectedStore;
  String selectedStoreId;
  DocumentSnapshot storedetails;
  String distance;

  getSelectedStore(storeDetails, distance) {
    this.storedetails = storeDetails;
    this.distance = distance;
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

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
}
