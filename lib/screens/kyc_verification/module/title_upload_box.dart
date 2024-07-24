import 'dart:io';

import 'package:ambulance_driver/utility/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controller/kyc_screen_controller.dart';

class TitleUploadBox extends StatelessWidget {
  var title;
  var keyword;


   TitleUploadBox({required this.title,required this.keyword});

   var controller=Get.find<KycScreenController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(title,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
          ),
          //box
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                  height: 158,
                  width: ScreenSize.w,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(28),border: Border.all(color: Color(0xFFCBD0DC))),
                    child: Obx(
                            (){
                              Print.p("obx rebuild");
                              Print.p(controller.pathOfImages.value[keyword.toString()]);
                          return
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:
                          controller.pathOfImages.value[keyword.toString()] ==
                                  ""
                              ? [
                                  Padding(
                                    padding: const EdgeInsets.all(28.0),
                                    child: SvgPicture.asset(
                                        "asset/kycImgs/upload.svg"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      "Choose a image or Capture image",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  Text(
                                    "(Max. File size: 10 MB)",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF353535)),
                                  ),
                                ]
                              : [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: SizedBox(
                                        height: 50,
                                        child: SvgPicture.asset(
                                            "asset/thankyouPage/done.svg")),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      "File added successfully",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                    );
                  }),
              
                  ),
            )
            ),
          ],),
    );
  }

  void onTap()
  async{
    Print.p(keyword);
  var path=await pickFile();

    if (path != null) {
      controller.addDataInPathOfImages(keyword, path.toString());
      Print.p(path.toString());
    } else {
      print("No file selected");
    }

  Print.p(path.toString());
  }
}
