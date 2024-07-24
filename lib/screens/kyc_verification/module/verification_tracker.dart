import 'package:ambulance_driver/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/kyc_screen_controller.dart';

class VerificationTracker extends StatelessWidget {
   VerificationTracker({super.key});

   var controller=Get.find<KycScreenController>();

  @override
  Widget build(BuildContext context) {
    var style=TextStyle(fontSize: 12);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Stack(alignment: Alignment.center,children: [
          Container(color: ConstColor.DarkGrey,width: ScreenSize.w*0.9,
              height: 10,
              ),
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [

                 Dot(index: 0,),
                 Dot(index: 1,),
                 Dot(index: 2,),
                 Dot(index: 3,),
                 Dot(index: 4,),


          ],)
                ],),
        ),
      // name of the process
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
          SizedBox(
            width:50,
            height: 40,
            child: Column(
              children: [
                Expanded(child: Text("Personal",style:style,textAlign: TextAlign.center)),
                Expanded(child: Text("Details",style: style,textAlign: TextAlign.center)),
              ],
            ),
          ),
          SizedBox(
            width:50,
            height: 40,
            child: Column(
              children: [
                Expanded(child: Text("Hospital",style:style,textAlign: TextAlign.center)),
                Expanded(child: Text("Details",style: style,textAlign: TextAlign.center)),
              ],
            ),
          ),
          SizedBox(
            width:50,
            height: 40,
            child: Column(
              children: [
                Expanded(child: Text("Address",style:style,textAlign: TextAlign.center)),
                Expanded(child: Text("Proof",style: style,textAlign: TextAlign.center)),
              ],
            ),
          ),
          SizedBox(
            width:50,
            height: 40,
            child: Column(
              children: [
                Expanded(child: Text("ID",style:style,textAlign: TextAlign.center)),
                Expanded(child: Text("Proof",style: style,textAlign: TextAlign.center)),
              ],
            ),
          ),
          SizedBox(
            width:50,
            height: 40,
            child: Column(
              children: [
                Expanded(child: Text("Vehical",style:style,textAlign: TextAlign.center)),
                Expanded(child: Text("Photo",style: style,textAlign: TextAlign.center)),
              ],
            ),
          ),


        ],),
      )
      ],
    );
  }
}
class Dot extends StatelessWidget {
  int index;
   Dot({required this.index});
   var controller=Get.find<KycScreenController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Container(height: 32,width: 32,decoration: BoxDecoration(color:index>controller.activePageIndex.value?ConstColor.grey:ConstColor.primery,
          borderRadius: BorderRadius.circular(16),
          border: index>controller.activePageIndex.value?Border.all(color: ConstColor.DarkGrey):Border.all(color: Colors.transparent)),
        child: Center(child: controller.activePageIndex.value==index?
        Icon(Icons.circle_rounded,color:Colors.white,size: 6,):
        (index<controller.activePageIndex.value?Icon(Icons.done_rounded,color:Colors.white,size: 16,):Text((index+1).toString(),style: TextStyle(color: ConstColor.DarkGrey),)),),),
    );
  }
}

