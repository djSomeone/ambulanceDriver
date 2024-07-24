import 'package:ambulance_driver/screens/kyc_verification/module/title_subtitle.dart';
import 'package:ambulance_driver/screens/kyc_verification/module/title_upload_box.dart';
import 'package:ambulance_driver/utility/constants.dart';
import 'package:flutter/material.dart';

class AddressProof extends StatelessWidget {
  const AddressProof({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(children: [
        Expanded(flex:1,child: TitleSubtitle(title: "Address Proof",subtitle: "Please upload your Aadhaar Card for address proof",)),
        Expanded(flex:5,child: SingleChildScrollView(
          child: SizedBox(
            height: 500,
            width: ScreenSize.w,
            child: Column(children: [
              TitleUploadBox(title: "Aadhaar Card (Front)",keyword: "aadharCardFront",),
              TitleUploadBox(title: "Aadhaar Card (Back)",keyword: "aadharCardBack",),
            ],),
          ),
        )),
      ],),
    );
  }
}
