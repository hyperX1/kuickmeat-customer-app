import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuickmeat_app/Screens/homeScreen.dart';
import 'package:kuickmeat_app/providers/location_provider.dart';
import 'package:kuickmeat_app/services/user_services.dart';

class AuthProvider with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String smsOtp;
  String verificationId;
  String error = '';
  UserServices _userServices = UserServices();
  bool loading = false;
  LocationProvider locationData = LocationProvider();

  Future<void> verifyPhone({BuildContext context, String number, double latitude, double longitude, String address}) async {
    this.loading=true;
    notifyListeners();
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
      this.loading=false;
      notifyListeners();
      await _auth.signInWithCredential(credential);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException e) {
      this.loading=false;
      print(e.code);
      this.error=e.toString();
      notifyListeners();
    };

    final PhoneCodeSent smsOtpSend = (String verId, int resendToken) async {
      this.verificationId = verId;

      //open dialog to enter received OTP SMS

      smsOtpDialog(context, number,latitude,longitude,address);
    };
    try {
      _auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: smsOtpSend,
        codeAutoRetrievalTimeout: (String verId) {
          this.verificationId = verId;
        },
      );
    } catch (e) {
      this.error=e.toString();
      notifyListeners();
      print(e);
    }
  }

  Future<bool> smsOtpDialog(BuildContext context, String number, double latitude, double longitude, String address) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              children: [
                Text('Verification Code'),
                SizedBox(
                  height: 6,
                ),
                Text(
                  'Enter 6 digit OTP received as SMS',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            content: Container(
              height: 80,
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 6,
                onChanged: (value) {
                  this.smsOtp = value;
                },
              ),
            ),
            actions: [
              FlatButton(
                onPressed: () async {
                  try {
                    AuthCredential credential = PhoneAuthProvider.credential(
                        verificationId: verificationId, smsCode: smsOtp);

                    final User user =
                    (await _auth.signInWithCredential(credential)).user;

                    if(locationData.selectedAddress!=null){
                      updateUser(id: user.uid, number: user.phoneNumber,latitude: locationData.latitude,longitude: locationData.longitude,address: locationData.selectedAddress.addressLine);
                    }else{
                      //create user data in fireStore after user successfully registered
                      _createUser(id: user.uid, number: user.phoneNumber,latitude: latitude,longitude: longitude,address: address);
                    }

                    // navigate to Home page after login
                    if (user != null) {
                      Navigator.of(context).pop();
                      this.loading=false;

                      //don't want to come back to welcome screen after logged in
                      Navigator.pushReplacementNamed(context, HomeScreen.id);
                    } else {
                      print('Login Failed');
                    }
                  } catch (e) {
                    this.error = 'Invalid OTP';
                    notifyListeners();
                    print(e.toString());
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  'DONE',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          );
        });
  }

  void _createUser({String id, String number,double latitude, double longitude, String address}) {
    _userServices.createUserData({
      'id': id,
      'number': number,
      'latitude' : latitude,
      'longitude' : longitude,
      'address' : address
    });
    this.loading=false;
    notifyListeners();
  }
    void updateUser({String id, String number,double latitude, double longitude, String address}) {
      _userServices.updateUserData({
        'id': id,
        'number': number,
        'latitude' : latitude,
        'longitude' : longitude,
        'address' : address
      });
      this.loading=false;
      notifyListeners();
  }
}
