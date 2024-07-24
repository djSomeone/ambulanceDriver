import '/utility/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class optVerificationController extends GetxController
{

  Rx<String> otp="".obs;
  Rx<bool> len=true.obs;
  RxBool isClicked=false.obs;
// void increament()=>x.value++;
  void reConstruct(String x)
  {
    //   debugPrint('reconstruct===================$x');
    otp.value=x;
    if(otp.value.length==4){
      len.value=true;
    }
    else{
      len.value=false;
    }
    // Print.p('end of the reCon=========');
    //  Print.p('otp=${otp.value} and len=${len.value}');

  }
  void setIsClicked(bool newvalue)
  {
    isClicked.value=newvalue;
  }
}