/*import 'package:flutter/material.dart';
import 'package:rent_car/Models/Report.dart';
import 'package:rent_car/Pages/ReportDetails.dart';
import 'package:rent_car/services/Reports_service.dart';
import 'package:rent_car/services/Secure_Storage.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage();

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
    print("clientID: $clientID");
    print("token: $token");
    setState(() {
      _futureReports = _reportService.fetchReportsByUserId(clientID!, token!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: const EdgeInsets.only(top: 15.0),
        child: FutureBuilder<List<Report>>(
          future: _futureReports,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Report report = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.secondary.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Text(
                              report.title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(report.description),
                                Text(
                                  report.date.toString().substring(0, 16),
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
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
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('No reports found'));
            }
          },
        ),
      ),
    );
  }
}
*/
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
}
