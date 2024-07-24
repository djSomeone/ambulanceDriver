import 'package:ambulance_driver/utility/constants.dart';
import 'package:flutter/material.dart';

class TitleSubtitle extends StatelessWidget {
  var title;
  var subtitle;
   TitleSubtitle({required this.title,required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenSize.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text(title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,),),
        Expanded(child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(subtitle,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,),),
        ))
      ],),
    );
  }
}
