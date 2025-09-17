import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rent_car/Models/Conducteur.dart';
import 'package:rent_car/Models/Contact.dart';
import 'package:rent_car/Models/Vehicule.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import "../.env.dart";

Future<List<Contrat>> getContartsByClient_Id(String id, String token) async {
  try {
    print("📡 [GET] Contrats pour client ID: $id");

    final response = await http.get(
      Uri.parse(
          '$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/getall-by-user/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print("🔎 Réponse Contrats (${response.statusCode}): ${response.body}");

    if (response.statusCode == 200) {
      List<dynamic> responseBody = jsonDecode(response.body);
      List<Contrat> contracts =
          responseBody.map((item) => Contrat.fromJson(item)).toList();
      print("✅ Nombre de contrats récupérés: ${contracts.length}");
      return contracts;
    } else if (response.statusCode == 401) {
      logout();
      throw Exception('Unauthorized: ${response.statusCode}');
    } else {
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }
  } catch (e) {
    print("❌ Erreur getContartsByClient_Id: $e");
    throw Exception('Failed to fetch data: $e');
  }
}

Future<String> createContrat({
  required String vehicleId,
  required String conducteur1Id,
  String? conducteur2Id,
  required DateTime dateDepart,
  required DateTime dateRetour,
  required String modePayement,
  required double timbreF,
  required double totalHT,
  double kilometrageDepartAuto = 0,
  double tva = 0,
}) async {
  final token = await readToken();

  final queryParams = {
    'vehicleId': vehicleId,
    'conducteur1Id': conducteur1Id,
    if (conducteur2Id != null && conducteur2Id.isNotEmpty)
      'conducteur2Id': conducteur2Id,
  };

  final url = Uri.parse(
    '$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/create-contrat-location',
  ).replace(queryParameters: queryParams);

  final bodyMap = {
    "dateDepart": dateDepart.toIso8601String(),
    "dateRetour": dateRetour.toIso8601String(),
    "kilometrageDepartAuto": kilometrageDepartAuto,
    "modePayement": modePayement,
    "tva": tva,
    "timbreF": timbreF,
    "totalHT": totalHT,
  };

  print("📡 [POST] Création contrat");
  print("➡️ URL: $url");
  print("➡️ Headers: Authorization=Bearer $token");
  print("➡️ Body: $bodyMap");

  try {
    final response = await http.post(
      url,
      body: jsonEncode(bodyMap),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print("🔎 Réponse Contrat (${response.statusCode}): ${response.body}");

    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);
      final contratId = responseData['id'].toString();
      print("✅ Contrat créé avec ID: $contratId");
      return contratId;
    } else if (response.statusCode == 401) {
      logout();
      throw Exception('Unauthorized: ${response.statusCode}');
    } else {
      throw Exception('Erreur création contrat: ${response.body}');
    }
  } catch (error) {
    print("❌ Erreur createContrat: $error");
    throw error;
  }
}

//Récupérer les conducteurs d’un utilisateur
Future<List<Conducteur>> getConducteursByUser(
    String userId, String token) async {
  try {
    print("📡 [GET] Conducteurs pour user ID: $userId");

    final response = await http.get(
      Uri.parse(
          '$apiUrl/api/cubeIT/NaviTrack/rest/conducteur/get-list-Conducteur-filtred/$userId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    print("🔎 Réponse Conducteurs (${response.statusCode}): ${response.body}");

    if (response.statusCode == 200) {
      List<dynamic> responseBody = jsonDecode(response.body);
      List<Conducteur> conducteurs =
          responseBody.map((item) => Conducteur.fromJson(item)).toList();
      print("✅ Nombre de conducteurs récupérés: ${conducteurs.length}");
      return conducteurs;
    } else if (response.statusCode == 401) {
      logout();
      throw Exception('Unauthorized: ${response.statusCode}');
    } else {
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }
  } catch (e) {
    print("❌ Erreur getConducteursByUser: $e");
    throw Exception('Failed to fetch data: $e');
  }
}

// Récupérer les véhicules d’un utilisateur
Future<List<Vehicle>> getVehiclesByUser(String userId, String token) async {
  try {
    print("📡 [GET] Véhicules pour user ID: $userId");

    final response = await http.get(
      Uri.parse(
          '$apiUrl/api/cubeIT/NaviTrack/rest/vehicles/get-list-byUser/$userId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    print("🔎 Réponse Véhicules (${response.statusCode}): ${response.body}");

    if (response.statusCode == 200) {
      List<dynamic> responseBody = jsonDecode(response.body);
      List<Vehicle> vehicles =
          responseBody.map((item) => Vehicle.fromJson(item)).toList();
      print("✅ Nombre de véhicules récupérés: ${vehicles.length}");
      return vehicles;
    } else if (response.statusCode == 401) {
      logout();
      throw Exception('Unauthorized: ${response.statusCode}');
    } else {
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }
  } catch (e) {
    print("❌ Erreur getVehiclesByUser: $e");
    throw Exception('Failed to fetch data: $e');
  }
}

Future<List<Vehicle>> getavailableVehiclesByUser(String userId, String token,
    {String? cacheBuster}) async {
  // 👇 Ajout d’un paramètre anti-cache
  String url =
      'http://197.14.56.128:8080/api/cubeIT/NaviTrack/rest/contrat-location/available-vehicles-by-user'
      '?id_user=$userId&t=${DateTime.now().millisecondsSinceEpoch}';

  print("🌍 Requête vers: $url");
  print("🔑 Token utilisé (début): ${token.substring(0, 20)}...");

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Cache-Control': 'no-cache, no-store, must-revalidate',
        'Pragma': 'no-cache',
        'Expires': '0',
      },
    );

    print("📥 Status: ${response.statusCode}");

    // Gestion spéciale des erreurs 401
    if (response.statusCode == 401) {
      print("🔐 401 Unauthorized - Token peut être expiré ou mal lu");
      // Forcez le rafraîchissement du token si tu as une fonction prévue
      String? newToken = await refreshToken();
      if (newToken != null) {
        print("🔄 Nouveau token obtenu, relance de la requête...");
        return await getavailableVehiclesByUser(userId, newToken);
      }
      throw Exception('Authentication failed - token invalide');
    }

    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
        print("⚠️ Réponse vide de l’API");
        return [];
      }

      List<dynamic> data = json.decode(response.body);
      print("✅ Véhicules récupérés: ${data.length}");
      for (var v in data) {
        print("   - ${v['matricule']} (id=${v['id']})");
      }

      return data.map((json) => Vehicle.fromJson(json)).toList();
    } else {
      print("❌ Erreur HTTP ${response.statusCode}, body=${response.body}");
      throw Exception('HTTP ${response.statusCode}');
    }
  } catch (e) {
    print("💥 Network error: $e");
    rethrow;
  }
}

Future<String?> refreshToken() async {
  try {
    // Implémentez la logique de refresh token ici
    print("🔄 Refreshing authentication token...");
    // Votre logique de refresh
    return await readToken(); // Pour l'instant, retournez le même
  } catch (e) {
    print("❌ Token refresh failed: $e");
    return null;
  }
}

/// ⏰ Convertir DateTime en format ISO8601 sans secondes
String toIso8601WithoutSeconds(DateTime dateTime) {
  String twoDigits(int n) => n >= 10 ? "$n" : "0$n";
  String year = dateTime.year.toString();
  String month = twoDigits(dateTime.month);
  String day = twoDigits(dateTime.day);
  String hour = twoDigits(dateTime.hour);
  String minute = twoDigits(dateTime.minute);

  return "$year-$month-${day}T$hour:$minute";
}
