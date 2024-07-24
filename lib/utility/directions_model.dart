import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directions {
  final LatLngBounds bounds;
  final List<PointLatLng> polylinePoints;
  final double totalDistance;
  final String totalDuration;
  final int fare;

  const Directions({
    required this.bounds,
    required this.polylinePoints,
    required this.totalDistance,
    required this.totalDuration,
    required this.fare
  });

  factory Directions.fromMap(Map<String, dynamic> map) {
    // Check if route is not available
  

    // Get route information
    final data = Map<String, dynamic>.from(map['routes'][0]);

    // Bounds
    final northeast = data['bounds']['northeast'];
    final southwest = data['bounds']['southwest'];
    final bounds = LatLngBounds(
      northeast: LatLng(northeast['lat'], northeast['lng']),
      southwest: LatLng(southwest['lat'], southwest['lng']),
    );

    // Distance & Duration
    double distance = 0.0;
    String duration = '';
    int fare=0;
    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      distance = double.parse(leg['distance']['text'].toString().split(" ")[0]);
      duration = leg['duration']['text'];
       fare=(distance*100).toInt();
    }

    return Directions(
      bounds: bounds,
      polylinePoints:
      PolylinePoints().decodePolyline(data['overview_polyline']['points']),
      totalDistance: distance,
      totalDuration: duration,
      fare: fare
    );
  }
}


