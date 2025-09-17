import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent_car/theme/app_theme.dart';

class PdfListPage extends StatefulWidget {
  const PdfListPage({Key? key}) : super(key: key);

  @override
  _PdfListPageState createState() => _PdfListPageState();
}

class _PdfListPageState extends State<PdfListPage> {
  List<FileSystemEntity> pdfFiles = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadPdfFiles();
  }

  Future<void> _loadPdfFiles() async {
    setState(() {
      isLoading = true;
    });

    try {
      final directory = await getApplicationDocumentsDirectory();
      final allFiles = directory.listSync();

      // Filtrer uniquement les fichiers PDF
      final pdfs = allFiles.where((file) {
        return file.path.endsWith(".pdf");
      }).toList();

      // Trier par date de modification
      pdfs.sort((a, b) {
        final statA = FileStat.statSync(a.path);
        final statB = FileStat.statSync(b.path);
        return statB.modified.compareTo(statA.modified);
      });

      setState(() {
        pdfFiles = pdfs;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error loading PDFs: $e");
    }
  }

  Future<void> _openPdf(String path) async {
    if (File(path).existsSync()) {
      await OpenFile.open(path);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "PDF introuvable !",
              style: GoogleFonts.plusJakartaSans(),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppTheme.buildRoundedAppBar(context, 'Documents PDF'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : pdfFiles.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.picture_as_pdf,
                        size: 64,
                        color: isDark ? Colors.grey[600] : Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Aucun PDF trouvé',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Vos documents PDF apparaîtront ici',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          color: isDark ? Colors.white54 : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: pdfFiles.length,
                  itemBuilder: (context, index) {
                    final file = pdfFiles[index];
                    final fileName = file.path.split('/').last;
                    final fileStat = FileStat.statSync(file.path);

                    return Hero(
                      tag: "pdf_$fileName",
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        elevation: isDark ? 8 : 4,
                        color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
                        shadowColor: isDark
                            ? Colors.black.withOpacity(0.5)
                            : Colors.grey.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: isDark
                              ? BorderSide(color: Colors.grey.withOpacity(0.2))
                              : BorderSide.none,
                        ),
                        child: InkWell(
                          onTap: () => _openPdf(file.path),
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? Colors.red.withOpacity(0.2)
                                            : Colors.red.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        Icons.picture_as_pdf,
                                        size: 24,
                                        color: isDark
                                            ? Colors.red[300]
                                            : Colors.red[700],
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            fileName,
                                            style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: isDark
                                                  ? Colors.white
                                                  : Colors.black87,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                          const SizedBox(height: 4),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: isDark
                                                  ? Colors.deepPurple
                                                      .withOpacity(0.2)
                                                  : Colors.blue
                                                      .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              _formatFileSize(fileStat.size),
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: isDark
                                                    ? Colors.deepPurple[300]
                                                    : Colors.blue[700],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.open_in_new,
                                      size: 20,
                                      color:
                                          isDark ? Colors.white54 : Colors.grey,
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                // Informations détaillées
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? Colors.grey[900]?.withOpacity(0.5)
                                        : Colors.grey[50],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 16,
                                        color: isDark
                                            ? Colors.white70
                                            : Colors.grey[600],
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Modifié le ${_formatDate(fileStat.modified)}',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12,
                                          color: isDark
                                              ? Colors.white70
                                              : Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadPdfFiles,
        tooltip: "Rafraîchir la liste",
        backgroundColor: isDark ? Colors.deepPurple : Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
