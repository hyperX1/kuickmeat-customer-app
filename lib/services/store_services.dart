

import 'package:cloud_firestore/cloud_firestore.dart';

class StoreServices{


  CollectionReference vendorbanner = FirebaseFirestore.instance.collection('vendorbanner');

  getTopPickedStore(){
    return FirebaseFirestore.instance.collection('vendors').where(
        'accVerified', isEqualTo: true).where('isTopPicked',isEqualTo: true).where('shopOpen',isEqualTo: true).orderBy('shopName').snapshots();
  }

  getNearByStore(){
    return FirebaseFirestore.instance.collection('vendors').where(
        'accVerified', isEqualTo: true).orderBy('shopName').snapshots();
  }

  getNearByStorePagination(){
    return FirebaseFirestore.instance.collection('vendors').where(
        'accVerified', isEqualTo: true).orderBy('shopName');
  }
}

//this will show only verified vendor
//this will show only top picked vendor by admin
//this will sort the store alphabetic order