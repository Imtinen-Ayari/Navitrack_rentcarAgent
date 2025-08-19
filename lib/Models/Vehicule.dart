class Vehicle {
  String id_user;
  String code;
  String matricule;
  String marque;
  String model;
  String type;
  String id;

  Vehicle({
    required this.id_user,
    required this.code,
    required this.matricule,
    required this.marque,
    required this.model,
    required this.type,
    required this.id,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id_user: json['id_user'] as String? ?? 'defaultIdUser',
      code: json['code'] as String? ?? 'defaultCode',
      matricule: json['matricule'] as String? ?? 'defaultMatricule',
      marque: json['marque'] as String? ?? 'defaultMarque',
      model: json['model'] as String? ?? 'defaultModel',
      type: json['type'] as String? ?? 'defaultType',
      id: json['id'] as String? ?? 'defaultId',
    );
  }
}