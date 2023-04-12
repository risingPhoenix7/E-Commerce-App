import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:definitely_not_amazon/screens/home/home_screen.dart';
import 'package:definitely_not_amazon/screens/profile/profile_screen.dart';
import 'package:definitely_not_amazon/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

import 'screens/login/login_page.dart';
import 'screens/login/signup_page.dart';

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
      home: HomeScreen(),
      routes: {
        '/signup': (context) => SignupPage(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomeScreen(),
        '/profile': (context) =>
            CustomScaffold(body: ProfileScreen(), title: "Profile"),
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
