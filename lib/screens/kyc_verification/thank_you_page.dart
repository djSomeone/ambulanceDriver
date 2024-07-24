import 'dart:async';

import 'package:ambulance_driver/screens/Home/home_page.dart';
import 'package:ambulance_driver/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ThankYouPage extends StatelessWidget {
   ThankYouPage(){
     Future.delayed(Duration(seconds: 1),
             (){
       Get.to(Homepage());
             });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: SizedBox(height: ScreenSize.h*0.34,width: ScreenSize.w,
        child: Column(children: [
          SvgPicture.asset("asset/thankyouPage/done.svg"),
          Expanded(child: Center(child: Text("Thank You",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700),))),
          Text(textAlign: TextAlign.center,"You have successfully registered. Processing your personal data will take some time. Please come back late",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14),)
        ],),),),
    ),);
  }
}
