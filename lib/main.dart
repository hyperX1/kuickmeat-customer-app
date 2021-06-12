import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuickmeat_app/Screens/landing_screen.dart';
import 'package:kuickmeat_app/Screens/login_screen.dart';
import 'package:kuickmeat_app/Screens/main_screen.dart';
import 'package:kuickmeat_app/Screens/product_list_screen.dart';
import 'package:kuickmeat_app/Screens/vendor_home_screen.dart';
import 'package:kuickmeat_app/providers/store_provider.dart';
import 'Screens/map_screen.dart';
import 'package:kuickmeat_app/providers/location_provider.dart';
import 'Screens/homeScreen.dart';
import 'package:kuickmeat_app/Screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kuickmeat_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'Screens/splash_screen.dart';

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
      },
    );
  }
}
