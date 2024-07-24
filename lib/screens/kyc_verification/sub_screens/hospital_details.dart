import 'package:ambulance_driver/screens/kyc_verification/controller/kyc_screen_controller.dart';
import 'package:ambulance_driver/screens/kyc_verification/module/title_subtitle.dart';
import 'package:ambulance_driver/screens/kyc_verification/module/titled_textFeiled.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HospitalDetails extends StatefulWidget {
   HospitalDetails({super.key});

  @override
  State<HospitalDetails> createState() => _HospitalDetailsState();
}

class _HospitalDetailsState extends State<HospitalDetails> {
   var hospitalnameController=TextEditingController();

   var hospitaladdController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex:1,child: TitleSubtitle(title: "Hospital Details",subtitle: "Please provide the hospital details to complete the KYC verification process.",)),
        Expanded(flex:5,
            child: SingleChildScrollView(
          child: SizedBox(height: 400,child: Column(
            children: [
              TitledTextFeiled(title: "Hospital Name", placeHolder: "Enter Hospital Name", controller: hospitalnameController,keyword: "hospitalName",),
              TitledTextFeiled(title: "Hospital Address", placeHolder: "Enter complete Hospital Address", controller: hospitaladdController,maxline: 3,keyword: "hospitalAdd",),

            ],
          ),),
        )),
      ],
    );
  }
}
