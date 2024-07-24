import 'package:ambulance_driver/screens/kyc_verification/module/title_subtitle.dart';
import 'package:flutter/material.dart';

import '../../../utility/constants.dart';
import '../module/title_upload_box.dart';

class VehicalPhoto extends StatelessWidget {
  const VehicalPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(flex:1,child: TitleSubtitle(title: "Vehicle Photos",subtitle: 'Please upload your Vehicle photos for verification',)),
      Expanded(flex:5,child: SingleChildScrollView(
        child: SizedBox(
          height: 500,
          width: ScreenSize.w,
          child: Column(children: [
            TitleUploadBox(title: "Ambulance photo (Rear)",keyword: "ambulancePhotoRear",),
            TitleUploadBox(title: "Ambulance photo (Back)",keyword: "ambulancePhotoBack",),
          ],),
        ),
      )),
    ],);
  }
}
