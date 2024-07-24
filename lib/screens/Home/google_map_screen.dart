import 'dart:async';

import 'package:ambulance_driver/screens/Home/controller/home_page_controller.dart';
import 'package:ambulance_driver/screens/start_ride/controller/ride_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../modules/notification_card.dart';
import '../../utility/constants.dart';
import '../start_ride/start_ride.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController? _controller;
  var controller = Get.put(HomePageController());
  var rideController = Get.find<RideController>();

  BitmapDescriptor ambulanceicon = BitmapDescriptor.defaultMarker;
  void setCustomIcon() {
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "asset/ambulance.png")
        .then((icon) {
      ambulanceicon = icon;
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCustomIcon();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // controller.dispose();
    // rideController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.topLeft,
      children: [
        // google amp
        Obx((){
          if(_controller!=null)
          {
            _controller!.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(  target: controller.myCurrentPosition.value,
                  zoom: 18.4746, )
            )
            );
          }
          return controller.isSetCurrentPosition.value
              ? GoogleMap(

            zoomControlsEnabled: false,
            myLocationEnabled: false,
            myLocationButtonEnabled: true,
            mapType: MapType.terrain,

            initialCameraPosition: CameraPosition(
              target: controller.myCurrentPosition.value,
              zoom: 18.4746,
            ),

            markers: <Marker>{Marker(markerId: MarkerId("you"),icon: ambulanceicon,position: controller.myCurrentPosition.value)},
            onMapCreated: (GoogleMapController controller) {
              _controller=controller;
            },
          )
              : Center(
            child: Text(
              "Fetching Location",
              style: TextStyle(fontSize: 14),
            ),
          );
    } ),
        // notification
        Obx(
          () {
            Map<String,dynamic> reqData=rideController.requestData.value;
            return controller.isThereNotification.value
                ? Positioned(
                    bottom: 0,
                    child: Container(
                      height: ScreenSize.h * 0.6,
                      width: ScreenSize.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 300,
                              child: NotificationCard(
                                patientName: reqData["patientName"].toString(),
                                fare: reqData["fare"].toString(),
                                distance: reqData["distance"].toString(),
                                pickAddress: reqData["pickupAddress"].toString(),
                                dropAddress: reqData["dropAddress"].toString(),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                onAccept: () {
                                  var result=rideController.socket.acceptRequestEvent(rideController.requestData.value);
                                  if(result)
                                  {
                                    Get.to(StartRide());
                                    controller.setIsThereNotification(false);
                                  }
                                  else{
                                    toast(msg: "there is error");
                                  }
                                },
                                onDecline: () {
                                  var result=rideController.socket.denyRequestEvent(rideController.requestData.value);
                                  if(result)
                                    {
                                      controller.setIsThereNotification(false);
                                    }
                                  else{
                                    toast(msg: "there is error");
                                  }
                                },
                              ),
                            ),
                            // Expanded(child: Center())
                          ],
                        ),
                      ),
                    ),
                  )
                : Center();
          },
        ),
        // active and inactive
        SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, right: 16, left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(62),
                        color: Colors.white),
                    child: Material(
                      borderRadius: BorderRadius.circular(62),
                      elevation: 5,
                      child: Obx(
                        () => Row(
                          children: [
                            Expanded(
                                child: GestureDetector(
                              onTap: () {
                                // Print.p(controller.isDriverActive.value.toString());
                                controller.setDriverStatus(true);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(62),
                                    color: controller.isDriverActive.value
                                        ? ConstColor.primery
                                        : Colors.white),
                                child: Center(
                                  child: Obx(
                                    ()=> Text(
                                      "Active",
                                      style: TextStyle(
                                          color: controller.isDriverActive.value
                                              ? Color(0xFFEEEEEE)
                                              : Color(0xFF9C9C9C),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                            Expanded(
                                child: GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => standaredAlertBox(
                                        title: "Go Inactive?",
                                        subTitle:
                                            "Are you sure you want to go inactive?",
                                        firstButtonColor: Color(0xFFDDDDDD),
                                        secoundButtonColor: ConstColor.primery,
                                        onTapFirstButton: () {
                                          Get.back();
                                        },
                                        onTapSecoundButton: () {
                                          controller.setDriverStatus(false);
                                          Get.back();
                                        },
                                        textFirstButton: "No",
                                        textSecoundButton: "Yes"));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(62),
                                    color: controller.isDriverActive.value
                                        ? Colors.white
                                        : ConstColor.primery),
                                child: Center(
                                  child: Obx(
                                    ()=> Text(
                                      "Inactive",
                                      style: TextStyle(
                                          color: controller.isDriverActive.value
                                              ? Color(0xFF9C9C9C)
                                              : Color(0xFFEEEEEE),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
        // naviagtion bar
      ],
    ));
  }
}
