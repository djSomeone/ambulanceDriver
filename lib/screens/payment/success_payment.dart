import 'package:ambulance_driver/screens/Home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SuccessPayment extends StatelessWidget {
  const SuccessPayment({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1),(){
      Get.offAll(Homepage());
    });
    return Scaffold(
        body:Center(
          child: Container(
            height: 140,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: 90,
                    child: SvgPicture.asset("asset/thankyouPage/done.svg")),
                SizedBox(width:200,child: Text("Ride Completed",textAlign: TextAlign.center,style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),))

              ],
            ),

          ),
        )
    );
  }
}
