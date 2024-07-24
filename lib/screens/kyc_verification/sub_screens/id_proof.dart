import 'package:ambulance_driver/screens/kyc_verification/module/title_subtitle.dart';
import 'package:ambulance_driver/screens/kyc_verification/module/title_upload_box.dart';
import 'package:flutter/material.dart';

class IdProof extends StatelessWidget {
  const IdProof({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(flex:1,child: TitleSubtitle(title: "ID Proof",subtitle: "Please upload your driver license for verification",)),
      Expanded(flex:5,child: TitleUploadBox(title: "Driver License",keyword: "driverLicense",)),
    ],);
  }
}
