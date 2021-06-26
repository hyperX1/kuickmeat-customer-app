import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kuickmeat_app/Screens/map_screen.dart';
import 'package:kuickmeat_app/Screens/my_orders_screen.dart';
import 'package:kuickmeat_app/Screens/profile_update_screen.dart';
import 'package:kuickmeat_app/Screens/welcome_screen.dart';
import 'package:kuickmeat_app/providers/auth_provider.dart';
import 'package:kuickmeat_app/providers/location_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  static const String id = 'profile-screen';
  @override
  Widget build(BuildContext context) {
    var userDetails = Provider.of<AuthProvider>(context);
    var locationData = Provider.of<LocationProvider>(context);
    User user = FirebaseAuth.instance.currentUser;
    userDetails.getUserDetails();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'KuickMeat',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'MY ACCOUNT',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: Text(
                                'j',
                                style: TextStyle(
                                    fontSize: 50, color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 70,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    userDetails.snapshot.data()['firstName'] !=
                                            null
                                        ? '${userDetails.snapshot.data()['firstName']} ${userDetails.snapshot.data()['lastName']}'
                                        : 'Update Your Name',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white),
                                  ),
                                  if (userDetails.snapshot.data()['email'] !=
                                      null) //otherwise hide
                                    Text(
                                      '${userDetails.snapshot.data()['email']}',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  Text(
                                    user.phoneNumber,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (userDetails.snapshot != null)
                          ListTile(
                            tileColor: Colors.white,
                            leading: Icon(
                              Icons.location_on,
                              color: Colors.redAccent,
                            ),
                            title:
                                Text(userDetails.snapshot.data()['location']),
                            subtitle: Text(
                              userDetails.snapshot.data()['address'],
                              maxLines: 1,
                            ),
                            trailing: SizedBox(
                              width: 80,
                              child: OutlineButton(
                                borderSide: BorderSide(color: Colors.redAccent),
                                child: Text(
                                  'Change',
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                                onPressed: () {
                                  EasyLoading.show(status: 'Please wait...');
                                  locationData
                                      .getCurrentPosition()
                                      .then((value) {
                                    if (value != null) {
                                      EasyLoading.dismiss();
                                      pushNewScreenWithRouteSettings(
                                        context,
                                        screen: MapScreen(),
                                        settings:
                                            RouteSettings(name: MapScreen.id),
                                        withNavBar: false,
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.cupertino,
                                      );
                                    } else {
                                      EasyLoading.dismiss();
                                      print('Permission not allowed');
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 10.0,
                  child: IconButton(
                    icon: Icon(
                      Icons.edit_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      pushNewScreenWithRouteSettings(
                        context,
                        screen: UpdateProfile(),
                        settings: RouteSettings(name: UpdateProfile.id),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                  ),
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('My Orders'),
              horizontalTitleGap: 2,
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.comment_outlined),
              title: Text('My Ratings & Reviews'),
              horizontalTitleGap: 2,
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.notifications_none),
              title: Text('Notifications'),
              horizontalTitleGap: 2,
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text('Logout'),
              horizontalTitleGap: 2,
              onTap: () {
                FirebaseAuth.instance.signOut();
                pushNewScreenWithRouteSettings(
                  context,
                  settings: RouteSettings(name: WelcomeScreen.id),
                  screen: WelcomeScreen(),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
