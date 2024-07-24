import 'package:ambulance_driver/utility/constants.dart';
import 'package:get/get.dart';

class KycScreenController extends GetxController
{
  RxInt activePageIndex=0.obs;
  // this is used in uploading driver image
  RxString tempId="".obs;
  RxMap driverData=RxMap({"email":"xyz@gmail.com"});
  RxMap pathOfImages= RxMap({
    "aadharCardFront":"",
    "aadharCardBack":"",
    "driverLicense":"",
    "ambulancePhotoRear":"",
    "ambulancePhotoBack":""
  });

  RxBool isUploading=false.obs;

  void updateActivePageIndex()
  {
    if(activePageIndex.value==4)
      {
        activePageIndex.value=0;
      }
    else
      {
        activePageIndex.value=activePageIndex.value+1;
      }
    Print.p(activePageIndex.value.toString());

  }
  void setTempId(String id)
  {
    tempId.value=id;
  }
  void addDataInDriverData(String key,String value)
  {
    var lastMap=driverData.value;
    lastMap.addIf(true, key, value);
    driverData.value=lastMap;
  }
  void addDataInPathOfImages(String key,String value)
  {
    Print.p('LastValue\n$pathOfImages');

    Map lastMap=pathOfImages.value;
    pathOfImages.value={};
    lastMap[key]=value;
    pathOfImages.value=lastMap;
  }
}

