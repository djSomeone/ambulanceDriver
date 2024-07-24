import 'package:ambulance_driver/utility/constants.dart';
import 'package:flutter/material.dart';

class CashCard extends StatelessWidget {
  var amount;
  var distance;
  var title;

   CashCard({required this.distance,required this.amount,required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(height: 270,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xFFF5F5F5)),
      child: Column(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              Center(child: Text(textAlign: TextAlign.center,title),),
              Center(child: Text(textAlign: TextAlign.center,"\u20B9$amount",style: TextStyle(color: ConstColor.primery,fontSize: 64),),),
            ],
          ),
        ),
         Divider(),
        Expanded(child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(children: [
            Expanded(child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Distance",style: TextStyle(color: Color(0xFF777B81),fontSize: 16),),
              Text("${distance}km",style: TextStyle(fontSize: 20),),
            ],)),
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Fare",style: TextStyle(color: Color(0xFF777B81),fontSize: 16),),
                Text("\u20B9${amount}",style: TextStyle(fontSize: 20),),
              ],)),
          ],),
        )),
      ],
    ),);
  }
}
