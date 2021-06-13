import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuickmeat_app/providers/cart_provider.dart';
import 'package:kuickmeat_app/services/store_services.dart';
import 'package:kuickmeat_app/widgets/cart/cart_list.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const String id = 'cart-screen';
  final DocumentSnapshot document;

  CartScreen({this.document});
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  StoreServices _store = StoreServices();
  DocumentSnapshot doc;
  var textStyle = TextStyle(color: Colors.grey);
  int discount = 30;
  int deliveryFee = 50;

  @override
  void initState() {
    _store.getShopDetails(widget.document.data()['sellerUid']).then((value) {
      setState(() {
        doc = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _cartProvider = Provider.of<CartProvider>(context);
    var _payable = _cartProvider.subTotal + deliveryFee - discount;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      bottomSheet: Container(
        height: 60,
        color: Colors.blueGrey[900],
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Rs. ${_cartProvider.subTotal.toStringAsFixed(0)}',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '(Including Taxes)',
                      style: TextStyle(color: Colors.green, fontSize: 10),
                    )
                  ],
                ),
                RaisedButton(
                    child: Text(
                      'CHECKOUT',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.document.data()['shopName'],
                    style: TextStyle(fontSize: 16),
                  ),
                  Row(
                    children: [
                      Text(
                        '${_cartProvider.cartQty} ${_cartProvider.cartQty > 1 ? 'Items, ' : 'Item, '}',
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      Text(
                        'To pay : Rs. ${_cartProvider.subTotal.toStringAsFixed(0)}',
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ];
        },
        body: _cartProvider.cartQty >0 ? SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 80),
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                if (doc != null)
                  ListTile(
                    tileColor: Colors.white,
                    leading: Container(
                      height: 60,
                      width: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          doc.data()['imageUrl'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(doc.data()['shopName']),
                    subtitle: Text(
                      doc.data()['address'],
                      maxLines: 1,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                CartList(
                  document: widget.document,
                ),

                //coupon
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 38,
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Colors.grey[300],
                                  hintText: 'Enter Voucher Code',
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                        ),
                        OutlineButton(
                          borderSide: BorderSide(color: Colors.grey),
                          child: Text('Apply'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),

                //bill details card
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bill Details',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Basket value',
                                    style: textStyle,
                                  ),
                                ),
                                Text(
                                  'Rs. ${_cartProvider.subTotal.toStringAsFixed(0)}',
                                  style: textStyle,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Discount',
                                    style: textStyle,
                                  ),
                                ),
                                Text(
                                  'Rs. $discount',
                                  style: textStyle,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Delivery Fee',
                                    style: textStyle,
                                  ),
                                ),
                                Text(
                                  'Rs. $deliveryFee',
                                  style: textStyle,
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Total amount payable',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  'Rs. ${_payable.toStringAsFixed(0)}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(.3),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Total Saving',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    ),
                                    Text('Rs. ${_cartProvider.saving.toStringAsFixed(0)}',
                                      style: TextStyle(color: Colors.green),),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ) : Center(child: Text('Cart Empty! Continue shopping'),),
      ),
    );
  }
}
