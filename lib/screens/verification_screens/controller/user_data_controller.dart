import 'package:get/get.dart';

class UserDataController extends GetxController
{

  Rx<String> mobileNo="".obs;
  Rx<String> UserName="".obs;
  Rx<bool> isClickable=true.obs;

  void setMobileNo(String newNumber)
  {
    mobileNo.value=newNumber;
  }
  void setUserName(String userName)
  {
    UserName.value=userName;
  }
  void setClick(bool x){
    isClickable.value=x;
  }
}