import 'package:ambulance_driver/api/api.dart';
import 'package:ambulance_driver/main.dart';
import 'package:get/get.dart';

import '../../../utility/constants.dart';

class RideHistoryController extends GetxController
{
  RxList driverHistoryData=[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDriverHistoryData();
  }

  void reinitializeController()async{
    driverHistoryData.value=[];
    await getDriverHistoryData();
    Print.p("reinitializeController RideHistoryController");
  }
  Future<void> getDriverHistoryData()async{
    Print.p("in getDriverHistoryData");
    var number=sharedInstance.getString("number");
    try{
      var res=await Api.getRideHistory(number);
      if(res["message"]=="Success"){
        driverHistoryData.value=res["body"];
      }

    }catch(x){
      Print.p("somthing went wrong in getRiderHistoryData");
    }




  }
}