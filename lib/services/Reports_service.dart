import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rent_car/.env.dart';
import 'package:rent_car/Models/Report.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rent_car/services/Secure_Storage.dart';

class ReportService {
  static int ind = 1;
  Future<List<Report>> fetchReportsByUserId(String userId, String token) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$apiUrl/api/cubeIT/NaviTrack/rest/reports/get-list-filtered/$userId',
        ),
        headers: {
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> responseBody = jsonDecode(response.body);
        List<Report> reports =
            responseBody.map((item) => Report.fromJson(item)).toList();
        return reports;
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}

Future<File> downloadReportFile(String reportId, String token) async {
  try {
    final response = await http.get(
      Uri.parse(
        'http://197.14.56.128:8080/api/cubeIT/NaviTrack/rest/reports/download-report-file/?fileDownloadUriReport=$reportId',
      ),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final directory = await getApplicationDocumentsDirectory();

      final filePath = '${directory.path}/reportId${ReportService.ind}.jpg';
      ReportService.ind++;
      final file = File(filePath);

      await file.writeAsBytes(response.bodyBytes);
      return file;
    } else if (response.statusCode == 401) {
      logout();

      throw Exception('Unauthorized: ${response.statusCode}');
    } else {
      throw Exception('Failed to download report file: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to download report file: $e');
  }
}
