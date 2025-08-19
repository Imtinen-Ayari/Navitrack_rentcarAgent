/*import 'package:flutter/material.dart';
import 'package:rent_car/Models/Conducteur.dart';
import 'package:rent_car/Models/Contact.dart';

class ContratDetailsPage extends StatelessWidget {
  final Contrat contrat;

  ContratDetailsPage({required this.contrat});

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
          title: Text(
            'Contrat N°${contrat.numeroContract}',
            style: TextStyle(color: Colors.white),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              if (contrat.vehicule != null) _buildVehicleCard(),
              if (contrat.conducteur != null)
                _buildConducteurCard(contrat.conducteur!, 'Primary Driver'),
              if (contrat.conducteur2 != null)
                _buildConducteurCard(contrat.conducteur2!, 'Second Driver'),
              _buildConsolidatedInfoCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVehicleCard() {
    return _buildDetailCard('Vehicle Details',
        'Model: ${contrat.vehicule!.model}\nPlate: ${contrat.vehicule!.matricule}');
  }

  Widget _buildConducteurCard(Conducteur conducteur, String title) {
    return _buildDetailCard(title,
        'Name: ${conducteur.nom}\nLicense: ${conducteur.numPermis}\ncin: ${conducteur.pieceIdentite}');
  }

  Widget _buildConsolidatedInfoCard() {
    final Map<String, String> details = {
      'Departure Date': contrat.dateDepart.toString(),
      'Return Date': contrat.dateRetour.toString(),
      'Number of Days': contrat.nbJours.toString(),
      'Total TTC': contrat.totalTTc.toString(),
      'Total HT': contrat.totalHT.toString(),
      'Payment Mode': contrat.modePayement,
      'Initial Mileage': contrat.kilometrageDepartAuto.toString(),
      'TVA': contrat.tva.toString(),
      'Stamp Fee': contrat.timbreF.toString(),
      'Prolonged': contrat.prolonged ? 'Yes' : 'No',
    };

    return Container(
      width: double.infinity,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: details.entries
                .map((entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: RichText(
                        text: TextSpan(
                          text: '${entry.key}: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text: entry.value,
                                style:
                                    TextStyle(fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard(String title, String value) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:rent_car/Models/Conducteur.dart';
import 'package:rent_car/Models/Contact.dart';
import 'package:rent_car/Widgets/BaseScaffold.dart'; // Assure-toi que le chemin est correct

class ContratDetailsPage extends StatelessWidget {
  final Contrat contrat;

  const ContratDetailsPage({super.key, required this.contrat});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 0, // ou 1/2/3 selon l'onglet lié
      title: 'Contrat N°${contrat.numeroContract}',
      showBackButton: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            if (contrat.vehicule != null) _buildVehicleCard(),
            if (contrat.conducteur != null)
              _buildConducteurCard(contrat.conducteur!, 'Primary Driver'),
            if (contrat.conducteur2 != null)
              _buildConducteurCard(contrat.conducteur2!, 'Second Driver'),
            _buildConsolidatedInfoCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleCard() {
    return _buildDetailCard('Vehicle Details',
        'Model: ${contrat.vehicule!.model}\nPlate: ${contrat.vehicule!.matricule}');
  }

  Widget _buildConducteurCard(Conducteur conducteur, String title) {
    return _buildDetailCard(title,
        'Name: ${conducteur.nom}\nLicense: ${conducteur.numPermis}\nID: ${conducteur.pieceIdentite}');
  }

  Widget _buildConsolidatedInfoCard() {
    final Map<String, String> details = {
      'Departure Date': contrat.dateDepart.toString(),
      'Return Date': contrat.dateRetour.toString(),
      'Number of Days': contrat.nbJours.toString(),
      'Total TTC': contrat.totalTTc.toString(),
      'Total HT': contrat.totalHT.toString(),
      'Payment Mode': contrat.modePayement,
      'Initial Mileage': contrat.kilometrageDepartAuto.toString(),
      'TVA': contrat.tva.toString(),
      'Stamp Fee': contrat.timbreF.toString(),
      'Prolonged': contrat.prolonged ? 'Yes' : 'No',
    };

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: details.entries
              .map((entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: RichText(
                      text: TextSpan(
                        text: '${entry.key}: ',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        children: [
                          TextSpan(
                              text: entry.value,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildDetailCard(String title, String value) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }
}
