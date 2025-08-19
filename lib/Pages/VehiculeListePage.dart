/*import 'package:flutter/material.dart';
import 'package:rent_car/Models/Vehicule.dart';
import 'package:rent_car/services/Contract_service.dart';
import 'package:rent_car/services/Secure_Storage.dart';

class VehiculeListePage extends StatefulWidget {
  @override
  _VehiculeListePageState createState() => _VehiculeListePageState();
}

class _VehiculeListePageState extends State<VehiculeListePage> {
  Future<List<Vehicle>> loadVehicule() async {
    try {
      String? clientID = await readClientID();
      String? token = await readToken();
      if (clientID == null || token == null) {
        print("token ou idclien manquant");
        logout();
        return [];
      }
      print("🔐 Token: $token");
      print("👤 ClientID: $clientID");
      final List<Vehicle> vehicules = await getVehiclesByUser(clientID, token);
      return vehicules;
    } catch (e) {
      print("Error loading vehicule: $e");
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Vehicle List',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        elevation: 10,
      ),
      body: FutureBuilder<List<Vehicle>>(
        future: loadVehicule(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 50, color: Colors.red),
                  SizedBox(height: 10),
                  Text(
                    'Error loading Vehicles',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  )
                ],
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final vehicules = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: vehicules.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 8),
                          Text(
                            'Code Véhicule: ${vehicules[index].code}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Marque de véhicule: ${vehicules[index].marque}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.directions_car_filled, size: 24),
                              const SizedBox(width: 8),
                              Text(
                                'Matricule: ${vehicules[index].matricule}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.directions_car, size: 24),
                              const SizedBox(width: 8),
                              Text(
                                'Modèle: ${vehicules[index].model}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.category, size: 24),
                              const SizedBox(width: 8),
                              Text(
                                'Type: ${vehicules[index].type}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                'Aucun véhicule trouvé.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:rent_car/Models/Vehicule.dart';
import 'package:rent_car/services/Contract_service.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import 'package:rent_car/Widgets/BaseScaffold.dart';

class VehiculeListePage extends StatefulWidget {
  @override
  _VehiculeListePageState createState() => _VehiculeListePageState();
}

class _VehiculeListePageState extends State<VehiculeListePage> {
  Future<List<Vehicle>> loadVehicule() async {
    try {
      String? clientID = await readClientID();
      String? token = await readToken();
      if (clientID == null || token == null) {
        print("token ou id client manquant");
        logout();
        return [];
      }
      final List<Vehicle> vehicules = await getVehiclesByUser(clientID, token);
      return vehicules;
    } catch (e) {
      print("Erreur lors du chargement des véhicules: $e");
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Column(
        children: [
          AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, size: 30),
              onPressed: () => Navigator.pop(context),
              color: Colors.white,
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: const Text(
              'Vehicle List',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            toolbarHeight: 100,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            elevation: 10,
          ),
          Expanded(
            child: FutureBuilder<List<Vehicle>>(
              future: loadVehicule(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, size: 50, color: Colors.red),
                        SizedBox(height: 10),
                        Text(
                          'Error loading Vehicles',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  final vehicules = snapshot.data!;
                  return ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: vehicules.length,
                    itemBuilder: (context, index) {
                      final vehicle = vehicules[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 8),
                            Text(
                              'Code Véhicule: ${vehicules[index].code}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Marque de véhicule: ${vehicules[index].marque}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.directions_car_filled,
                                    size: 24),
                                const SizedBox(width: 8),
                                Text(
                                  'Matricule: ${vehicules[index].matricule}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.directions_car, size: 24),
                                const SizedBox(width: 8),
                                Text(
                                  'Modèle: ${vehicules[index].model}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.category, size: 24),
                                const SizedBox(width: 8),
                                Text(
                                  'Type: ${vehicules[index].type}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text(
                      'Aucun véhicule trouvé.',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rent_car/Models/Vehicule.dart';
import 'package:rent_car/services/Contract_service.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import 'package:rent_car/Widgets/BaseScaffold.dart';

class VehiculeListePage extends StatefulWidget {
  @override
  _VehiculeListePageState createState() => _VehiculeListePageState();
}

class _VehiculeListePageState extends State<VehiculeListePage> {
  Future<List<Vehicle>> loadVehicule() async {
    try {
      String? clientID = await readClientID();
      String? token = await readToken();

      if (clientID == null || token == null) {
        print("token ou id client manquant");
        logout();
        return [];
      }

      return await getVehiclesByUser(clientID, token);
    } catch (e) {
      print("Erreur lors du chargement des véhicules: $e");
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 2,
      title: 'Liste des Véhicules',
      showBackButton: true, // ou false selon contexte
      body: FutureBuilder<List<Vehicle>>(
        future: loadVehicule(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 50, color: Colors.red),
                  SizedBox(height: 10),
                  Text(
                    'Erreur lors du chargement des véhicules.',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final vehicules = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: vehicules.length,
              itemBuilder: (context, index) {
                final v = vehicules[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Code Véhicule: ${v.code}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Marque: ${v.marque}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      _infoRow(Icons.directions_car_filled,
                          'Matricule: ${v.matricule}'),
                      _infoRow(Icons.directions_car, 'Modèle: ${v.model}'),
                      _infoRow(Icons.category, 'Type: ${v.type}'),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                'Aucun véhicule trouvé.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:rent_car/Models/Vehicule.dart';
import 'package:rent_car/services/Contract_service.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import 'package:rent_car/Widgets/BaseScaffold.dart';

class VehiculeListePage extends StatefulWidget {
  @override
  _VehiculeListePageState createState() => _VehiculeListePageState();
}

class _VehiculeListePageState extends State<VehiculeListePage> {
  Future<List<Vehicle>> loadVehicule() async {
    try {
      String? clientID = await readClientID();
      String? token = await readToken();

      if (clientID == null || token == null) {
        print("🔒 Token ou ID client manquant");
        logout();
        return [];
      }

      return await getVehiclesByUser(clientID, token);
    } catch (e) {
      print("❌ Erreur lors du chargement des véhicules: $e");
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 2,
      title: 'Mes Véhicules',
      showBackButton: true,
      body: FutureBuilder<List<Vehicle>>(
        future: loadVehicule(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 50, color: Colors.red),
                  SizedBox(height: 10),
                  Text(
                    'Erreur lors du chargement des véhicules.',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final vehicules = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: vehicules.length,
              itemBuilder: (context, index) {
                final v = vehicules[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 4,
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
                            const Icon(Icons.directions_car_filled, size: 28),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '${v.marque} - ${v.model}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _infoRow(Icons.tag, 'Code Véhicule : ${v.code}'),
                        _infoRow(Icons.numbers, 'Matricule : ${v.matricule}'),
                        _infoRow(Icons.category, 'Type : ${v.type}'),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.directions_car_filled,
                      size: 60, color: Colors.grey),
                  SizedBox(height: 10),
                  Text(
                    'Aucun véhicule trouvé.',
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[700]),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
