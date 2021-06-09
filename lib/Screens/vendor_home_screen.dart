import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuickmeat_app/providers/store_provider.dart';
import 'package:kuickmeat_app/widgets/vendor_banner.dart';
import 'package:provider/provider.dart';

class VendorHomeScreen extends StatelessWidget {
  static const String id = 'vendor-screen';
  @override
  Widget build(BuildContext context) {
    var _store = Provider.of<StoreProvider>(context);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              iconTheme: IconThemeData(color: Colors.white),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.search),
                ),
              ],
              title: Text(
                _store.selectedStore,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ];
        },
        body: Column(
          children: [
            VendorBanner(),
          ],
        ),
      ),
    );
  }
}
