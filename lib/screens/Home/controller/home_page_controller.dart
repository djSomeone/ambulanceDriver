import 'package:ambulance_driver/main.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../api/api.dart';
import '../../../utility/constants.dart';

class HomePageController extends GetxController
{
  Rx<LatLng> myCurrentPosition=LatLng(19.3820045, 62.8312572).obs;
  // this flag is used for the
  RxBool isSetCurrentPosition=false.obs;
  RxBool isDriverActive=false.obs;
  RxInt activePageIndex=0.obs;
  RxBool isThereNotification=false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    changeTocurrentLocation();
  //   initially we change  the state of  the  driver
     Api.changeDriverState(sharedInstance.getString("number"), false);

  }
  void reinitializeController()async{

    myCurrentPosition.value=LatLng(19.3820045, 62.8312572);
    isSetCurrentPosition.value=false;
    activePageIndex.value=0;
    isThereNotification.value=false;
    isDriverActive.value=true;
    changeTocurrentLocation();
    //   initially we change  the state of  the  driver
    await Api.changeDriverState(sharedInstance.getString("number"), true);
    Print.p("HomePageController reinitializeController");
  }
  void setIsThereNotification(bool value)
  {
    if(value!=isThereNotification.value)
      {
        isThereNotification.value=value;
      }
  }

  void setDriverStatus(bool value)
  async{

    if(value!=isDriverActive){
      isDriverActive.value=value;
      try{
        await Api.changeDriverState(sharedInstance.getString("number"), value);
      }catch(x){
        toast(msg: "Something went wrong");
        isDriverActive.value=!value;
      }


      toast(msg: isDriverActive.value?"Active":"Inactive");
    }

  }

  void changeTocurrentLocation()
 async
  {
    // Print.p("in change to current");
   Position x= await Geolocator.getCurrentPosition();
   setCurrentPosition(LatLng(x.latitude, x.longitude));
   isSetCurrentPosition.value=true;

    // Print.p("end change to current");

    // Print.p(myPosition.value.toString());
  }
  void setCurrentPosition(LatLng newPosition)
  {
    myCurrentPosition.value=newPosition;
  }
  void setActivePageIndex(int index)
  {
    if(activePageIndex.value!=index)
      {
        activePageIndex.value=index;
      }
  }
}