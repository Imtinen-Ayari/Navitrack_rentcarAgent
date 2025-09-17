import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rent_car/Models/FileDetail.dart';
import 'package:rent_car/Models/Report.dart';
import 'package:rent_car/services/Reports_service.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rent_car/theme/app_theme.dart';

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

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [const Color(0xFF1F1F1F), const Color(0xFF2D2D2D)]
                : [const Color(0xFF0060FC), const Color(0xFF4D9EF6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      toolbarHeight: 100,
      title: Text(
        'Prise de voiture',
        style: GoogleFonts.plusJakartaSans(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildAppBar(context),
      body: FutureBuilder<List<File>>(
        future: downloadedFiles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: isDark ? const Color(0xFF8B5CF6) : Colors.blue,
              ),
            );
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isDark ? Border.all(color: Colors.grey.withOpacity(0.2)) : null,
        boxShadow: isDark
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.report.title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.report.description,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              color: isDark ? const Color(0xFFD1D5DB) : Colors.black54,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF8B5CF6).withOpacity(0.2)
                      : Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: isDark ? const Color(0xFF8B5CF6) : Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                DateFormat('dd/MM/yyyy HH:mm').format(widget.report.date),
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: isDark ? const Color(0xFF8B5CF6) : Colors.blue[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFileCard(File file, int index) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Hero(
      tag: "file_${widget.report.id}_$index",
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border:
              isDark ? Border.all(color: Colors.grey.withOpacity(0.3)) : null,
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.4)
                  : Colors.grey.withOpacity(0.2),
              blurRadius: isDark ? 15 : 8,
              offset: Offset(0, isDark ? 6 : 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
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
              height: 250,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 250,
                  color: isDark ? const Color(0xFF374151) : Colors.grey[200],
                  child: Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 64,
                      color:
                          isDark ? const Color(0xFF6B7280) : Colors.grey[400],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorSection(BuildContext context, String message) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Erreur de chargement',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: isDark ? const Color(0xFF9CA3AF) : Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final File file;
  final String tag;

  const FullScreenImage({super.key, required this.file, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Center(
        child: Hero(
          tag: tag,
          child: InteractiveViewer(
            child: Image.file(
              file,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(
                    Icons.broken_image,
                    size: 64,
                    color: Color(0xFF6B7280),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
