import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../main.dart';
import '../modules/titled_sub.dart';
class TextSize
{
  static var headingFontSize=24.0;

}

class ConstColor
{
  static var red=Colors.red;
  static var primery=Color(0xFFF29313);
  // static var primery=Color(0xFFF80000);
  static var secoundary=Color(0xFFD96D1F);
  static var grey=Color(0xFFFDFDFD);
  static var DarkGrey=Color(0xFFD2D2D2);

  static var yellow=Color(0xFFF6C41E);
// static
}

class ScreenSize
{
  // becuse to get the current size we need context because of that i had initialized with 0 and when we load first screen on that
  // time we raassigned it with screen orignal size
  static var h=0.0;
  static var w=0.0;
}

class ConstBorder{
  static var bDeco=BoxDecoration(border: Border.all(color: Colors.red,width: 5));
}

class Print{
  static void p(String x)
  {
    debugPrint("======================$x====================");
  }
}

class ConstIcon{
  static var backIcon=Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,);
}

// loop runs until and unless you grant the permission
Future<void> getPermission() async {
  while(!await Permission.location.isGranted)
  {
    await Permission.location.request();
  }
  Print.p("End of the GetPermission Method");

}
// diffrent payment methods
enum PaymentMethod
    {
  payByCash,upi,wallets,debitCard
}

Future<void> toast({required msg})async{
  await Fluttertoast.showToast(msg:msg ,backgroundColor: Colors.grey,textColor: Colors.black);

}

AppBar standeredAppBar({required String title,bool enableBackButton=false})
{
  return  AppBar(leading:enableBackButton? IconButton(icon:ConstIcon.backIcon,
    onPressed: (){Get.back();},
    color: Colors.white,):Text(""),
    title:Text(title,
      style: TextStyle(fontSize: 14,color: Colors.white),),
    centerTitle: true,backgroundColor: ConstColor.secoundary,

  );
}

Widget standaredButton({required String title,required void Function() onPressed ,var color=const Color(0xFFD96D1F)})
{
  return SizedBox(
    height: 50,
    child: ElevatedButton(


        style:ElevatedButton.styleFrom(backgroundColor:color,
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), // Set your desired radius
          ), ),

        onPressed: onPressed, child: Center(child: Text(title,style: TextStyle(color: Colors.white),),)),
  );

}

Widget standaredAlertBox({required title,required subTitle,required firstButtonColor,required secoundButtonColor,required onTapFirstButton,
  required onTapSecoundButton,required textFirstButton,required textSecoundButton}){

  return    AlertDialog(title:Text(title),content: Text(subTitle),actions: [
    GestureDetector(
      onTap:onTapFirstButton,
      child: Container(decoration:BoxDecoration(color: firstButtonColor,borderRadius: BorderRadius.circular(6)),
        height: 40,width: 100,
        child: Center(child: Text(textFirstButton,style: TextStyle(color: Colors.black,fontSize: 14),),),),
    ),
    GestureDetector(
      onTap:onTapSecoundButton,
      child: Container(decoration:BoxDecoration(color: secoundButtonColor,borderRadius: BorderRadius.circular(6)),
        height: 40,width: 100,
        child: Center(child: Text(textSecoundButton,style: TextStyle(color: Colors.white,fontSize: 14),),),),
    ),

  ],backgroundColor: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),);

}

Widget standaredpickupDropCard(
    {pickupLocation =
    "Neelyog Bldg, Shah Bahadur Nagar, RajavNeelyog Bldg, Shah Bahadur Nagar, Rajav",
      dropLocation =
      "Neelyog Bldg, Shah Bahadur Nagar, RajavNeelyog Bldg, Shah Bahadur Nagar, Rajav",


      withoutBox=false,
    }) {
  return Material(
    borderRadius: withoutBox?null:BorderRadius.circular(10),
    elevation: withoutBox?0.0:10,
    child: Container(
      height: withoutBox?null:125,
      width: ScreenSize.w,
      color: withoutBox?Color(0xFFFDFDFD):null,
      padding: withoutBox?EdgeInsets.zero:EdgeInsets.symmetric(vertical: 20),
      decoration: withoutBox?null:BoxDecoration(
          color: Color(0xFFFDFDFD), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          // pickup and drop location icons rep
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.location_pin,
                        color: Colors.green,
                      )),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.lens,
                              size: 4,
                            )),
                        Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.lens,
                              size: 4,
                            )),
                        Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.lens,
                              size: 4,
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.location_pin,
                        color: ConstColor.primery,
                      )),
                ],
              )),
          // pick uo drop feildes
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: LocationSelectorCard(
                          title: "Pickup Location",
                          value: pickupLocation,
                          titleColor: Colors.green,
                          onTap:(){})),
                  Divider(),
                  Expanded(
                      child: LocationSelectorCard(
                        title: "Drop Location",
                        value: dropLocation,
                        titleColor: ConstColor.primery,
                        onTap: (){},
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Future<String?> pickFile()async
{
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if(result==null)
    {
      return null;
    }
  else
    {
      return result.files.single.path.toString();
    }

}

Future<bool> localizeDriverData(String number,var res)async{
  try{

    var name = res["body"]["driver"]["name"];
    var altNum = res["body"]["driver"]["alternativeNumber"];
    var email = res["body"]["driver"]["emailId"];
    var img=res["body"]["driver"]["image"];
    await sharedInstance.setString("userName", name);
    await sharedInstance.setString("number", number);
    await sharedInstance.setString("altNum", altNum);
    await sharedInstance.setString("email", email);
    await sharedInstance.setString("img",img);
    Print.p("Stored all date");
    return true;
  }catch(x)
  {
    Print.p("In LocalizeDriver data method=="+x.toString());
    return false;
  }
}

void removeUserData()async
{

  await sharedInstance.remove('userName');
  await sharedInstance.remove('number');
  await sharedInstance.remove('altNum');
  await sharedInstance.remove('email');
  await sharedInstance.remove('img');
  Print.p("Removed all data");
}