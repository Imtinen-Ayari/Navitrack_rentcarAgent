import 'dart:async';
import 'dart:convert';
import 'package:eventsource/eventsource.dart';
import 'package:rent_car/.env.dart';
import 'package:rent_car/Models/Device.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import 'package:rxdart/rxdart.dart';

class DeviceService {
  final BehaviorSubject<List<Device>> devicesSubject =
      BehaviorSubject<List<Device>>();

  Stream<List<Device>> get devicesStream => devicesSubject.stream;

  Future<void> getAllDevicesData() async {
    String? token = await readToken();
    String? userId = await readClientID();
    if (token == null || userId == null) {
      throw Exception('Token or UserID is null');
    }
    String url =
        '${apiUrl}/api/cubeIT/NaviTrack/rest/device/webflux/stream/track-all-by-filter?id_client=$userId';

    final headers = {
      'Accept': 'text/event-stream',
      'Authorization': 'Bearer $token',
    };

    try {
      final eventSource = await EventSource.connect(url, headers: headers);

      List<Device> devices = [];

      eventSource.listen((Event event) {
        print(event.data);
        if (event.data != null) {
          final data = jsonDecode(event.data!);
          final device = Device.fromJson(data);
          devices.add(device);
          devicesSubject.add(devices);
        }
      });
    } catch (e) {
      throw Exception('Error fetching device data: $e');
    }
  }
}
