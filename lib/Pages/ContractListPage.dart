/*import 'package:flutter/material.dart';
import 'package:rent_car/Models/Contact.dart';
import 'package:rent_car/Pages/ContractDetails.dart';
import 'package:rent_car/services/Contract_service.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import 'package:intl/intl.dart';

class ContactListPage extends StatefulWidget {
  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  Future<List<Contrat>> loadContracts() async {
    try {
      String? clientID = await readClientID();
      String? token = await readToken();
      if (clientID == null || token == null) {
        print("❌ Token ou clientID manquant");
        logout(); // redirige vers SignInPage

        return [];
      }

      print("🔐 Token: $token");
      print("👤 ClientID: $clientID");
      final List<Contrat> contracts = await getContartsByClient_Id(
        clientID,
        token,
      );
      return contracts;
    } catch (e) {
      print("Error loading contracts: $e");
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
          'Contract List',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        elevation: 10,
      ),
      body: FutureBuilder<List<Contrat>>(
        future: loadContracts(),
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
                    'Error loading contracts',
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final contacts = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            ContratDetailsPage(contrat: contacts[index]),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.secondary.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  'Numero contract: ${contacts[index].numeroContract}',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  'Nombre de jours : ${contacts[index].nbJours}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.person, size: 20),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Conducteur 1: ${contacts[index].conducteur?.nom ?? 'Unknown'}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              if (contacts[index].conducteur2 != null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.person_outline,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        'Conducteur 2: ${contacts[index].conducteur2?.nom ?? 'Unknown'}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.directions_car, size: 20),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Véhicule: ${contacts[index].vehicule?.matricule}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.calendar_today, size: 20),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Date départ: ${contacts[index].dateDepart != null ? DateFormat('yyyy-MM-dd HH:mm').format(contacts[index].dateDepart) : 'Unknown'}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_today_outlined,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Date retour: ${contacts[index].dateRetour != null ? DateFormat('yyyy-MM-dd HH:mm').format(contacts[index].dateRetour) : 'Unknown'}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.attach_money, size: 20),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Total TTC: ${contacts[index].totalTTc} DT',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                  Icon(Icons.warning, size: 50, color: Colors.red),
                  SizedBox(height: 10),
                  Text(
                    'No contracts found',
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rent_car/Models/Contact.dart';
import 'package:rent_car/Pages/ContractDetails.dart';
import 'package:rent_car/services/Contract_service.dart';
import 'package:rent_car/services/Secure_Storage.dart';

class ContactListPage extends StatefulWidget {
  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  Future<List<Contrat>> loadContracts() async {
    try {
      String? clientID = await readClientID();
      String? token = await readToken();
      if (clientID == null || token == null) {
        print("❌ Token ou clientID manquant");
        logout();
        return [];
      }

      print("🔐 Token: $token");
      print("👤 ClientID: $clientID");
      return await getContartsByClient_Id(clientID, token);
    } catch (e) {
      print("Error loading contracts: $e");
      throw e;
    }
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
        title: Text(
          'Contract',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
      ),
      body: FutureBuilder<List<Contrat>>(
        future: loadContracts(),
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
                  Text('Erreur lors du chargement',
                      style: TextStyle(fontSize: 18, color: Colors.red)),
                ],
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final contracts = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: contracts.length,
              itemBuilder: (context, index) {
                final contrat = contracts[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            ContratDetailsPage(contrat: contrat),
                      ),
                    );
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Contrat N° ${contrat.numeroContract}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '${contrat.nbJours} jours',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 20),

                          // Conducteurs
                          Row(
                            children: [
                              const Icon(Icons.person, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Conducteur 1 : ${contrat.conducteur?.nom ?? "Inconnu"}',
                                ),
                              ),
                            ],
                          ),
                          if (contrat.conducteur2 != null)
                            Row(
                              children: [
                                const Icon(Icons.person_outline, size: 20),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Conducteur 2 : ${contrat.conducteur2?.nom ?? "Inconnu"}',
                                  ),
                                ),
                              ],
                            ),

                          const SizedBox(height: 6),
                          // Véhicule
                          Row(
                            children: [
                              const Icon(Icons.directions_car, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Véhicule : ${contrat.vehicule?.matricule ?? "Inconnu"}',
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 6),
                          // Dates
                          Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Départ : ${contrat.dateDepart != null ? DateFormat('dd/MM/yyyy HH:mm').format(contrat.dateDepart) : "Inconnu"}',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today_outlined,
                                  size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Retour : ${contrat.dateRetour != null ? DateFormat('dd/MM/yyyy HH:mm').format(contrat.dateRetour) : "Inconnu"}',
                              ),
                            ],
                          ),

                          const SizedBox(height: 6),
                          // Total
                          Row(
                            children: [
                              const Icon(Icons.attach_money, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Total TTC : ${contrat.totalTTc} DT',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning, size: 50, color: Colors.orange),
                  SizedBox(height: 10),
                  Text(
                    'Aucun contrat trouvé',
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
}
