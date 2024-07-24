import 'package:ambulance_driver/main.dart';
import 'package:ambulance_driver/utility/constants.dart';
import 'package:get/get.dart';

import '../../../api/api.dart';

class ProfileController extends  GetxController
{
  RxString imgUrl="".obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    imgUrl.value=sharedInstance.getString("img");
  }

  void updatePic()
  async
  {
    var path=await pickFile();
    if(path!=null)
      {
        toast(msg: "Updating profile pic...");
      try  {
        var res = await Api.updatePic(sharedInstance.getString("number"), path);
        if(res["status"]==200){
          var newImgurl = res["body"]["image"];
          imgUrl.value=newImgurl;
          await sharedInstance.setString("img",newImgurl);
          toast(msg: "Updated");
        }
        else{
          toast(msg: "some issue in response of upload image");
        }
      }catch(x)
    {
      Print.p(x.toString());
    }
    }
  }
}