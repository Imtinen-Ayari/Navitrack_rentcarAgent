import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rent_car/Models/Contact.dart';
import 'package:rent_car/Pages/ContractDetails.dart';
import 'package:rent_car/services/Contract_service.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import 'package:rent_car/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

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
      return await getContartsByClient_Id(clientID, token);
    } catch (e) {
      print("Error loading contracts: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppTheme.buildRoundedAppBar(context, 'Contracts'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: FutureBuilder<List<Contrat>>(
        future: loadContracts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red.withOpacity(0.8),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Erreur lors du chargement',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.red[300] : Colors.red[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Veuillez réessayer plus tard',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: isDark ? Colors.white60 : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final contracts = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: contracts.length,
              itemBuilder: (context, index) {
                final contrat = contracts[index];
                return Hero(
                  tag: "contract_${contrat.numeroContract}",
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
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ContratDetailsPage(contrat: contrat),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Contrat N° ${contrat.numeroContract}',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? Colors.deepPurple
                                                  .withOpacity(0.2)
                                              : Colors.blue.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          '${contrat.nbJours} jours',
                                          style: GoogleFonts.plusJakartaSans(
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
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                  color: isDark ? Colors.white54 : Colors.grey,
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            _buildInfoRow(
                              context,
                              Icons.person,
                              'Conducteur principal',
                              contrat.conducteur?.nom ?? "Inconnu",
                              isDark,
                            ),

                            if (contrat.conducteur2 != null) ...[
                              const SizedBox(height: 12),
                              _buildInfoRow(
                                context,
                                Icons.person_outline,
                                'Conducteur secondaire',
                                contrat.conducteur2?.nom ?? "Inconnu",
                                isDark,
                              ),
                            ],

                            const SizedBox(height: 12),
                            _buildInfoRow(
                              context,
                              Icons.directions_car,
                              'Véhicule',
                              contrat.vehicule?.matricule ?? "Inconnu",
                              isDark,
                            ),

                            const SizedBox(height: 16),

                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.grey[900]?.withOpacity(0.5)
                                    : Colors.grey[50],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  _buildDateRow(
                                    context,
                                    Icons.flight_takeoff,
                                    'Départ',
                                    contrat.dateDepart,
                                    isDark,
                                    Colors.green,
                                  ),
                                  const SizedBox(height: 8),
                                  _buildDateRow(
                                    context,
                                    Icons.flight_land,
                                    'Retour',
                                    contrat.dateRetour,
                                    isDark,
                                    Colors.orange,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Total avec mise en valeur
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: isDark
                                      ? [
                                          Colors.deepPurple.withOpacity(0.2),
                                          Colors.deepPurple.withOpacity(0.1)
                                        ]
                                      : [
                                          Colors.blue.withOpacity(0.1),
                                          Colors.blue.withOpacity(0.05)
                                        ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total TTC',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: isDark
                                          ? Colors.white70
                                          : Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    '${contrat.totalTTc} DT',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: isDark
                                          ? Colors.deepPurple[300]
                                          : Colors.blue[700],
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
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    size: 64,
                    color: isDark ? Colors.grey[600] : Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Aucun contrat trouvé',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Vos contrats apparaîtront ici',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: isDark ? Colors.white54 : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label,
      String value, bool isDark) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.deepPurple.withOpacity(0.2)
                : Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 18,
            color: isDark ? Colors.deepPurple[300] : Colors.blue[700],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  color: isDark ? Colors.white60 : Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: isDark ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateRow(BuildContext context, IconData icon, String label,
      DateTime? date, bool isDark, Color accentColor) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: accentColor,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: isDark ? Colors.white70 : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                date != null
                    ? DateFormat('dd/MM/yyyy HH:mm').format(date)
                    : "Non défini",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: isDark ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
