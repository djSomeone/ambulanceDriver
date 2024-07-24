import 'package:ambulance_driver/screens/Home/home_page.dart';
import 'package:ambulance_driver/screens/my_ride/controller/ride_history_controller.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../main.dart';
import '../screens/Home/controller/home_page_controller.dart';
import '../screens/start_ride/controller/ride_controller.dart';
import '../utility/constants.dart';

class SocketHandler {
  Socket socket =
      io("https://livetracking-backend.onrender.com", <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": true
  });

  SocketHandler() {
    Print.p("SocketHandler()");
    connectAndListen();
  }

  bool listenEvent() {
    if (socket.connected) {
      socket.on('newRequest', (data) {
        Get.find<RideController>().setRequestData(newData: data);
        Print.p(data.toString());
        Get.find<HomePageController>().isThereNotification(true);
      });

      socket.onDisconnect((_) {
        Print.p('disconnect');
        // Print.p("try to reconnect");
        // socket.connect();
      });
      socket.on("rideCancelled", (data) {
        toast(msg: "Ride cancelled by the Patient");
        Get.find<HomePageController>().reinitializeController();
        Get.find<RideController>().reinitializeController();
        Get.find<RideHistoryController>().reinitializeController();
        Get.back();

        Print.p(data.toString());
      });

      return true;
    } else {
      return false;
    }
  }

  bool registerDriverEvent() {
    if (socket.connected) {
      var driverNumber = int.parse(sharedInstance.getString("number"));
      socket.emit("registerDriver", driverNumber);
      return true;
    } else {
      return false;
    }
  }

  bool acceptRequestEvent(Map<String, dynamic> reqData) {
    reqData["driverPhoneNumber"] = sharedInstance.getString("number");
    if (socket.connected) {
      socket.emit("requestAccepted", reqData);
      return true;
    } else {
      return false;
    }
  }

  bool denyRequestEvent(Map<String, dynamic> reqData) {
    reqData["driverPhoneNumber"] = sharedInstance.getString("number");
    if (socket.connected) {
      socket.emit("requestDenied", reqData);
      toast(msg: "Deny successfully");
      return true;
    } else {
      return false;
    }
  }

  bool completeRideEvent(Map<String, dynamic> reqData) {

    if (socket.connected) {
      socket.emit("completeRide", reqData);
      return true;
    } else {
      return false;
    }
  }

  bool otpVerifiedEvent(Map<String, dynamic> reqData) {

    if (socket.connected) {
      socket.emit("otpVerified", reqData);
      return true;
    } else {
      return false;
    }
  }

  bool dropOffEvent(Map<String, dynamic> reqData) {


    if (socket.connected) {
      socket.emit("dropOff", reqData);
      Print.p("event emitting");
      return true;
    } else {
      return false;
    }
  }

  void connectAndListen() {
    Print.p("connectAndListen() ");
    socket.connect();

    socket.onConnect((_) {
      Print.p("Connected to the sever");
      registerDriverEvent();
      listenEvent();
    });
  }

  void socketDisconnect() {
    socket.disconnect();
  }
}
