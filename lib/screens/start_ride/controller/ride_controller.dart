import 'package:ambulance_driver/screens/Home/controller/home_page_controller.dart';
import 'package:ambulance_driver/socketHandler/socket_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utility/constants.dart';

class RideController extends GetxController
{
  RxMap<String,dynamic> requestData=Map<String,dynamic>().obs;
  // automqtically caonnect and handle the event
  var socket=SocketHandler();
  RxBool isOtpVerified=false.obs;




  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    socket.socketDisconnect();

  }

  void reinitializeController(){
    isOtpVerified.value=false;
    Print.p("reinitializeController RideController");
  }
  void setRequestData({required Map<String, dynamic> newData})
  {
    requestData.value={};
    requestData.value=newData;
    Print.p("setting request data successfully");
    Print.p(requestData.value.toString());


  }
   void otpVerified(bool value) {

      isOtpVerified.value = value;

  }



}