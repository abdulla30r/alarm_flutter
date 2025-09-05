// helper/location_helper.dart
// ignore_for_file: avoid_print

import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static Future<Map<String, double>?> getLatLng() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print("Location services are disabled.");
        return null;
      }

      // Check and request permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.always &&
            permission != LocationPermission.whileInUse) {
          print("Location permission denied.");
          return null;
        }
      }

      // Define location settings
      LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      return {"latitude": position.latitude, "longitude": position.longitude};
    } catch (e) {
      print("Error getting location: $e");
      return null;
    }
  }
}
