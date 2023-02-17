import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reach_out/homePage.dart';
import 'phone.dart';
import 'otp.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MaterialApp (
        debugShowCheckedModeBanner: false,
        initialRoute: 'homePage',
        routes: {
          'phone' : (context) => PhoneNumber(),
          'otp' : (context) => Otp(),
          'homePage' : (context) => homePage()
        },
      )
  );
}

