import 'dart:convert';
import 'package:eventsource/eventsource.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rent_car/Models/Device.dart';
import 'package:rent_car/Models/Vehicule.dart';
import 'package:rent_car/services/Contract_service.dart';
import 'package:rxdart/rxdart.dart';

import '../services/Secure_Storage.dart';
import '../.env.dart';

class BusMapWidget extends StatefulWidget {
  @override
  State<BusMapWidget> createState() => _BusMapWidgetState();
}

class _BusMapWidgetState extends State<BusMapWidget> {
  late GoogleMapController mapController;
  Set<Marker> _markers = {};
  List<Vehicle>? vehicles;

  @override
  void initState() {
    super.initState();
    loadVehicles();
    getAllDevicesData();
  }

  @override
  void dispose() {
    super.dispose();
    _markers.clear(); // Clear markers on dispose
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: const CameraPosition(
        target: LatLng(34.87523729228717, 9.395292213386597),
        zoom: 7.0,
      ),
      markers: _markers,
    );
  }

  void _addMarker(
    LatLng position,
    String id,
    String desc,
    String assetName,
  ) async {
    var customIcon = await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(50, 50)),
      assetName,
    );
    Marker marker = Marker(
      markerId: MarkerId(id),
      icon: customIcon,
      position: position,
      infoWindow: InfoWindow(title: desc),
    );

    setState(() {
      _markers.removeWhere((marker) => marker.markerId.value == id);
      _markers.add(marker);
    });
  }

  Future<void> getAllDevicesData() async {
    String? token = await readToken();
    String? userId = await readClientID();
    if (token == null || userId == null) {
      throw Exception('Token or UserID is null');
    }
    String url =
        'http://197.14.56.128:8080/api/cubeIT/NaviTrack/rest/device/webflux/stream/track-all-by-filter?id_client=$userId';

    final headers = {
      'Accept': 'text/event-stream',
      'Authorization': 'Bearer $token',
    };

    try {
      final eventSource = await EventSource.connect(url, headers: headers);
      eventSource.listen((Event event) async {
        print("event : ");
        print(event.data);
        if (event.data != null) {
          dynamic jsonData = jsonDecode(event.data!);
          if (jsonData is List) {
            List<dynamic> devices = jsonData;
            devices.forEach((device) async {
              Device deviceObj = Device.fromJson(device);
              Vehicle vehicle = await getVehicleByCode(deviceObj.code);
              _addMarker(
                LatLng(
                  double.parse(deviceObj.latitude),
                  double.parse(deviceObj.longitude),
                ),
                deviceObj.code,
                "matricule: ${vehicle.matricule} Vitesse: ${deviceObj.speed} Km/h",
                "assets/car.png",
              );
            });
          } else {
            Device device = Device.fromJson(jsonData);
            Vehicle vehicle = await getVehicleByCode(device.code);
            _addMarker(
              LatLng(
                double.parse(device.latitude),
                double.parse(device.longitude),
              ),
              device.code,
              "matricule: ${vehicle.matricule} Vitesse: ${device.speed} Km/h",
              "assets/car.png",
            );
          }
        }
      });
    } catch (e) {
      throw Exception('Error fetching device data: $e');
    }
  }

  Future<void> loadVehicles() async {
    try {
      String? userID = await readClientID();
      String? token = await readToken();
      vehicles = await getVehiclesByUser(userID!, token!);
    } catch (e) {
      print("Error loading vehicles: $e");
    }
  }

  Future<Vehicle> getVehicleByCode(String code) async {
    if (vehicles == null) {
      throw Exception('Vehicles not loaded yet');
    }
    return vehicles!.firstWhere((element) => element.code == code);
  }
}
