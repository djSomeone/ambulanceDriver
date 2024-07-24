import 'package:flutter/material.dart';

class LocationSelectorCard extends StatelessWidget {
  String title="";
  String value="";
  Color titleColor=Colors.redAccent;
  dynamic onTap=(){};
  LocationSelectorCard({required this.title, required this.value, required this.titleColor,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: Text(title,style: TextStyle(fontSize: 12,color: titleColor),)),
          Expanded(child: Text(value,style: TextStyle(fontSize: 14,color: Colors.black),maxLines: 1,overflow: TextOverflow.ellipsis,))

        ],
      ),
    );
  }
}
