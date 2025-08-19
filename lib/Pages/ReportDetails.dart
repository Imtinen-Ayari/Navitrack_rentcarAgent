import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rent_car/Models/FileDetail.dart';
import 'package:rent_car/Models/Report.dart';
import 'package:rent_car/services/Reports_service.dart';
import 'package:rent_car/services/Secure_Storage.dart';

class ReportDetailsPage extends StatefulWidget {
  final Report report;

  const ReportDetailsPage({super.key, required this.report});

  @override
  _ReportDetailsPageState createState() => _ReportDetailsPageState();
}

class _ReportDetailsPageState extends State<ReportDetailsPage> {
  Future<List<File>>? downloadedFiles;
  String? token;

  @override
  void initState() {
    super.initState();
    loadFiles(widget.report.files);
  }

  Future<void> loadFiles(List<FileDetail> filesUrl) async {
    try {
      token = await readToken();
      setState(() {
        downloadedFiles = Future.wait(filesUrl.map(
          (fileUrl) => downloadReportFile(fileUrl.fileDownloadUri, token!),
        ));
      });
    } catch (e) {
      print('Error in loadFiles: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0060FC), Color(0xFF4D9EF6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
        ),
        toolbarHeight: 100,
        title: const Text(
          'Prise de voiture',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<File>>(
        future: downloadedFiles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return _buildErrorSection(context, "Error loading files");
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _buildErrorSection(context, "No files available");
          }

          List<File> files = snapshot.data!;
          return ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            children: [
              _buildReportInfoCard(context),
              const SizedBox(height: 16),
              ...files.asMap().entries.map((entry) {
                final index = entry.key;
                final file = entry.value;
                return _buildFileCard(file, index);
              }).toList(),
            ],
          );
        },
      ),
    );
  }

  /// Card contenant les infos du rapport
  Widget _buildReportInfoCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.report.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.report.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18, color: Colors.blue),
                const SizedBox(width: 6),
                Text(
                  widget.report.date.toString().substring(0, 16),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Card pour afficher chaque fichier (image)
  Widget _buildFileCard(File file, int index) {
    return Hero(
      tag: "file_${widget.report.id}_$index",
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FullScreenImage(
                  file: file,
                  tag: "file_${widget.report.id}_$index",
                ),
              ),
            );
          },
          child: Image.file(
            file,
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ),
        ),
      ),
    );
  }

  /// Section affichée si erreur ou aucun fichier
  Widget _buildErrorSection(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 60, color: Colors.red),
          const SizedBox(height: 12),
          Text(
            message,
            style: const TextStyle(fontSize: 18, color: Colors.red),
          ),
        ],
      ),
    );
  }
}

/// Page plein écran pour afficher une image avec Hero animation
class FullScreenImage extends StatelessWidget {
  final File file;
  final String tag;

  const FullScreenImage({super.key, required this.file, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: tag,
            child: Image.file(file, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
