import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:definitely_not_amazon/screens/cart/add_payment_details.dart';
import 'package:definitely_not_amazon/screens/cart/cart_screen.dart';
import 'package:definitely_not_amazon/screens/home/home_screen.dart';
import 'package:definitely_not_amazon/screens/item/item_details.dart';
import 'package:definitely_not_amazon/screens/profile/profile_screen.dart';
import 'package:definitely_not_amazon/screens/seller_screens/add_item.dart';
import 'package:definitely_not_amazon/screens/seller_screens/add_item_screen2.dart';
import 'package:definitely_not_amazon/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

import 'screens/login/login_page.dart';
import 'screens/login/signup_page.dart';
import 'screens/search/view/search_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [ChuckerFlutter.navigatorObserver],
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: CustomScaffold(body:  const AddItemPage(), title: "Cart"),
      home:HomeScreen(),
      routes: {
        '/signup': (context) => const SignupPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) =>
            CustomScaffold(body: const ProfileScreen(), title: "Profile"),
        '/cart': (context) =>
            CustomScaffold(body: const CartScreen(), title: "Cart"),

      },
    );
  }
}
// ScreenTypeLayout.builder(
// mobile: (BuildContext context) => Container(color:Colors.blue),
// tablet: (BuildContext context) => Container(color:Colors.yellow),
// desktop: (BuildContext context) => Container(color:Colors.red),
// watch: (BuildContext context) => Container(color:Colors.purple),
// );
