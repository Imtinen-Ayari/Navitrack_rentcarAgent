import 'package:rent_car/Models/FileDetail.dart';

class Report {
  String id;
  String title;
  String idUser;
  String reporter;
  String description;
  DateTime date;
  List<FileDetail> files;

  Report({
    required this.id,
    required this.title,
    required this.idUser,
    required this.reporter,
    required this.description,
    required this.date,
    required this.files,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      title: json['title'] ,
      idUser: json['id_user'],
      reporter: json['reporter'],
      description: json['description'],
      date: DateTime.fromMillisecondsSinceEpoch(json['date']),
      files: List<FileDetail>.from(json['files'].map((x) => FileDetail.fromJson(x))),
    );
  }
}
