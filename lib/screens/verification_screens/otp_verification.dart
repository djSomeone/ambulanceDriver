
import 'package:ambulance_driver/screens/Home/home_page.dart';
import 'package:flutter/material.dart';
// import 'package:pinput/pinput.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
// import '../../api/api.dart';
// import 'controller/otp_verification_controller.dart';
import '../../api/api.dart';
import '../../main.dart';
import '../kyc_verification/kyc_verification.dart';
import '/utility/constants.dart';
// import '../HomePage/google_map_screen.dart';
import 'controller/otp_verification_controller.dart';
import 'controller/user_data_controller.dart';
// import 'google_map_screen.dart';
class MyVerify extends StatefulWidget {
  var number="";
  MyVerify({required this.number });

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {
  var controller=Get.put(optVerificationController());
  var userDataCon=Get.find<UserDataController>();


  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.reConstruct("");
    // we have to make the clickable for the login screen
    // con.setClick(true);
  }
  @override
  Widget build(BuildContext context) {




    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        height: ScreenSize.h,
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Container(
            // decoration: ConstBorder.bDeco,
            height: ScreenSize.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text('Empty')
                // ,
                SvgPicture.asset('asset/verificationScreenImg/verifyImg.svg',height: 150,width: 150,),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Phone Verification",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "We need to register your phone without getting started!",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(
                  height: 30,
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
                    controller.reConstruct(text);

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
                  otpPinFieldDecoration: OtpPinFieldDecoration.defaultPinBoxDecoration,
                ),

                const SizedBox(
                  height: 50,
                ),

                Obx(
                        ()
                    => SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor:
                              controller.otp.value.length==4?
                              ConstColor.primery
                                  : ConstColor.DarkGrey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          // onPressed: (){
                          //   controller.increament();
                          // },
                          onPressed:
                          controller.isClicked.value?(){toast(msg: "Please wait");}:controller.otp.value.length==4?verifyOtp:(){toast(msg: "Invaild OTP");},
                          child: Text(
                            "verify number",
                            style: TextStyle(color: Colors.black),
                          )),
                    )
                ),

                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          userDataCon.isClickable.value=true;
                          // Navigator.pushNamedAndRemoveUntil(
                          //   context,
                          //   'phone',
                          //       (route) => false,
                          // );
                        },
                        child: Text(
                          "Edit Phone Number ?",
                          style: TextStyle(color: Colors.black,fontSize: 14),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void verifyOtp()async{
    try{
      controller.setIsClicked(true);
      Print.p("after data");
      var res=await Api.ckeckOtp(widget.number,controller.otp.value.toString());
      Print.p(res.toString());

      Print.p("before redirect..");
      if(res["body"]["isVerified"]==true && res["body"]["isRegistered"]==true){
        //setting into the disk for persistency
        controller.setIsClicked(false);
        await localizeDriverData(widget.number, res);
        Get.offAll(Homepage());
      }
      else{
        if(res["body"]["isVerified"]==true){
          controller.setIsClicked(false);
          Get.to(KycVerification(number: widget.number,));

        }else{
          toast(msg: "Invailied OTP");
          controller.setIsClicked(false);
        }
      }
    }catch(x){
      toast(msg: "Some thing went wrong.");
      controller.setIsClicked(false);
      Print.p(x.toString());
    }
  }
}


