// panding in the verification screen

import 'package:ambulance_driver/screens/verification_screens/splash_screen.dart';
import 'package:ambulance_driver/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/api.dart';

var sharedInstance;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedInstance = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenSize.h=MediaQuery.of(context).size.height;
    ScreenSize.w=MediaQuery.of(context).size.width;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}


