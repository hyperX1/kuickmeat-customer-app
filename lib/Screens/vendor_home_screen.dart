import 'package:flutter/material.dart';
import 'package:kuickmeat_app/widgets/categories_widget.dart';
import 'package:kuickmeat_app/widgets/products/best_selling_product.dart';
import 'package:kuickmeat_app/widgets/products/featured_products.dart';
import 'package:kuickmeat_app/widgets/products/recently_added_products.dart';
import 'package:kuickmeat_app/widgets/vendor_appbar.dart';
import 'package:kuickmeat_app/widgets/vendor_banner.dart';

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
        body: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            VendorBanner(), //banners by vendor for promotions
            VendorCategories(), //categories by vendor
            RecentlyAddedProducts(), //Recently Added Products
            FeaturedProducts(), //Best Selling Products
            BestSellingProducts(), //Featured Products
          ],
        ),
      ),
    );
  }
}
