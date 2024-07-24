import 'dart:async';

// import 'package:ambulance_driver/screens/ride_otp_verification/ride_otp_verification.dart';
import 'package:ambulance_driver/api/api.dart';
import 'package:ambulance_driver/screens/payment/collect_cash.dart';
import 'package:ambulance_driver/screens/ride_otp_verification/ride_otp_verification.dart';
import 'package:ambulance_driver/screens/start_ride/controller/ride_controller.dart';
import 'package:ambulance_driver/screens/start_ride/controller/tracking_cntroller.dart';
// import 'package:ambulance_driver/screens/start_ride/ride_otp_verification/ride_otp_verification.dart';
import 'package:ambulance_driver/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';
import '../../modules/titled_sub.dart';
import '../Home/controller/home_page_controller.dart';

class StartRide extends StatefulWidget {
  const StartRide({super.key});

  @override
  State<StartRide> createState() => _StartRideState();
}

class _StartRideState extends State<StartRide> {

 GoogleMapController? _controller ;
  // used only for the getting the current location of the driver
  var homeController = Get.find<HomePageController>();
  // this is use for the setting the check for the element in the screen
  var rideController = Get.find<RideController>();
  var trackingCon=Get.put(TrackingCntroller());
 late BitmapDescriptor driver=BitmapDescriptor.defaultMarker;
 late BitmapDescriptor pickUpIcon=BitmapDescriptor.defaultMarker;
 late BitmapDescriptor dropIcon=BitmapDescriptor.defaultMarker;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCustomIcon();

    // setCustomIcon().then((_){trackingCon.setInitialMarker(ambulanceicon);});

  }
  void setCustomIcon()async
  {
    driver = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'asset/ambulance.png',
    );
    pickUpIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'asset/p.png',
    );
    dropIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'asset/d.png',
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    trackingCon.dispose();
    Api.changeDriverState(sharedInstance.getString("number"), false);
  }

  @override
  Widget build(BuildContext context) {
    var pickData =
    Get.find<RideController>().requestData.value["pickupLocation"];
    var dropData = Get.find<RideController>().requestData.value["dropLocation"];
    return Scaffold(
        body: Stack(
      children: [
        // google map
        Obx(

              (){
                if(_controller!=null)
                {
                  _controller!.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(  target: homeController.myCurrentPosition.value,
                        zoom: 14.4746, )
                  )
                  );
                }

            return GoogleMap(
              zoomControlsEnabled: false,
              mapType: MapType.terrain,
              initialCameraPosition: CameraPosition(
                target: homeController.myCurrentPosition.value,
                zoom: 14.4746,
              ),
              polylines: trackingCon.polyline.value,
              markers:<Marker>{
                Marker(
                  markerId: MarkerId('Driver'),
                  icon: driver,
                  position: Get.find<HomePageController>().myCurrentPosition.value,
                ),
                trackingCon.isOTPVerified.value?
                    Marker(
                      markerId: MarkerId('dropLocation'),
                      icon: dropIcon,
                      infoWindow: InfoWindow(title:"Drop Location"),
                      position: LatLng(dropData["latitude"], dropData["longitude"]),
                    ):
                Marker(
                  markerId: MarkerId('pickLocation'),
                  icon: pickUpIcon,
                  infoWindow: InfoWindow(title:"PickUp Location"),
                  position: LatLng(pickData["latitude"], pickData["longitude"]),
                ),
              },
              onMapCreated: (GoogleMapController controller) {
                _controller=controller;
              },
            );
          },
        ),

        // pickup drop
        Obx(
          () => rideController.isOtpVerified.value
              ? Text("")
              : Positioned(
                  top: 30,
                  right: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: standaredpickupDropCard(
                      pickupLocation:
                          rideController.requestData.value["pickupAddress"],
                      dropLocation:
                          rideController.requestData.value["dropAddress"],
                    ),
                  ),
                ),
        ),
        // bottom
        Obx(
          () => rideController.isOtpVerified.value
              ?
              // there is option for the dropOff
              Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    height: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(children: [
                        Expanded(
                            child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Text(
                                      "${trackingCon.result.totalDuration} (${trackingCon.result.totalDistance} Km)",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                )),
                                Expanded(
                                    child: Text(
                                  "ETA - 08:45",
                                  style: TextStyle(fontSize: 14),
                                )),
                              ],
                            )),
                            Icon(
                              Icons.directions_outlined,
                              size: 34,
                            )
                          ],
                        )),
                        Divider(),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Text(
                                    "Drop Location",
                                    style: TextStyle(
                                        color: ConstColor.primery, fontSize: 12),
                                  )),
                              Expanded(
                                  child: Obx(
                                   ()=> Text(
                                      rideController.requestData.value["dropAddress"].toString(),
                                     style: TextStyle(fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )),
                            ],
                          ),
                        )),
                        standaredButton(
                            title: "Drop Off",
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => standaredAlertBox(
                                      title: "Drop off?",
                                      subTitle:
                                          "Are you sure you want to drop the passenger here?",
                                      firstButtonColor: Color(0xFFDDDDDD),
                                      secoundButtonColor: ConstColor.primery,
                                      onTapFirstButton: () {
                                        Get.back();
                                      },
                                      onTapSecoundButton: () {
                                        rideController.socket.dropOffEvent(rideController.requestData.value);
                                        Get.off(CollectCashScreen());
                                      },
                                      textFirstButton: "No",
                                      textSecoundButton: "Yes"));
                            }),
                      ]),
                    ),
                  ))
              :
              //     this is for when otp is not verified
              Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // this is at the top part of the model
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        foregroundImage:
                                            AssetImage("asset/profilePic.png"),
                                        radius: 25,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                          rideController
                                              .requestData.value["patientName"],
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF1B1B1B)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                          Border.all(color: Color(0xFFE8E8E8))),
                                  child: GestureDetector(
                                    onTap: () async {
                                      var reqData = Get.find<RideController>()
                                          .requestData
                                          .value;
                                      final url =
                                          'tel:${reqData["driverPhoneNumber"]}';
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        toast(
                                            msg:
                                                "Could not launch phone dialer");
                                      }
                                    },
                                    child: Center(
                                      child: Icon(
                                        Icons.call,
                                        color: ConstColor.primery,
                                      ),
                                    ),
                                  ),
                                )
                                // StarDisplay(value: 4,)
                              ],
                            ),
                          ),
                          Divider(),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Payment Method -Cash",
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xFF3E4958)),
                                ),
                                Text(
                                  "\u20B9${rideController.requestData.value["fare"]}",
                                  style: TextStyle(
                                      fontSize: 20, color: ConstColor.primery),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Request OTP from the passenger upon reaching the pickup location.",
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  standaredButton(
                                      title: "Request Otp",
                                      onPressed: () {
                                        Get.to(RiderOtpVerification());
                                      })
                                ],
                              ))
                        ],
                      ),
                    ),
                  )),
        )
      ],
    ));
  }
}
