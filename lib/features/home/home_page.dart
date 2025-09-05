import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class HomePage extends StatefulWidget {
  final Map<String, double>? location;

  const HomePage({super.key, this.location});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? address;

  @override
  void initState() {
    super.initState();
    _getAddress();
  }

  Future<void> _getAddress() async {
    final lat = widget.location?['latitude'];
    final long = widget.location?['longitude'];

    if (lat != null && long != null) {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);

        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          setState(() {
            address = "${place.street}, ${place.locality}, ${place.country}";
          });
        }
      } catch (e) {
        setState(() {
          address = "Unable to get address";
        });
      }
    } else {
      setState(() {
        address = "Location not available";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final latitude = widget.location?['latitude']?.toStringAsFixed(6) ?? 'N/A';
    final longitude =
        widget.location?['longitude']?.toStringAsFixed(6) ?? 'N/A';

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 96),
            const Text(
              "Selected Location",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Lat: $latitude, Long: $longitude",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              address ?? "Loading address...",
              style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
