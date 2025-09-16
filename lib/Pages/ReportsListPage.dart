/*
import 'package:flutter/material.dart';
import 'package:rent_car/Models/Report.dart';
import 'package:rent_car/Pages/ReportDetails.dart';
import 'package:rent_car/services/Reports_service.dart';
import 'package:rent_car/services/Secure_Storage.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  Future<List<Report>>? _futureReports;
  final ReportService _reportService = ReportService();
  String? clientID;
  String? token;

  @override
  void initState() {
    super.initState();
    loadCredentials();
  }

  Future<void> loadCredentials() async {
    clientID = await readClientID();
    token = await readToken();
    setState(() {
      _futureReports = _reportService.fetchReportsByUserId(clientID!, token!);
    });
  }

  Future<void> _refreshReports() async {
    setState(() {
      _futureReports = _reportService.fetchReportsByUserId(clientID!, token!);
    });
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
          'Reports',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<List<Report>>(
          future: _futureReports,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ));
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: _refreshReports,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Report report = snapshot.data![index];
                    return Hero(
                      tag: "report_${report.id}", // hero animation id
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 5),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(15),
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue[100],
                            child: const Icon(Icons.description,
                                color: Colors.blue),
                          ),
                          title: Text(
                            report.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  report.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    report.date.toString().substring(0, 16),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue[700],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              size: 18, color: Colors.grey),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ReportDetailsPage(report: report),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Center(
                  child: Text(
                'No reports found',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ));
            }
          },
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:rent_car/Models/Report.dart';
import 'package:rent_car/Pages/ReportDetails.dart';
import 'package:rent_car/services/Reports_service.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import 'package:rent_car/theme/app_theme.dart'; // Importez votre AppTheme
import 'package:google_fonts/google_fonts.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  Future<List<Report>>? _futureReports;
  final ReportService _reportService = ReportService();
  String? clientID;
  String? token;

  @override
  void initState() {
    super.initState();
    loadCredentials();
  }

  Future<void> loadCredentials() async {
    clientID = await readClientID();
    token = await readToken();
    setState(() {
      _futureReports = _reportService.fetchReportsByUserId(clientID!, token!);
    });
  }

  Future<void> _refreshReports() async {
    setState(() {
      _futureReports = _reportService.fetchReportsByUserId(clientID!, token!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppTheme.buildRoundedAppBar(context, 'Reports'),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<List<Report>>(
          future: _futureReports,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: _refreshReports,
                color: Theme.of(context).primaryColor,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Report report = snapshot.data![index];
                    return Hero(
                      tag: "report_${report.id}",
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 5),
                        elevation: isDark ? 8 : 4,
                        color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
                        shadowColor: isDark
                            ? Colors.black.withOpacity(0.5)
                            : Colors.grey.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(15),
                          leading: CircleAvatar(
                            backgroundColor: isDark
                                ? Colors.deepPurple.withOpacity(0.3)
                                : Colors.blue[100],
                            child: Icon(
                              Icons.description,
                              color:
                                  isDark ? Colors.deepPurple[300] : Colors.blue,
                            ),
                          ),
                          title: Text(
                            report.title,
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  report.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.plusJakartaSans(
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? Colors.deepPurple.withOpacity(0.2)
                                        : Colors.blue.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    report.date.toString().substring(0, 16),
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      color: isDark
                                          ? Colors.deepPurple[300]
                                          : Colors.blue[700],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: isDark ? Colors.white54 : Colors.grey,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ReportDetailsPage(report: report),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Center(
                child: Text(
                  'No reports found',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
