import 'package:flutter/material.dart';
import 'package:rent_ed/pages/HomePage.dart';
import 'package:rent_ed/pages/OnboardingPage.dart';
import 'package:google_fonts/google_fonts.dart';
 import 'package:rent_ed/pages/RegisterPage.dart';
import 'package:rent_ed/pages/LogInPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent_ed/pages/ListingPage.dart';
import 'package:rent_ed/pages/SearchPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

     initialRoute: '/Home',
      routes: {
        '/': (context) => OnboardingPage(),
        '/Register': (context) => RegisterPage(),
        '/LogIn': (context) => LogInPage(),
        '/Home': (context) => HomePage(),
     // '/Listing': (context) => ListingPage(),
       // '/Profile': (context) => ProfilePage(),
        '/Search': (context) => SearchPage(),
      },
    );
  }
}
