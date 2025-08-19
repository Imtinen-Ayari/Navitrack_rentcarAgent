import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rent_car/Models/Conducteur.dart';
import 'package:rent_car/Models/Contact.dart';
import 'package:rent_car/Models/Vehicule.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import "../.env.dart";

Future<List<Contrat>> getContartsByClient_Id(String id, String token) async {
  try {
    final response = await http.get(
      Uri.parse(
          '$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/getall-by-user/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> responseBody = jsonDecode(response.body);
      List<Contrat> contracts =
          responseBody.map((item) => Contrat.fromJson(item)).toList();
      return contracts;
    } else if (response.statusCode == 401) {
      logout();
      throw Exception('Unauthorized: ${response.statusCode}');
    } else {
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to fetch data: $e');
  }
}

Future<String> createContrat(
    String idv,
    String conducteur1Id,
    String conducteur2Id,
    DateTime dateDepart,
    DateTime dateRetour,
    String modePayement,
    double timbreF,
    double totalHT) async {
  final url;
  if (conducteur2Id == "" || conducteur2Id.isEmpty) {
    url = Uri.parse(
        '$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/create-contrat-location?conducteur1Id=$conducteur1Id&idv=$idv');
  } else {
    url = Uri.parse(
        '$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/create-contrat-location?conducteur1Id=$conducteur1Id&conducteur2Id=$conducteur2Id&idv=$idv');
  }
  final token = await readToken();
  final body;
  Map<String, String> params;
  if (conducteur2Id != 0) {
    body = jsonEncode({
      'dateDepart': toIso8601WithoutSeconds(dateDepart),
      'dateRetour': toIso8601WithoutSeconds(dateRetour),
      'modePayement': modePayement,
      'timbreF': timbreF,
      'totalHT': totalHT,
    });
  } else {
    body = jsonEncode({
      'dateDepart': toIso8601WithoutSeconds(dateDepart),
      'dateRetour': toIso8601WithoutSeconds(dateRetour),
      'modePayement': modePayement,
      'timbreF': timbreF,
      'totalHT': totalHT,
    });
  }

  try {
    final response = await http.post(url, body: body, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);
      print('Server Response: $responseData');
      //pour ajouter les images
      String contratId =
          responseData['id'].toString(); // adapte 'id' selon ta réponse API
      return contratId;
    } else if (response.statusCode == 401) {
      logout();
      throw Exception('Unauthorized: ${response.statusCode}');
    } else {
      return response.body;
    }
  } catch (error) {
    print('Error posting contrat: $error');
    throw error;
  }
}

Future<List<Conducteur>> getConducteursByUser(
    String userId, String token) async {
  try {
    final response = await http.get(
      Uri.parse(
          '$apiUrl/api/cubeIT/NaviTrack/rest/conducteur/get-list-Conducteur-filtred/$userId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> responseBody = jsonDecode(response.body);
      List<Conducteur> conducteurs =
          responseBody.map((item) => Conducteur.fromJson(item)).toList();
      return conducteurs;
    } else if (response.statusCode == 401) {
      logout();
      throw Exception('Unauthorized: ${response.statusCode}');
    } else {
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to fetch data: $e');
  }
}

Future<List<Vehicle>> getVehiclesByUser(String userId, String token) async {
  try {
    print("userID" + userId);
    final response = await http.get(
      Uri.parse(
          '$apiUrl/api/cubeIT/NaviTrack/rest/vehicles/get-list-byUser/$userId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> responseBody = jsonDecode(response.body);
      List<Vehicle> vehicles =
          responseBody.map((item) => Vehicle.fromJson(item)).toList();
      return vehicles;
    } else if (response.statusCode == 401) {
      logout();
      throw Exception('Unauthorized: ${response.statusCode}');
    } else {
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to fetch data: $e');
  }
}

Future<List<Vehicle>> getavailableVehiclesByUser(
    String userId, String token) async {
  try {
    print("userID: $userId");
    final url =
        '$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/available-vehicles-by-user?id_user=$userId';
    print('Requesting URL: $url');

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> responseBody = jsonDecode(response.body);
      List<Vehicle> vehicles =
          responseBody.map((item) => Vehicle.fromJson(item)).toList();
      return vehicles;
    } else if (response.statusCode == 404) {
      // Aucun véhicule disponible → retourne une liste vide
      print('Aucun véhicule disponible pour cet utilisateur.');
      return [];
    } else if (response.statusCode == 401) {
      logout();
      throw Exception('Unauthorized: ${response.statusCode}');
    } else {
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }
  } catch (e) {
    print('Erreur lors du chargement des véhicules disponibles: $e');
    throw Exception('Failed to fetch data: $e');
  }
}

String toIso8601WithoutSeconds(DateTime dateTime) {
  String twoDigits(int n) => n >= 10 ? "$n" : "0$n";
  String year = dateTime.year.toString();
  String month = twoDigits(dateTime.month);
  String day = twoDigits(dateTime.day);
  String hour = twoDigits(dateTime.hour);
  String minute = twoDigits(dateTime.minute);

  return "$year-$month-${day}T$hour:$minute";
}
