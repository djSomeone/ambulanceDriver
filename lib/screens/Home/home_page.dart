import 'dart:async';

import 'package:ambulance_driver/main.dart';
import 'package:ambulance_driver/modules/notification_card.dart';
import 'package:ambulance_driver/modules/titled_sub.dart';
import 'package:ambulance_driver/screens/Home/google_map_screen.dart';
import 'package:ambulance_driver/screens/Home/controller/home_page_controller.dart';
import 'package:ambulance_driver/screens/ProfilePage/profile_screen.dart';
import 'package:ambulance_driver/screens/my_ride/controller/ride_history_controller.dart';
import 'package:ambulance_driver/screens/start_ride/start_ride.dart';
import 'package:ambulance_driver/screens/my_ride/my_rides.dart';
import 'package:ambulance_driver/socketHandler/socket_handler.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../api/api.dart';
import '../../utility/constants.dart';
import '../start_ride/controller/ride_controller.dart';

class Homepage extends StatefulWidget {
   Homepage();


  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var controller = Get.put(HomePageController());
  var iconColor = Color(0xFF8E8E8E);

  var rideController=Get.put(RideController());
  late StreamSubscription<Position> _positionSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // this isforthe updating current location in app as well as server
    _positionSubscription = Geolocator.getPositionStream(locationSettings: LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 1))
        .listen((newPosition) {
      Print.p("new Position=Lat=${newPosition.latitude}==Lng==${newPosition.longitude}");
      controller.setCurrentPosition(LatLng(newPosition.latitude, newPosition.longitude));
      Api.updateDriverLocation(sharedInstance.getString("number").toString(), newPosition.latitude, newPosition.longitude);
    }, onError: (error) {
      Print.p("Error getting location: $error");
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _positionSubscription!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          // index for the page navigation
          Obx(
            () => controller.activePageIndex.value == 0
                ? GoogleMapScreen()
                : controller.activePageIndex.value == 1
                    ? RideHistoryScreen()
                    : ProfileScreen(),
          ),

          // naviagtion bar
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: SizedBox(
                height: 90,
                child: Container(
                  height: 65,
                  width: ScreenSize.w * 0.85,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Material(
                      borderRadius: BorderRadius.circular(15),
                      elevation: 10,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Obx(
                            () => Row(
                              children: [
                                Expanded(
                                    child: GestureDetector(
                                  onTap: () {
                                    controller.setActivePageIndex(0);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.home,
                                        color:
                                            controller.activePageIndex.value ==
                                                    0
                                                ? ConstColor.primery
                                                : iconColor,
                                        size: 30,
                                      ),
                                      Text(
                                        "home",
                                        style: TextStyle(
                                            color: controller.activePageIndex
                                                        .value ==
                                                    0
                                                ? ConstColor.primery
                                                : iconColor,
                                            fontSize: 10),
                                      )
                                    ],
                                  ),
                                )),
                                Expanded(
                                    child: GestureDetector(
                                  onTap: () {
                                    controller.setActivePageIndex(1);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.bar_chart,
                                        color:
                                            controller.activePageIndex.value ==
                                                    1
                                                ? ConstColor.primery
                                                : iconColor,
                                        size: 30,
                                      ),
                                      Text("My Ride",
                                          style: TextStyle(
                                              color: controller.activePageIndex
                                                          .value ==
                                                      1
                                                  ? ConstColor.primery
                                                  : iconColor,
                                              fontSize: 10))
                                    ],
                                  ),
                                )),
                                Expanded(
                                    child: GestureDetector(
                                  onTap: () {
                                    controller.setActivePageIndex(2);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color:
                                            controller.activePageIndex.value ==
                                                    2
                                                ? ConstColor.primery
                                                : iconColor,
                                        size: 30,
                                      ),
                                      Text("My Profile",
                                          style: TextStyle(
                                              color: controller.activePageIndex
                                                          .value ==
                                                      2
                                                  ? ConstColor.primery
                                                  : iconColor,
                                              fontSize: 10))
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
