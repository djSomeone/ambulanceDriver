import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controller/kyc_screen_controller.dart';

class TitledTextFeiled extends StatelessWidget {
  var title;
  var placeHolder;
  var keyBoardType;
  TextEditingController controller;
  var maxline;
  var maxlength;
  var keyword;
  TitledTextFeiled(
      {required this.title,
      required this.placeHolder,
      this.keyBoardType = TextInputType.text,
      required this.controller,
      this.maxline = 1,
      this.maxlength = 50,
      required this.keyword});

  var kycController = Get.find<KycScreenController>();
  var _debounce;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          TextFormField(
            onChanged: _handleTextChanged,
            controller: controller,
            maxLines: maxline,
            maxLength: maxlength,
            keyboardType: keyBoardType,
            decoration: InputDecoration(
                counterText: "",
                hintText: placeHolder,
                hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ],
      ),
    );
  }

  void _handleTextChanged(String x) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // Perform your delayed action here with the current text
      kycController.addDataInDriverData(keyword,x.toString());
    });
  }
}
