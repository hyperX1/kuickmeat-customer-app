
import 'package:flutter/material.dart';
import 'package:kuickmeat_app/widgets/image_slider.dart';
import 'package:kuickmeat_app/widgets/my_appbar.dart';
import 'package:kuickmeat_app/widgets/near_by_store.dart';
import 'package:kuickmeat_app/widgets/top_pick_store.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(112),
        child: MyAppBar(),
      ),
      body: ListView(
        children: [
          ImageSlider(),
          Container(
            color: Colors.white,
              child: TopPickStore(),),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: NearByStores(),
          ),
        ],
      ),
    );
  }
}
