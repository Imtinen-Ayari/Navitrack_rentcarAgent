/*
import 'package:flutter/material.dart';
import 'package:rent_car/Models/Vehicule.dart';
import 'package:rent_car/services/Contract_service.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import 'package:rent_car/Widgets/BaseScaffold.dart';
import 'package:rent_car/Pages/BusMapPage.dart';

class VehiculeListePage extends StatefulWidget {
  const VehiculeListePage({super.key});

  @override
  State<VehiculeListePage> createState() => _VehiculeListePageState();
}

class _VehiculeListePageState extends State<VehiculeListePage> {
  Future<List<Vehicle>> loadVehicule() async {
    try {
      final clientID = await readClientID();
      final token = await readToken();

      if (clientID == null || token == null) {
        debugPrint("🔒 Token ou ID client manquant");
        logout();
        return [];
      }

      return await getVehiclesByUser(clientID, token);
    } catch (e) {
      debugPrint("❌ Erreur lors du chargement des véhicules: $e");
      rethrow;
    }
  }

  void _openBusMapNavigation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('BusMap Navigation'),
        content: const Text('Ouvrir la navigation BusMap pour vos véhicules'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BusMapPage()),
              );
            },
            child: const Text('Ouvrir'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 2,
      title: 'Vehicle Management',
      showBackButton: true,
      body: FutureBuilder<List<Vehicle>>(
        future: loadVehicule(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 50, color: Colors.red),
                  SizedBox(height: 10),
                  Text(
                    'Erreur lors du chargement des véhicules.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ],
              ),
            );
          }

          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final vehicules = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: vehicules.length,
                    itemBuilder: (context, index) {
                      final vehicle = vehicules[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.directions_car,
                                    size: 28,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      '${vehicle.marque} - ${vehicle.model}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'PlusJakartaSans',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              _buildInfoRow(Icons.tag, 'Code', vehicle.code),
                              const SizedBox(height: 8),
                              _buildInfoRow(Icons.numbers, 'Matricule',
                                  vehicle.matricule),
                              const SizedBox(height: 8),
                              _buildInfoRow(
                                  Icons.category, 'Type', vehicle.type),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton.icon(
                    onPressed: _openBusMapNavigation,
                    icon: const Icon(Icons.map),
                    label: const Text(
                      'BusMap Navigation',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.directions_car_filled,
                  size: 60,
                  color: Colors.grey,
                ),
                SizedBox(height: 10),
                Text(
                  'Aucun véhicule trouvé.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 10),
        Text(
          '$label : ',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontFamily: 'PlusJakartaSans',
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'PlusJakartaSans',
          ),
        ),
      ],
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:rent_car/Models/Vehicule.dart';
import 'package:rent_car/services/Contract_service.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import 'package:rent_car/Widgets/BaseScaffold.dart';
import 'package:rent_car/Pages/BusMapPage.dart';
import 'package:google_fonts/google_fonts.dart';

class VehiculeListePage extends StatefulWidget {
  const VehiculeListePage({super.key});

  @override
  State<VehiculeListePage> createState() => _VehiculeListePageState();
}

class _VehiculeListePageState extends State<VehiculeListePage> {
  Future<List<Vehicle>> loadVehicule() async {
    try {
      final clientID = await readClientID();
      final token = await readToken();

      if (clientID == null || token == null) {
        debugPrint("🔒 Token ou ID client manquant");
        logout();
        return [];
      }

      return await getVehiclesByUser(clientID, token);
    } catch (e) {
      debugPrint("❌ Erreur lors du chargement des véhicules: $e");
      rethrow;
    }
  }

  void _openBusMapNavigation() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark ? const Color(0xFF1F1F1F) : Colors.white,
          title: Text(
            'BusMap Navigation',
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          content: Text(
            'Ouvrir la navigation BusMap pour vos véhicules',
            style: GoogleFonts.plusJakartaSans(
              color: isDark ? Colors.grey[300] : Colors.black87,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Annuler',
                style: GoogleFonts.plusJakartaSans(
                  color: isDark ? Colors.grey[400] : Colors.blue,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? const Color(0xFF8B5CF6) : Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BusMapPage()),
                );
              },
              child: Text(
                'Ouvrir',
                style: GoogleFonts.plusJakartaSans(),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BaseScaffold(
      currentIndex: 2,
      title: 'Gestion des véhicules',
      showBackButton: true,
      body: FutureBuilder<List<Vehicle>>(
        future: loadVehicule(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // ✅ CircularProgressIndicator adapté au mode sombre
            return Center(
              child: CircularProgressIndicator(
                color: isDark
                    ? const Color.fromARGB(255, 60, 59, 59)
                    : Theme.of(context).primaryColor,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 50, color: Colors.red),
                  const SizedBox(height: 10),
                  Text(
                    'Erreur lors du chargement des véhicules.',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }

          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final vehicules = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: vehicules.length,
                    itemBuilder: (context, index) {
                      final vehicle = vehicules[index];
                      return Card(
                        color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
                        margin: const EdgeInsets.only(bottom: 16),
                        elevation: isDark ? 0 : 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: isDark
                                ? Colors.grey.withOpacity(0.2)
                                : Colors.grey.withOpacity(0.3),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.directions_car,
                                    size: 28,
                                    color: isDark
                                        ? const Color(0xFF8B5CF6)
                                        : Colors.blue,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      '${vehicle.marque} - ${vehicle.model}',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              _buildInfoRow(Icons.tag, 'Code', vehicle.code,
                                  isDark: isDark),
                              const SizedBox(height: 8),
                              _buildInfoRow(
                                  Icons.numbers, 'Matricule', vehicle.matricule,
                                  isDark: isDark),
                              const SizedBox(height: 8),
                              _buildInfoRow(
                                  Icons.category, 'Type', vehicle.type,
                                  isDark: isDark),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton.icon(
                    onPressed: _openBusMapNavigation,
                    icon: const Icon(Icons.map),
                    label: Text(
                      'Navigation BusMap',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isDark ? const Color(0xFF8B5CF6) : Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          // Cas où aucune donnée
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.directions_car_filled,
                  size: 60,
                  color: isDark ? Colors.grey[500] : Colors.grey,
                ),
                const SizedBox(height: 10),
                Text(
                  'Aucun véhicule trouvé.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    color: isDark ? Colors.grey[400] : Colors.black54,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value,
      {required bool isDark}) {
    return Row(
      children: [
        Icon(icon,
            size: 20, color: isDark ? Colors.grey[400] : Colors.grey[600]),
        const SizedBox(width: 10),
        Text(
          '$label : ',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ],
    );
  }
}
