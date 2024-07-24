import 'package:ambulance_driver/screens/kyc_verification/controller/kyc_screen_controller.dart';
import 'package:ambulance_driver/screens/kyc_verification/module/titled_textFeiled.dart';
import 'package:ambulance_driver/screens/kyc_verification/module/title_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalDetails extends StatefulWidget {
   PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
   var firstNameController=TextEditingController();

   var lastNameController=TextEditingController();

   var altNumberController=TextEditingController();

   var emailController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          // this is for the title and sub Title
          Expanded(flex:1,
              child:TitleSubtitle(title: "Personal Details",subtitle: "Please provide your personal details to complete the KYC verification process.",),),
          // this is form
          Expanded(flex:5,child: SingleChildScrollView(
            child: SizedBox(
              height: 500,
              child: Column(
                children: [
                  TitledTextFeiled(title: "First Name", placeHolder: "Enter your First Name", controller: firstNameController,keyword: "firstName",),
                  TitledTextFeiled(title: "Last Name", placeHolder: "Enter your Last Name", controller: lastNameController,keyword: "lastName",),
                  TitledTextFeiled(title: "Alternative Number", placeHolder: "Enter any alternative number", controller: altNumberController,keyBoardType: TextInputType.number,maxlength: 10,keyword: "altNumber",),
                  TitledTextFeiled(title: "Email ID (Optional)", placeHolder: "Enter your Email ID", controller: emailController,keyBoardType: TextInputType.emailAddress,keyword: "email",),

                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
