import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:kuickmeat_app/services/cart_services.dart';

class CartProvider with ChangeNotifier {
  CartServices _cart = CartServices();
  double subTotal = 0.0;
  int cartQty = 0;
  QuerySnapshot snapshot;
  double saving = 0.0;
  double distance = 0.0;
  bool cod = false;

  Future<double> getCartTotal() async {
    var cartTotal = 0.0;
    var saving = 0.0;
    QuerySnapshot snapshot =
        await _cart.cart.doc(_cart.user.uid).collection('products').get();
    if (snapshot == null) {
      return null;
    }
    snapshot.docs.forEach((doc) {
      cartTotal = cartTotal + doc.data()['total'];
      saving =
          saving + ((doc.data()['comparedPrice'] - doc.data()['price']) > 0
              ? doc.data()['comparedPrice'] - doc.data()['price']
              : 0);
    });

    this.subTotal = cartTotal;
    this.cartQty = snapshot.size;
    this.snapshot = snapshot;
    this.saving = saving;
    notifyListeners();

    return cartTotal;
  }

  getDistance(distance){
    this.distance = distance;
    notifyListeners();
  }

  getPaymentMethod(index){
    if(index==0){
      this.cod = false;
      notifyListeners();
    }else{
      this.cod = true;
      notifyListeners();
    }
  }
}
