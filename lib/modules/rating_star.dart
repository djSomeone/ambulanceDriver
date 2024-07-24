import 'package:flutter/material.dart';

class StarDisplay extends StatelessWidget {
  final int value;
   double size;
   Color color;
   StarDisplay({this.value = 0,this.size=18,this.color=Colors.yellow});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
           Icons.star,
        color: index < value?color:Colors.blueGrey,size: size,);
      }),
    );
  }
}