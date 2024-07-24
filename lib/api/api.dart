import 'dart:async';

import 'package:ambulance_driver/api/response_structure.dart';
import 'package:ambulance_driver/main.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../utility/constants.dart';
import '../utility/directions_model.dart';

class Api {
  static final dio = Dio();
  static var endPoint = "https://ambulance-booking-backend.vercel.app/";

  // this is for the registering data
  static var personalHospitalDetails = "user/add-driver";
//   this is for the uploading img (proofs)
  static var uploadProofImg = "user/update-driver";
  static var sendOtp = "user/driver-send-otp";
  static var verifyOtp = "user/driver-otp-verify";
  static var driverState = "user/check-driver-status";
  static var rideHistory = "user/get-ride-history";
  static var updateProfilePic = "user/update-profile-image";
  static var updateLocation = "user/update-driver-location";
  static var acceptRequest = "user/driver-accept";
  static var rideOtpVerification = "user/ride-otp-verify";


// this is for getting the NearBy hospitals

  static Future<Map<String, dynamic>> getOtp(String number) async {
    var finalPath;
    finalPath = "$endPoint$sendOtp";
    Print.p(finalPath);
    Response res = await dio.post(
      finalPath,
      data: {"phoneNumber": number},
    );
    return ResponseStructure.toResponseStructure(res);
  }

  static Future<Map<String, dynamic>> ckeckOtp(
      String number, String otp) async {
    var finalPath;
    finalPath = "$endPoint$verifyOtp";
    Print.p(finalPath);
    Response res = await dio.post(
      finalPath,
      data: {"phoneNumber": number, "otp": otp},
    );
    return ResponseStructure.toResponseStructure(res);
  }

  static Future<Map<String, dynamic>> changeDriverState(
      String number, bool state) async {
    var finalPath;
    finalPath = "$endPoint$driverState?phoneNumber=$number&isActive=$state";
    Print.p(finalPath);
    Response res = await dio.get(finalPath);
    return ResponseStructure.toResponseStructure(res);
  }

  static Future<Map<String, dynamic>> getRideHistory(String number) async {
    var finalPath;
    finalPath = "$endPoint$rideHistory?driverPhoneNumber=$number";
    Print.p(finalPath);
    Response res = await dio.get(finalPath);
    return ResponseStructure.toResponseStructure(res);
  }

  static Future<Map<String, dynamic>> updatePic(
      String number, String path) async {
    var finalPath;
    finalPath = "$endPoint$updateProfilePic?phoneNumber=$number";
    var formData =
        FormData.fromMap({"image": await MultipartFile.fromFile(path)});
    Print.p(finalPath);
    Response res = await dio.post(finalPath, data: formData);
    return ResponseStructure.toResponseStructure(res);
  }

  static Future<Map<String, dynamic>> updateDriverLocation(
      String number, double lat, double lng) async {
    var finalPath;
    finalPath = "$endPoint$updateLocation";
    Print.p(finalPath);
    var data = {
      "phoneNumber": number.toString(),
      "latitude": lat,
      "longitude": lng
    };

    Response res = await dio.post(
      finalPath,
      data: data,
    );
    return ResponseStructure.toResponseStructure(res);
  }

  static Future<Map<String, dynamic>> registerDriverData({
    required String number,
    required String firstName,
    required String lastName,
    required String altNumber,
    required String hspName,
    required String hspAdd,
    required double lat,
    required double lng,
    String emailId = "xyz@gmail.com",
  }) async {
    var data = {
      "firstName": firstName,
      "lastName": lastName,
      "alternativeNumber": altNumber,
      "phoneNumber": number,
      "emailId": emailId,
      "hospitalName": hspName,
      "hospitalAddress": hspAdd,
      "latitude": lat,
      "longitude": lng
    };

    var finalPath = "$endPoint$personalHospitalDetails";
    var res = await dio.post(finalPath, data: data);
    return ResponseStructure.toResponseStructure(res);
  }

  static Future<Map<String, dynamic>> uploadImageData(
      {required String id,
      required String aadharCardFront,
      required String aadharCardBack,
      required String driverLicense,
      required String ambulancePhotoRear,
      required String ambulancePhotoBack}) async {
    var data = FormData.fromMap({
      "id": id,
      "aadharCardFront": await MultipartFile.fromFile(aadharCardFront,
          filename: "aadhar front"),
      "aadharCardBack":
          await MultipartFile.fromFile(aadharCardBack, filename: "aadhar back"),
      "driverLicense": await MultipartFile.fromFile(driverLicense,
          filename: "driver licences"),
      "ambulancePhotoRear": await MultipartFile.fromFile(ambulancePhotoRear,
          filename: "ambulance frnt"),
      "ambulancePhotoBack": await MultipartFile.fromFile(ambulancePhotoBack,
          filename: "ambulance back"),
    });

    var finalPath = "$endPoint$uploadProofImg";
    var res = await dio.post(finalPath, data: data);
    return ResponseStructure.toResponseStructure(res);
  }

//   ride verifyOtp
//   pading forthe implementation
  static Future<Map<String, dynamic>> rideOTPVarify(String reqId,String otp) async {
    var finalPath;
    finalPath = "$endPoint$rideOtpVerification";
    Print.p(finalPath);
    Response res = await dio.post(
      finalPath,
      data: {
        "requestId": reqId,
        "otp":otp

      },
    );
    return ResponseStructure.toResponseStructure(res);
  }
  static Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await dio.get(
      'https://maps.googleapis.com/maps/api/directions/json?',
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': "AIzaSyBpX6Opy9xgc98uyaMioJ8VbzJYHXnqE4Q",
      },
    );
    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    return null;
  }
}
