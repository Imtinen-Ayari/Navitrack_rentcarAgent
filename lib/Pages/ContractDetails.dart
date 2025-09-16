import 'package:flutter/material.dart';
import 'package:rent_car/Models/Conducteur.dart';
import 'package:rent_car/Models/Contact.dart';
import 'package:rent_car/Widgets/BaseScaffold.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ContratDetailsPage extends StatelessWidget {
  final Contrat contrat;

  const ContratDetailsPage({super.key, required this.contrat});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 0,
      title: 'Contrat N°${contrat.numeroContract}',
      showBackButton: true,
      showFab: false,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (contrat.vehicule != null) _buildVehicleCard(context),
            if (contrat.conducteur != null)
              _buildConducteurCard(
                  context, contrat.conducteur!, 'Conducteur Principal'),
            if (contrat.conducteur2 != null)
              _buildConducteurCard(
                  context, contrat.conducteur2!, 'Conducteur Secondaire'),
            _buildConsolidatedInfoCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: isDark ? 8 : 4,
      color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
      shadowColor:
          isDark ? Colors.black.withOpacity(0.5) : Colors.grey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isDark
            ? BorderSide(color: Colors.grey.withOpacity(0.2))
            : BorderSide.none,
      ),
      margin: const EdgeInsets.only(bottom: 16),
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
                        ? Colors.blue.withOpacity(0.2)
                        : Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.directions_car,
                    color: isDark ? Colors.blue[300] : Colors.blue[700],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Détails du Véhicule',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildInfoRow(context, 'Modèle', contrat.vehicule!.model),
            const SizedBox(height: 12),
            _buildInfoRow(context, 'Matricule', contrat.vehicule!.matricule),
          ],
        ),
      ),
    );
  }

  Widget _buildConducteurCard(
      BuildContext context, Conducteur conducteur, String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: isDark ? 8 : 4,
      color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
      shadowColor:
          isDark ? Colors.black.withOpacity(0.5) : Colors.grey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isDark
            ? BorderSide(color: Colors.grey.withOpacity(0.2))
            : BorderSide.none,
      ),
      margin: const EdgeInsets.only(bottom: 16),
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
                        ? Colors.green.withOpacity(0.2)
                        : Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    title.contains('Principal')
                        ? Icons.person
                        : Icons.person_outline,
                    color: isDark ? Colors.green[300] : Colors.green[700],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildInfoRow(context, 'Nom', conducteur.nom),
            const SizedBox(height: 12),
            _buildInfoRow(context, 'Permis', conducteur.numPermis),
            const SizedBox(height: 12),
            _buildInfoRow(
                context, 'Pièce d\'identité', conducteur.pieceIdentite),
          ],
        ),
      ),
    );
  }

  Widget _buildConsolidatedInfoCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Map<String, String> details = {
      'Date de Départ': contrat.dateDepart != null
          ? DateFormat('dd/MM/yyyy HH:mm').format(contrat.dateDepart!)
          : 'Non définie',
      'Date de Retour': contrat.dateRetour != null
          ? DateFormat('dd/MM/yyyy HH:mm').format(contrat.dateRetour!)
          : 'Non définie',
      'Nombre de Jours': contrat.nbJours.toString(),
      'Mode de Paiement': contrat.modePayement,
      'Kilométrage Initial': '${contrat.kilometrageDepartAuto.toString()} km',
      'Prolongé': contrat.prolonged ? 'Oui' : 'Non',
    };

    final Map<String, String> financialDetails = {
      'Total HT': '${contrat.totalHT.toString()} DT',
      'TVA': '${contrat.tva.toString()} DT',
      'Timbre Fiscal': '${contrat.timbreF.toString()} DT',
      'Total TTC': '${contrat.totalTTc.toString()} DT',
    };

    return Column(
      children: [
        Card(
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
          margin: const EdgeInsets.only(bottom: 16),
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
                            ? Colors.orange.withOpacity(0.2)
                            : Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.info_outline,
                        color: isDark ? Colors.orange[300] : Colors.orange[700],
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Informations Générales',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ...details.entries
                    .map((entry) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildInfoRow(context, entry.key, entry.value),
                        ))
                    .toList(),
              ],
            ),
          ),
        ),
        Card(
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
          margin: const EdgeInsets.only(bottom: 16),
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
                            ? Colors.deepPurple.withOpacity(0.2)
                            : Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.attach_money,
                        color:
                            isDark ? Colors.deepPurple[300] : Colors.blue[700],
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Détails Financiers',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ...financialDetails.entries
                    .map((entry) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildFinancialRow(context, entry.key,
                              entry.value, entry.key == 'Total TTC'),
                        ))
                    .toList(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : Colors.grey[700],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFinancialRow(
      BuildContext context, String label, String value, bool isTotal) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: isTotal ? const EdgeInsets.all(12) : EdgeInsets.zero,
      decoration: isTotal
          ? BoxDecoration(
              color: isDark
                  ? Colors.deepPurple.withOpacity(0.1)
                  : Colors.blue.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            )
          : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: isTotal ? 16 : 14,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
                color: isDark ? Colors.white70 : Colors.grey[700],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontSize: isTotal ? 18 : 14,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
                color: isTotal
                    ? (isDark ? Colors.deepPurple[300] : Colors.blue[700])
                    : (isDark ? Colors.white : Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
