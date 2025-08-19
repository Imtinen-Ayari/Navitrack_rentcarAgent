import 'package:rent_car/Models/Conducteur.dart';
import 'package:rent_car/Models/Device.dart';
import 'package:rent_car/Models/Vehicule.dart';


class Contrat {
  String id;
  int numeroContract;
  Conducteur? conducteur;
  Conducteur? conducteur2;
  Device? device;
  Vehicle? vehicule;
  DateTime dateDepart;
  DateTime dateRetour;
  int kilometrageDepartAuto;
  int nbJours;
  String modePayement;
  double totalTTc;
  double tva;
  double timbreF;
  double totalHT;
  bool prolonged;

  Contrat({
    required this.id,
    required this.numeroContract,
    this.conducteur,
    this.conducteur2,
    required this.vehicule,
    required this.device,

    required this.dateDepart,
    required this.dateRetour,
    required this.kilometrageDepartAuto,
    required this.nbJours,
    required this.modePayement,
    required this.totalTTc,
    required this.tva,
    required this.timbreF,
    required this.totalHT,
    required this.prolonged,
  });

 factory Contrat.fromJson(Map<String, dynamic> json) {
  DateTime dateDepartStr = json['dateDepart'] is List ? DateTime(
    json['dateDepart'] [0],  // year
    json['dateDepart'] [1],  // month (1-based)
    json['dateDepart'] [2],  // day
    json['dateDepart'] [3],  // hour
    json['dateDepart'] [4],  // minute
  ) : DateTime.now();
  DateTime dateRetourStr = json['dateRetour'] is List ? DateTime(
    json['dateRetour'][0],  // year
    json['dateRetour'][1],  // month (1-based)
    json['dateRetour'][2],  // day
    json['dateRetour'][3],  // hour
    json['dateRetour'][4],  // minute
  ) : DateTime.now();

  return Contrat(
    id: json['id'] as String? ?? 'defaultId',
    numeroContract: json['numeroContrat'] as int? ?? 0,
    conducteur: json['conducteur'] != null ? Conducteur.fromJson(json['conducteur']) : null,
    conducteur2: json['conducteur2'] != null ? Conducteur.fromJson(json['conducteur2']) : null,
    device: json['device'] != null ? Device.fromJson(json['device']) : null,
    vehicule: json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null,
    dateDepart: dateDepartStr,
    dateRetour: dateRetourStr,
    kilometrageDepartAuto: json['kilometrageDepartAuto'] as int? ?? 0,
    nbJours: json['nbJours'] as int? ?? 0,
    modePayement: json['modePayement'] as String? ?? 'defaultModePayement',
    totalTTc: json['totalTTc'] as double? ?? 0.0,
    tva: json['tva'] as double? ?? 0.0,
    timbreF: json['timbreF'] as double? ?? 0.0,
    totalHT: json['totalHT'] as double? ?? 0.0,
    prolonged: json['prolonged'] as bool? ?? false,
  );
}
Map<String, dynamic> toJson() {
  return {
    'dateDepart': dateDepart,
    'dateRetour': dateRetour,
    'modePayement': modePayement,
    'timbreF': timbreF,
    'totalHT': totalHT,
  };
}
}