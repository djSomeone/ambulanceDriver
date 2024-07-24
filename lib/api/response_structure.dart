import 'package:dio/dio.dart';
import 'dart:convert';

class ResponseStructure{
  static Map<String,dynamic> toResponseStructure(Response r)
  {
    return jsonDecode(r.toString());
  }
}