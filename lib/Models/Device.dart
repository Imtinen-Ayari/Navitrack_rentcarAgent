class Device {
  String id;
  String code;
  String longitude;
  String latitude;
  int speed;
  int engineRpm;
  int engineTemperature;
  int fuelLevel;
  int fuelType;
  int kilometrage;
  int batterieVoltage;
  int chargeMoteur;
  String timestamp;
  List<int> engineOnTime;
  int dtcNumber;
  List<dynamic> dtcFaults;
  int alert_sos;
  Device({
    required this.id,
    required this.code,
    required this.longitude,
    required this.latitude,
    required this.speed,
    required this.engineRpm,
    required this.engineTemperature,
    required this.fuelLevel,
    required this.fuelType,
    required this.kilometrage,
    required this.batterieVoltage,
    required this.chargeMoteur,
    required this.timestamp,
    required this.engineOnTime,
    required this.dtcNumber,
    required this.dtcFaults,
    required this.alert_sos,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'] ?? "",
      code: json['code'] ?? "",
      longitude: json['longitude'] ?? "",
      latitude: json['latitude'] ?? "",
      speed: json['speed'] ?? 0,
      engineRpm: json['engine_rpm'] ?? 0,
      engineTemperature: json['engine_temperature'] ?? 0,
      fuelLevel: json['fuel_level'] ?? 0,
      fuelType: json['fuel_type'] ?? "",
      kilometrage: json['kilometrage'] ?? 0,
      batterieVoltage: json['batterie_voltage'] ?? 0,
      chargeMoteur: json['charge_moteur'] ?? 0,
      timestamp: json['timestamp'] ?? "",
      engineOnTime: List<int>.from(json['engine_on_time'] ?? []),
      dtcNumber: json['dtc_number'] ?? 0,
      dtcFaults: json['dtc_faults'] ?? "",
      alert_sos: json['dtc_number'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'longitude': longitude,
      'latitude': latitude,
      'speed': speed,
      'engine_rpm': engineRpm,
      'engine_temperature': engineTemperature,
      'fuel_level': fuelLevel,
      'fuel_type': fuelType,
      'kilometrage': kilometrage,
      'batterie_voltage': batterieVoltage,
      'charge_moteur': chargeMoteur,
      'timestamp': timestamp,
      'engine_on_time': engineOnTime,
      'dtc_number': dtcNumber,
      'dtc_faults': dtcFaults,
      'alert_sos': alert_sos,
    };
  }
}

class LocalTime {
  // Define the properties and methods for LocalTime class
  LocalTime();

  factory LocalTime.fromJson(Map<String, dynamic> json) {
    // Initialize from JSON
    return LocalTime();
  }

  Map<String, dynamic> toJson() {
    // Convert to JSON
    return {};
  }
}
