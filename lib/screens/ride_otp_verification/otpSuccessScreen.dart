import 'package:ambulance_driver/screens/start_ride/controller/ride_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// import '../controller/ride_controller.dart';

class OtpSuccessScreen extends StatefulWidget {
  const OtpSuccessScreen({super.key});

  @override
  State<OtpSuccessScreen> createState() => _OtpSuccessScreenState();
}

class _OtpSuccessScreenState extends State<OtpSuccessScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1),(){
      rideScreenController.otpVerified(true);
      rideScreenController.socket.otpVerifiedEvent(rideScreenController.requestData.value);
      // rideScreenController.isOtpVerified.value=true;
      Get.back();
    });
  }
  var rideScreenController=Get.put(RideController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Center(
        child: Container(
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 90,
                  child: SvgPicture.asset("asset/thankyouPage/done.svg")),
              SizedBox(width:200,child: Text("OTP Successfully Verified",textAlign: TextAlign.center,style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),))
           ,Padding(
             padding: const EdgeInsets.only(bottom: 20),
             child: Text("You can continue your ride",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
           )
            ],
          ),

        ),
      )
    );
  }
}
