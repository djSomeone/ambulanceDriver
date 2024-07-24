import 'package:ambulance_driver/screens/payment/module/cash_card.dart';
import 'package:ambulance_driver/screens/payment/payment_summary.dart';
import 'package:ambulance_driver/screens/payment/success_payment.dart';
import 'package:ambulance_driver/screens/start_ride/controller/ride_controller.dart';
import 'package:ambulance_driver/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectCashScreen extends StatelessWidget {
  CollectCashScreen({super.key});
  var rideController = Get.find<RideController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: standeredAppBar(title: "Collect Cash"),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CashCard(
                          amount: rideController.requestData.value["fare"],
                          distance:
                              rideController.requestData.value["distance"],
                          title: "Ask Passenger to pay",
                        ),
                      ),
                      standaredpickupDropCard(
                        pickupLocation:
                            rideController.requestData.value["pickupAddress"],
                        dropLocation: rideController.requestData.value["dropAddress"]
                      )
                    ],
                  )),
              Expanded(flex: 1, child: Center()),
              // bottom buttoms
              SizedBox(
                height: 64,
                child: Row(
                  children: [
                    // {"pickupLocation":{"latitude":19.358692530109007,"longitude":72.80566716750128},"dropLocation":{"latitude":19.298503,"longitude":72.85162},"_id":"667934e9039f4440f821b053","requestId":"5ad10162-a6b3-45a2-903b-d4dab3dc2c5d","pickupAddress":"9R54+JC5, Karadi Wadi, Vasai West, Vasai-Virar, Sandor, Maharashtra 401201, India","dropAddress":"Mittal Court, Phatak Rd, Bhayandar, Geeta Nagar, Bhayandar West, Mira Bhayandar, Maharashtra 401101, India","patientName":"gaurav","patientPhoneNumber":"7905222386","rideStatus":"accepted","paymentStatus":"pending","timestamp":"2024-06-24T08:57:13.110Z","otp":6470,"distance":29.69,"fare":2969,"__v":0,"driverPhoneNumber":"8828456655","driverName":"Admeya gavande"}
                    // button for cash received
                    Expanded(
                        flex: 4,
                        child: standaredButton(
                            title: "Cash Received",
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => standaredAlertBox(
                                      title: "Cash Received?",
                                      subTitle:
                                          "Are you sure you want to continue?",
                                      firstButtonColor: ConstColor.DarkGrey,
                                      secoundButtonColor: ConstColor.primery,
                                      onTapFirstButton: () {
                                        Get.back();
                                      },
                                      onTapSecoundButton: () {
                                        var con = Get.find<RideController>();
                                        con.socket
                                            .completeRideEvent(con.requestData);
                                        Get.to(PaymentSummaryScreen(
                                          amount: rideController.requestData.value["fare"],
                                          date: rideController.requestData.value["Date"],
                                          time: rideController.requestData.value["Time"],
                                          patientName: rideController.requestData.value["patientName"],
                                          paymentMethod: "Cash",
                                          rideId: rideController.requestData.value["requestId"],
                                        ));
                                      },
                                      textFirstButton: "No",
                                      textSecoundButton: "Yes"));
                            })),
                    // this is for the qr code
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              Future.delayed(Duration(seconds: 2), () {
                                Get.to(SuccessPayment());
                              });
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 280,
                                      width: ScreenSize.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(
                                              "Scan & Pay",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.black,
                                                  decoration:
                                                      TextDecoration.none),
                                            ),
                                          ),
                                          Icon(
                                            Icons.qr_code_2,
                                            size: 190,
                                            color: ConstColor.DarkGrey,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Icon(
                                  Icons.qr_code_outlined,
                                  color: ConstColor.primery,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
