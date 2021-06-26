import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kuickmeat_app/Screens/cart_screen.dart';
import 'package:kuickmeat_app/Screens/homeScreen.dart';
import 'package:kuickmeat_app/Screens/landing_screen.dart';
import 'package:kuickmeat_app/Screens/login_screen.dart';
import 'package:kuickmeat_app/Screens/main_screen.dart';
import 'package:kuickmeat_app/Screens/map_screen.dart';
import 'package:kuickmeat_app/Screens/my_orders_screen.dart';
import 'package:kuickmeat_app/Screens/product_details_screen.dart';
import 'package:kuickmeat_app/Screens/product_list_screen.dart';
import 'package:kuickmeat_app/Screens/profile_screen.dart';
import 'package:kuickmeat_app/Screens/profile_update_screen.dart';
import 'package:kuickmeat_app/Screens/splash_screen.dart';
import 'package:kuickmeat_app/Screens/vendor_home_screen.dart';
import 'package:kuickmeat_app/providers/cart_provider.dart';
import 'package:kuickmeat_app/providers/coupon_provider.dart';
import 'package:kuickmeat_app/providers/order_provider.dart';
import 'package:kuickmeat_app/providers/store_provider.dart';
import 'package:kuickmeat_app/providers/location_provider.dart';
import 'package:kuickmeat_app/Screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kuickmeat_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LocationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => StoreProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CouponProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.redAccent,
        fontFamily: 'Lato',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        MapScreen.id: (context) => MapScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        LandingScreen.id: (context) => LandingScreen(),
        MainScreen.id: (context) => MainScreen(),
        VendorHomeScreen.id: (context) => VendorHomeScreen(),
        ProductListScreen.id: (context) => ProductListScreen(),
        ProductDetailsScreen.id: (context) => ProductDetailsScreen(),
        CartScreen.id: (context) => CartScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        UpdateProfile.id: (context) => UpdateProfile(),
        MyOrders.id: (context) => MyOrders(),
      },
      builder: EasyLoading.init(),
    );
  }
}
