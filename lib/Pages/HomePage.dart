import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rent_car/Widgets/BaseScaffold.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import 'package:google_fonts/google_fonts.dart';
import "../.env.dart";
import 'package:rent_car/Pages/ReportsListPage.dart';
import 'package:rent_car/Pages/ContractListPage.dart';
import 'package:rent_car/services/Agent_provider.dart';
import 'package:provider/provider.dart';
import 'package:rent_car/Pages/PdfListPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = true;
  int availableVehicles = 0;
  int rentedVehicles = 0;
  int activeContracts = 0;
  int expiringContracts = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  DateTime? _parseDate(dynamic raw) {
    try {
      if (raw == null) return null;
      if (raw is List && raw.length >= 3) {
        return DateTime(
          raw[0],
          raw[1],
          raw[2],
          raw.length > 3 ? raw[3] : 0,
          raw.length > 4 ? raw[4] : 0,
          raw.length > 5 ? raw[5] : 0,
        );
      } else if (raw is String) {
        return DateTime.tryParse(raw);
      }
    } catch (e) {
      debugPrint("❌ Date parsing error for $raw: $e");
    }
    return null;
  }

  Future<void> fetchData() async {
    try {
      String? token = await readToken();
      String? userId = await readClientID();
      final headers = {"Authorization": "Bearer $token"};

      final vehiclesRes = await http.get(
        Uri.parse(
            '$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/count-available-vehicles?id_user=$userId'),
        headers: headers,
      );

      final rentedRes = await http.get(
        Uri.parse(
            '$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/count-unavailable-vehicles?id_user=$userId'),
        headers: headers,
      );

      final contractsRes = await http.get(
        Uri.parse(
            '$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/getall-by-user/$userId'),
        headers: headers,
      );

      if (vehiclesRes.statusCode == 200 &&
          contractsRes.statusCode == 200 &&
          rentedRes.statusCode == 200) {
        availableVehicles = int.tryParse(vehiclesRes.body) ?? 0;
        rentedVehicles = int.tryParse(rentedRes.body) ?? 0;

        final decoded = jsonDecode(contractsRes.body);
        List contracts = decoded is List ? decoded : (decoded["data"] ?? []);

        DateTime now = DateTime.now();

        activeContracts = contracts.where((c) {
          DateTime? dateDepart = _parseDate(c['dateDepart']);
          DateTime? dateRetour = _parseDate(c['dateRetour']);
          if (dateDepart == null || dateRetour == null) return false;
          return (dateDepart.isBefore(now) ||
                  dateDepart.isAtSameMomentAs(now)) &&
              dateRetour.isAfter(now);
        }).length;

        expiringContracts = contracts.where((c) {
          DateTime? dateRetour = _parseDate(c['dateRetour']);
          if (dateRetour == null) return false;
          return dateRetour.year == now.year &&
              dateRetour.month == now.month &&
              dateRetour.day == now.day;
        }).length;
      }

      if (mounted) setState(() => loading = false);
    } catch (e) {
      if (mounted) setState(() => loading = false);
    }
  }

  Widget _statCard(IconData icon, Color iconColor, String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.08),
            blurRadius: isDark ? 15 : 10,
            offset: const Offset(2, 6),
          ),
        ],
        border: isDark
            ? Border.all(color: Colors.grey.withOpacity(0.2), width: 0.5)
            : null,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconColor.withOpacity(isDark ? 0.25 : 0.15),
            child: Icon(
              icon,
              color: isDark ? iconColor.withOpacity(0.9) : iconColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradientColors = isDark
        ? const [
            Color(0xFF4C1D95),
            Color(0xFF6B46C1)
          ] // deepPurple gradient pour dark
        : const [
            Color(0xFF0060FC),
            Color(0xFF4D9EF6)
          ]; // bleu gradient pour light

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color:
                  (isDark ? Colors.deepPurple : Colors.blue).withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(2, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 26),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final agent = context.watch<AgentProvider>().currentAgent;

    return BaseScaffold(
      currentIndex: 0,
      title: 'Bienvenue ${agent?.name ?? "Agent"}',
      body: loading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Statistiques Rapides",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _statCard(
                    Icons.directions_car,
                    Colors.green,
                    "Véhicules Disponibles",
                    availableVehicles.toString(),
                  ),
                  const SizedBox(height: 12),
                  _statCard(
                    Icons.key,
                    Colors.orange,
                    "Véhicules Actuellement Loués",
                    rentedVehicles.toString(),
                  ),
                  const SizedBox(height: 12),
                  _statCard(
                    Icons.description,
                    isDark ? Colors.lightBlue : Colors.blue,
                    "Contrats Actifs",
                    activeContracts.toString(),
                  ),
                  const SizedBox(height: 12),
                  _statCard(
                    Icons.timer,
                    Colors.red,
                    "Contrats Expirant Aujourd’hui",
                    expiringContracts.toString(),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Opérations",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _actionButton(
                    icon: Icons.assignment,
                    label: "Contracts",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContactListPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _actionButton(
                    icon: Icons.bar_chart,
                    label: "Rapports",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReportsPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _actionButton(
                    icon: Icons.picture_as_pdf,
                    label: "PDFs Contrats",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PdfListPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
