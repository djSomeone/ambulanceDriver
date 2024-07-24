import 'package:ambulance_driver/screens/Home/home_page.dart';
import 'package:ambulance_driver/screens/ProfilePage/controller/profile_controller.dart';
import 'package:ambulance_driver/screens/ProfilePage/module/title_value_divider.dart';
import 'package:ambulance_driver/screens/verification_screens/login_screen.dart';
import 'package:ambulance_driver/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/api.dart';
import '../../main.dart';
import '../verification_screens/controller/user_data_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  var controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: standeredAppBar(title: "My Profile"),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Obx(
                            () => Container(
                                height: 100,
                                width: 100,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color: ConstColor.secoundary,
                                    ),
                                    borderRadius: BorderRadius.circular(50)),
                                child: CircleAvatar(
                                  foregroundImage:
                                      NetworkImage(controller.imgUrl.value),
                                )),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () async {
                                  controller.updatePic();
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: ConstColor.secoundary),
                                  child: Center(
                                    child: Icon(
                                      Icons.edit,
                                      color: ConstColor.DarkGrey,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                      Text(
                        sharedInstance.getString("userName"),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      )
                    ],
                  )),
              Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: ListView(
                      children: [
                        TitleValueDivider(
                            title: "Email",
                            value: sharedInstance.getString("email")),
                        TitleValueDivider(
                            title: "Mobile Number",
                            value: "+91 ${sharedInstance.getString("number")}"),
                        TitleValueDivider(
                            title: "Alternative Number",
                            value: "+91 ${sharedInstance.getString("altNum")}"),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Help & Support"),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Privacy Policy"),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text("Log Out?"),
                                      content:
                                          Text("Are you sure want to log out?"),
                                      actions: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            height: 40,
                                            width: 100,
                                            child: Center(
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            Get.put(UserDataController())
                                                .isClickable
                                                .value = true;
                                            Get.offAll(SendOtpScreen());

                                            removeUserData();

                                            toast(msg: "LogOut");
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: ConstColor.primery,
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            height: 40,
                                            width: 100,
                                            child: Center(
                                              child: Text(
                                                "Log Out",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                    ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Logout",
                                  style:
                                      TextStyle(color: ConstColor.secoundary),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: ConstColor.secoundary,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }
}
