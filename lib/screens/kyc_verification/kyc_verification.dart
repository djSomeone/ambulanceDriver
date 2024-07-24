// import 'package:ambulance_driver/screens/driver_registration/module/verification_tracker.dart';
import 'package:ambulance_driver/screens/kyc_verification/controller/kyc_screen_controller.dart';
import 'package:ambulance_driver/screens/kyc_verification/sub_screens/address_proof.dart';
import 'package:ambulance_driver/screens/kyc_verification/sub_screens/hospital_details.dart';
import 'package:ambulance_driver/screens/kyc_verification/sub_screens/id_proof.dart';
import 'package:ambulance_driver/screens/kyc_verification/sub_screens/personal_details.dart';
import 'package:ambulance_driver/screens/kyc_verification/sub_screens/vehical_photo.dart';
import 'package:ambulance_driver/screens/kyc_verification/thank_you_page.dart';
import 'package:ambulance_driver/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../api/api.dart';
import '../../main.dart';
import 'module/verification_tracker.dart';

class KycVerification extends StatefulWidget {
  var number;
  KycVerification({required this.number});

  @override
  State<KycVerification> createState() => _KycVerificationState();
}

class _KycVerificationState extends State<KycVerification> {
  var controller = Get.put(KycScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: standeredAppBar(title: 'KYC Verification'),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 100, child: VerificationTracker()),
              Expanded(
                  flex: 8,
                  child: Obx(() => controller.activePageIndex.value == 0
                      ? PersonalDetails()
                      : (controller.activePageIndex.value == 1
                          ? HospitalDetails()
                          : controller.activePageIndex.value == 2
                              ? AddressProof()
                              : controller.activePageIndex.value == 3
                                  ? IdProof()
                                  : VehicalPhoto()))),
              SizedBox(
                height: 50,
                child: Obx(
                  () => standaredButton(
                      title: controller.isUploading.value
                          ? "Uploading..."
                          : controller.activePageIndex.value == 4
                              ? "Confirm"
                              : "Next",
                      color: controller.isUploading.value
                          ? ConstColor.DarkGrey
                          : ConstColor.secoundary,
                      onPressed: controller.isUploading.value == false
                          ? (controller.activePageIndex.value == 4
                              // index according to the array start from 0
                              ? activeIndexFourHandler
                              : activeIndexOneHandler)
                          : () {
                              toast(msg: "Please wait while uploading");
                            }),
                ),
              ),
            ],
          ),
        ));
  }

  // this means that when active index value is 4 then this mwthod  will call
  void activeIndexFourHandler() async {
    var x = controller.pathOfImages.value;
    Print.p(x.toString());
    bool isValid=vahicalPhotoValidator();
    if(isValid){

      try {
        controller.isUploading.value = true;
        var res = await Api.uploadImageData(
            id: controller.tempId.toString(),
            aadharCardFront: x["aadharCardFront"],
            aadharCardBack: x["aadharCardBack"],
            driverLicense: x["driverLicense"],
            ambulancePhotoRear: x["ambulancePhotoRear"],
            ambulancePhotoBack: x["ambulancePhotoBack"]);
        controller.isUploading.value = false;
        if (res['status'] == 200) {
          toast(msg: res["body"]["message"].toString());
          Get.to(ThankYouPage());
          await localizeDriverData(widget.number, res);
        } else {
          toast(msg: "Something went wrong...");
        }
      } catch (x) {
        controller.isUploading.value = false;
        Print.p(
            "there is some exception in uploading phase of File-KycVerification.dart");
      }
    }
    else{
      toast(msg: "Please fill form");
    }

  }

//   this method is used for the when active index==1 and change the active index
  void activeIndexOneHandler() async {
    Print.p("clicked");
    bool isValid=true;
    // this is for adding driver data
    try {
      if (controller.activePageIndex.value == 1) {

          isValid=hospitalDetailValidator();
          if(isValid==false)
          {
            toast(msg: "Please fill the form");
          }
          else
          {
          var x = controller.driverData.value;
          Position p = await Geolocator.getCurrentPosition();
          toast(msg: "Please wait");
          var res = await Api.registerDriverData(
            number: widget.number,
            firstName: x["firstName"],
            lastName: x["lastName"],
            emailId: x["email"],
            altNumber: x["altNumber"],
            hspName: x["hospitalName"],
            hspAdd: x["hospitalAdd"],
            lat: p.latitude,
            lng: p.longitude,
          );
          Print.p(res["body"]["driver"]["_id"].toString());
          // this is id storing for image uploading api uses
          controller.setTempId(res["body"]["driver"]["_id"].toString());
          Print.p(res.toString());
        }
      }
      if(controller.activePageIndex.value == 0){
         isValid=personalDetailValidator();
        if(isValid==false)
          {
            toast(msg: "Please fill the form");
          }
      }
      if(controller.activePageIndex.value == 2){
         isValid=addressProofValidator();
        if(isValid==false)
          {
            toast(msg: "Please fill the form");
          }
      }
      if(controller.activePageIndex.value == 3){
         isValid=idProofValidator();
        if(isValid==false)
          {
            toast(msg: "Please fill the form");
          }
      }


    } catch (x) {
      Print.p("SomeThing Went wront in the registerDriverData section==");
    }
    if(isValid){
      controller.updateActivePageIndex();
    }
  }

  bool personalDetailValidator(){
    var listOfKeys=["firstName", "lastName","altNumber"];
    bool isValid=true;
    for(int i=0;i<listOfKeys.length;i++)
      {
        if(!(controller.driverData.value.containsKey(listOfKeys[i]))){
          isValid=false;
          break;
        }
      }
  return isValid;

  }

  bool hospitalDetailValidator(){
    var listOfKeys=["hospitalName", "hospitalAdd"];
    bool isValid=true;
    for(int i=0;i<listOfKeys.length;i++)
    {
      if(!(controller.driverData.value.containsKey(listOfKeys[i]))){
        isValid=false;
        break;
      }
    }
    return isValid;

  }
  bool addressProofValidator(){
    var listOfKeys=["aadharCardFront", "aadharCardBack"];
    bool isValid=true;
    for(int i=0;i<listOfKeys.length;i++)
    {
      if(controller.pathOfImages.value[listOfKeys[i]]==""){
        isValid=false;
        break;
      }
    }
    return isValid;

  }
  bool idProofValidator(){
    var listOfKeys=["driverLicense"];
    bool isValid=true;
    for(int i=0;i<listOfKeys.length;i++)
    {
      if((controller.pathOfImages.value[listOfKeys[i]]=="")){
        isValid=false;
        break;
      }
    }
    return isValid;

  }
  bool vahicalPhotoValidator(){
    var listOfKeys=["ambulancePhotoRear","ambulancePhotoBack"];
    bool isValid=true;
    for(int i=0;i<listOfKeys.length;i++)
    {
      if((controller.pathOfImages.value[listOfKeys[i]]=="")){
        isValid=false;
        break;
      }
    }
    return isValid;

  }




}
