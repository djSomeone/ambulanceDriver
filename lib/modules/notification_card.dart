import 'dart:ui';

import 'package:ambulance_driver/modules/titled_sub.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../utility/constants.dart';

class NotificationCard extends StatelessWidget {
  NotificationCard(
      {required this.borderRadius,
      required this.onAccept,
      required this.onDecline,
      this.patientName= "not provided",
        this.fare = "0",
        this.distance = "0.0",
        this.pickAddress = "undefine",
        this.dropAddress = "undefine"


      });
  BorderRadius borderRadius;
  final VoidCallback onDecline;
  final VoidCallback onAccept;
  var patientName = "not provided";
  var fare = "0";
  var distance = "0.0";
  var pickAddress = "undefine";
  var dropAddress = "undefine";

  @override
  Widget build(BuildContext context) {
    var txtgrey = TextStyle(color: Colors.blueGrey);
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: borderRadius),
            height: 240,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.black38,
                            child: Center(
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ),

                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                patientName,
                                style: TextStyle(fontSize: 16),
                              )),
                          Expanded(
                              child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Fare",
                                      style: txtgrey,
                                    ),
                                    Text(
                                      "\u{20B9}${fare}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: ConstColor.primery),
                                    )
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Distance",
                                      style: txtgrey,
                                    ),
                                    Text(
                                      "${distance}km",
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                ),
                              )
                            ],
                          ))
                          // Divider()
                        ],
                      )),
                  Divider(),
                  // pickupLocation
                  Expanded(
                      flex: 5,
                      child: standaredpickupDropCard(
                          pickupLocation: pickAddress,
                          dropLocation: dropAddress,
                          withoutBox: true)),

                  // // data and time
                  // Expanded(flex:1,child:
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 5),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Text("12:08 am",style: txtgrey,),
                  //       Text("12-08-2024",style: txtgrey,)
                  //     ],
                  //   ),
                  // )),
                ],
              ),
            ),
          ),
          Expanded(
              child: Container(
            height: 60,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: onDecline,
                    child: Row(
                      children: [
                        Icon(Icons.cancel, color: Colors.redAccent),
                        Text(
                          "Decline",
                          style: TextStyle(color: ConstColor.red),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  GestureDetector(
                    onTap: onAccept,
                    child: Row(
                      children: [
                        Icon(Icons.done_rounded,
                            color: CupertinoColors.systemGreen),
                        Text(
                          "Accept",
                          style: TextStyle(color: CupertinoColors.systemGreen),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
