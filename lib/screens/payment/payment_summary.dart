import 'package:ambulance_driver/screens/Home/home_page.dart';
import 'package:ambulance_driver/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Home/controller/home_page_controller.dart';
import '../my_ride/controller/ride_history_controller.dart';
import '../start_ride/controller/ride_controller.dart';

class PaymentSummaryScreen extends StatelessWidget {
  var amount;
  var rideId;
  var patientName;
  var paymentMethod;
  var date;
  var time;
   PaymentSummaryScreen({required this.paymentMethod,required this.amount,required this.date,required this.patientName,required this.rideId,required this.time});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(

        children: [
        Expanded(child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text("Payment Received",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
          ),
          Text("Money received via cash",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SvgPicture.asset("asset/paymentSummary.svg"),
          ),

          Text("\u20B9$amount",style: TextStyle(color: ConstColor.primery,fontSize: 40),),
            // deatail of the ride
            Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(height: 240,
              child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xFFF5F5F5)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 10),
                child: Column(
                  children: [
                    Expanded(child: titleValue(title: "Ride ID",value: rideId)),
                    Expanded(child: titleValue(title: "Patient Name",value: patientName)),
                    Expanded(child: titleValue(title: "Payment Method",value: paymentMethod)),
                    Expanded(child: titleValue(title: "Date",value: date)),
                    Expanded(child: titleValue(title: "Time",value: time)),
                  ],
                ),
              ),),),
          )

        ],)),
        standaredButton(title: "Home", onPressed: (){
          Get.find<HomePageController>().reinitializeController();
          Get.find<RideController>().reinitializeController();
          Get.find<RideHistoryController>().reinitializeController();
          Get.to(Homepage());
        })
      ],),
    ),);
  }
}

Widget titleValue({var title, var value})
{
  return Row(children: [
    Expanded(flex:3,child: Text(title.toString(),style: TextStyle(overflow: TextOverflow.ellipsis),)),
    Expanded(flex:2,child: Text(value.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),)),
  ],);
}
