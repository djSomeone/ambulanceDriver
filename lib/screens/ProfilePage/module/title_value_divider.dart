import 'package:ambulance_driver/utility/constants.dart';
import 'package:flutter/material.dart';

class TitleValueDivider extends StatelessWidget {
  var title;
  var value;
   TitleValueDivider({required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: ScreenSize.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(title,style: TextStyle(fontSize: 14),),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(value,style: TextStyle(fontSize: 14),),
        ),
        Divider()

      ],),
    );
  }
}
