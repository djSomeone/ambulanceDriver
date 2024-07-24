import 'package:ambulance_driver/screens/start_ride/controller/ride_controller.dart';
import 'package:ambulance_driver/utility/directions_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../api/api.dart';
import '../../../utility/constants.dart';
import '../../Home/controller/home_page_controller.dart';

class TrackingCntroller extends GetxController {
  // RxSet<Marker> mark = <Marker>{}.obs;
  RxSet<Polyline> polyline = <Polyline>{}.obs;
  RxBool isOTPVerified=false.obs;
  late Directions result;
  var reqData=Get.find<RideController>().requestData.value;
  var homeCon=Get.find<HomePageController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    setDrirection(origin: homeCon.myCurrentPosition.value, dest: LatLng(reqData["pickupLocation"]["latitude"],reqData["pickupLocation"]["longitude"]));
    // setInitialMarker();
  }

  Future<void> setDrirection(

      {required LatLng origin, required LatLng dest, bool isgoignToDropLocation=false}) async {
    Print.p("in setDrirection()");
    Directions? result =
        await Api.getDirections(origin: origin, destination: dest);
    this.result=result!;
    if (result != null) {
      polyline.value = <Polyline>{};
      var updatedRoute = <Polyline>{
        Polyline(
          jointType: JointType.round,
          polylineId: const PolylineId('overview_polyline'),
          color: isgoignToDropLocation?ConstColor.primery:Color(0xFF36A83B),
          width: 4,
          points: result.polylinePoints
              .map((e) => LatLng(e.latitude, e.longitude))
              .toList(),
        )
      };
      polyline.value = updatedRoute;
    } else {
      toast(msg: "Can't found Direction");
    }
  }

  // void setMarkerToCurrent()
  // {
  //
  // }
}
