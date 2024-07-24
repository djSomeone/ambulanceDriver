import 'dart:async';

// import 'package:ambulance_test/screens/HomePage/google_map_screen.dart';
// import 'package:ambulance_test/utility/constants.dart';
import 'package:ambulance_driver/screens/Home/home_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../api/api.dart';
import "login_screen.dart";


import '../../main.dart';
// import 'registrationPages/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool resize=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // added logger because of this is firrst screen
    Api.dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));


    Timer(Duration(microseconds: 1), () {
      setState(() {
        resize=true;
      });
      Timer(Duration(milliseconds: 1500),()
      {
        if((sharedInstance.getString("userName"))!=null) {
          // getPermission();
          Get.offAll(Homepage());
        }
        else{
          Get.offAll(SendOtpScreen());
        }

      })
      ;
      //   Navigator.of(context)
      //       .pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedContainer(
          // decoration: ConstBorder.bDeco,
          height:resize?300: 100,
          width:resize?300: 100,
          duration: Duration(seconds: 1),
          curve: Curves.linearToEaseOut,
          child: Image.asset(
            'asset/splashScreen/logo1.png',
            height: 200,
          ),
        ),
      ),
    );
  }
}