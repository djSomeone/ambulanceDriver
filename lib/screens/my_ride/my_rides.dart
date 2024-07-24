import 'package:ambulance_driver/screens/my_ride/controller/ride_history_controller.dart';
import 'package:ambulance_driver/screens/my_ride/module/my_ride_card.dart';
import 'package:ambulance_driver/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RideHistoryScreen extends StatefulWidget {
  RideHistoryScreen({super.key});

  @override
  State<RideHistoryScreen> createState() => _RideHistoryScreenState();
}

class _RideHistoryScreenState extends State<RideHistoryScreen> {
  var rideHistoryConroller = Get.put(RideHistoryController());

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    rideHistoryConroller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFFDFDFD),
        appBar: standeredAppBar(
          title: "My Ride",
        ),
        body: Obx(
          ()
          {
            var data = rideHistoryConroller.driverHistoryData.value;
            return Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 80),
                child: rideHistoryConroller.driverHistoryData.value.length==0?Center(child: Text("No rides"),):ListView.builder(
                    itemCount:
                        rideHistoryConroller.driverHistoryData.value.length,
                    itemBuilder: (context, index) => MyRideCard(
                        date: data[index]["date"].toString().substring(0,10),
                        amount: data[index]["amount"].toString(),
                          dropAdd:  data[index]["dropAddress"].toString(),
                        patientName:  data[index]["patientName"].toString(),
                        paymentMethod:  data[index]["paymentMethod"].toString(),
                        pickUpAdd:  data[index]["pickupAddress"].toString(),
                        rating:  data[index]["rating"].toString(),
                        time:  data[index]["time"].toString())));
          },
        ));
  }
}
