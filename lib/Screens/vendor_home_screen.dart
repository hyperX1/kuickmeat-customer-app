import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuickmeat_app/providers/store_provider.dart';
import 'package:kuickmeat_app/widgets/vendor_appbar.dart';
import 'package:kuickmeat_app/widgets/vendor_banner.dart';
import 'package:provider/provider.dart';

class VendorHomeScreen extends StatelessWidget {
  static const String id = 'vendor-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            VendorAppBar(),
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
