import 'package:ambulance_driver/modules/rating_star.dart';
import 'package:ambulance_driver/utility/constants.dart';
import 'package:flutter/material.dart';

import '../../../modules/titled_sub.dart';

class MyRideCard extends StatelessWidget {
  var date;
  var time;
  var paymentMethod;
  var amount;
  var pickUpAdd;
  var dropAdd;
  var patientName;
  var rating;
  MyRideCard(
      {required this.date,
      required this.amount,
      required this.dropAdd,
      required this.patientName,
      required this.paymentMethod,
      required this.pickUpAdd,
      required this.rating,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFE8E8E8)),
            borderRadius: BorderRadius.circular(4)),
        height: 250,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // datetime
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date,
                    style: TextStyle(color: Color(0xFF777B81), fontSize: 12),
                  ),
                  Text(
                    time,
                    style: TextStyle(color: Color(0xFF777B81), fontSize: 12),
                  ),
                ],
              ),
              // payment method and price
              Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Method -${paymentMethod}",
                        style:
                            TextStyle(fontSize: 15, color: Color(0xFF3E4958)),
                      ),
                      Text(
                        "\u20B9$amount",
                        style:
                            TextStyle(fontSize: 20, color: ConstColor.primery),
                      ),
                    ],
                  )),
              Divider(),
              Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      // pickup and drop location icons rep
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 0),
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
                            ),
                          )),
                      // pick uo drop feildes
                      Expanded(
                        flex: 10,
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 10, bottom: 10, right: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(

                                pickUpAdd,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(

                                dropAdd,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
              Divider(),
              // Expanded(flex:4,child: Placeholder()),
              Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Row(
                          children: [
                            CircleAvatar(
                              foregroundImage:
                                  NetworkImage("https://as2.ftcdn.net/v2/jpg/00/64/67/27/1000_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg"),
                              radius: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                patientName,
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xFF1B1B1B)),
                              ),
                            )
                          ],
                        ),
                      ),
                      StarDisplay(
                        value: int.parse(rating),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
