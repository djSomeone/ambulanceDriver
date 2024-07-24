import 'package:ambulance_driver/screens/start_ride/controller/ride_controller.dart';
import 'package:ambulance_driver/screens/verification_screens/controller/otp_verification_controller.dart';

import 'package:flutter/material.dart';
// import 'package:pinput/pinput.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
// import '../../api/api.dart';
// import 'controller/otp_verification_controller.dart';

import '../../api/api.dart';
import '../Home/controller/home_page_controller.dart';
import '../start_ride/controller/tracking_cntroller.dart';
import '/utility/constants.dart';
import 'otpSuccessScreen.dart';
// import '../HomePage/google_map_screen.dart';

// import 'google_map_screen.dart';
class RiderOtpVerification extends StatefulWidget {
  RiderOtpVerification();

  @override
  State<RiderOtpVerification> createState() => _RiderOtpVerificationState();
}

class _RiderOtpVerificationState extends State<RiderOtpVerification> {
  var otpController = Get.put(optVerificationController());

  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    otpController.reConstruct("");
    otpController.dispose();
    // we have to make the clickable for the login screen
    // con.setClick(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: standeredAppBar(title: "Verify Code", enableBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "OTP Verification",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                Text(
                  "Enter the code that we have sent SMS",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(
                  height: 50,
                ),

                ///  Otp pin Controller

                OtpPinField(
                  key: _otpPinFieldController,

                  ///in case you want to enable autoFill
                  autoFillEnable: false,

                  ///for Ios it is not needed as the SMS autofill is provided by default, but not for Android, that's where this key is useful.
                  textInputAction: TextInputAction.done,

                  ///in case you want to change the action of keyboard
                  /// to clear the Otp pin Controller
                  onSubmit: (text) {
                    print('Entered pin is $text');

                    // controller.reConstruct(text);

                    /// return the entered pin
                  },
                  onChange: (text) {
                    print('Enter on change pin is $text');
                    otpController.reConstruct(text);

                    /// return the entered pin
                  },

                  /// to decorate your Otp_Pin_Field
                  otpPinFieldStyle: OtpPinFieldStyle(
                    /// border color for inactive/unfocused Otp_Pin_Field
                    defaultFieldBorderColor: Colors.transparent,

                    /// border color for active/focused Otp_Pin_Field
                    activeFieldBorderColor: Colors.black,

                    /// Background Color for inactive/unfocused Otp_Pin_Field
                    defaultFieldBackgroundColor: Colors.grey.withOpacity(0.7),

                    /// Background Color for active/focused Otp_Pin_Field
                    activeFieldBackgroundColor: Colors.grey.withOpacity(0.7),

                    /// Background Color for filled field pin box
                    filledFieldBackgroundColor: Colors.grey.withOpacity(0.7),

                    /// border Color for filled field pin box
                    filledFieldBorderColor: Colors.black,
                    //
                    /// gradient border Color for field pin box
                    // fieldBorderGradient: LinearGradient(colors: [Colors.black, Colors.redAccent]),
                  ),
                  maxLength: 4,

                  /// no of pin field
                  showCursor: true,

                  /// bool to show cursor in pin field or not
                  cursorColor: Colors.black,

                  /// to choose cursor color

                  ///bool which manage to show custom keyboard
                  // showCustomKeyboard: true,
                  /// Widget which help you to show your own custom keyboard in place if default custom keyboard
                  // customKeyboard: Container(),
                  ///bool which manage to show default OS keyboard
                  // showDefaultKeyboard: true,

                  /// to select cursor width
                  cursorWidth: 1,

                  /// place otp pin field according to yourself
                  mainAxisAlignment: MainAxisAlignment.center,

                  autoFocus: false,

                  /// predefine decorate of pinField use  OtpPinFieldDecoration.defaultPinBoxDecoration||OtpPinFieldDecoration.underlinedPinBoxDecoration||OtpPinFieldDecoration.roundedPinBoxDecoration
                  ///use OtpPinFieldDecoration.custom  (by using this you can make Otp_Pin_Field according to yourself like you can give fieldBorderRadius,fieldBorderWidth and etc things)
                  otpPinFieldDecoration:
                      OtpPinFieldDecoration.defaultPinBoxDecoration,
                ),
              ],
            )),
            Obx(() => SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: otpController.otp.value.length == 4
                              ? ConstColor.primery
                              : ConstColor.DarkGrey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      // onPressed: (){
                      //   controller.increament();
                      // },
                      onPressed: () async {
                        toast(msg: "Verifing");
                        var temp = otpController.otp.value;
                        var con = Get.find<RideController>();
                        try {
                          await Api.rideOTPVarify(
                              con.requestData.value["requestId"].toString(),
                              temp.toString());
                          toast(msg: "Verified Successfully");

                          Get.off(OtpSuccessScreen());
                          Get.find<TrackingCntroller>().isOTPVerified.value=true;
                          var reqData=Get.find<RideController>().requestData.value;
                          await Get.find<TrackingCntroller>().setDrirection(isgoignToDropLocation: true,
                              origin: Get.find<HomePageController>()
                                  .myCurrentPosition
                                  .value,
                              dest: LatLng(reqData["dropLocation"]["latitude"],reqData["dropLocation"]["longitude"]));
                        } catch (x) {
                          toast(msg: "Invalid OTP");
                        }

                        // Get.off(OtpSuccessScreen());
                      },
                      child: Text(
                        "Verify",
                        style: TextStyle(color: Colors.black),
                      )),
                ))
            // Text('Empty')
            // ,
          ],
        ),
      ),
    );
  }
}
