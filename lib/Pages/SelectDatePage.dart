import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rent_car/Pages/MakeContractPage.dart';
import 'package:rent_car/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectDatePage extends StatefulWidget {
  const SelectDatePage({Key? key}) : super(key: key);

  @override
  SelectDatePageState createState() => SelectDatePageState();
}

class SelectDatePageState extends State<SelectDatePage> {
  DateTime departureDate = DateTime.now();
  DateTime arrivalDate = DateTime.now();
  TimeOfDay departureTime = TimeOfDay.now();
  TimeOfDay arrivalTime = TimeOfDay.now();

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(BuildContext context, bool isDeparture) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isDeparture ? departureDate : arrivalDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: isDark
              ? ThemeData.dark().copyWith(
                  colorScheme: const ColorScheme.dark(
                    primary: Colors.deepPurple,
                    surface: Colors.grey,
                  ),
                )
              : ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Color(0xFF0060FC),
                  ),
                ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        isDeparture ? departureDate = pickedDate : arrivalDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isDeparture) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isDeparture ? departureTime : arrivalTime,
      builder: (context, child) {
        return Theme(
          data: isDark
              ? ThemeData.dark().copyWith(
                  colorScheme: const ColorScheme.dark(
                    primary: Colors.deepPurple,
                  ),
                )
              : ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Color(0xFF0060FC),
                  ),
                ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        isDeparture ? departureTime = pickedTime : arrivalTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: AppBar(
          toolbarHeight: 130,
          elevation: 0,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? const [Color(0xFF1F1F1F), Color(0xFF2D2D2D)]
                    : const [Color(0xFF0060FC), Color(0xFF4D9EF6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(24)),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              children: [
                Text(
                  "Créer un contrat",
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Choisir date et heure",
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 160.0, left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              _buildCardTile(
                context,
                icon: Icons.calendar_month_rounded,
                label: "Date de départ",
                value: dateFormat.format(departureDate),
                onTap: () => _selectDate(context, true),
              ),
              const SizedBox(height: 12),
              _buildCardTile(
                context,
                icon: Icons.calendar_today,
                label: "Date d'arrivée",
                value: dateFormat.format(arrivalDate),
                onTap: () => _selectDate(context, false),
              ),
              const SizedBox(height: 12),
              _buildCardTile(
                context,
                icon: Icons.access_time,
                label: "Heure de départ",
                value: departureTime.format(context),
                onTap: () => _selectTime(context, true),
              ),
              const SizedBox(height: 12),
              _buildCardTile(
                context,
                icon: Icons.access_time_filled,
                label: "Heure d’arrivée",
                value: arrivalTime.format(context),
                onTap: () => _selectTime(context, false),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: isDark ? Colors.grey[900] : Colors.grey[100],
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MakeContractPage(
                    depart: departureDate,
                    arrival: arrivalDate,
                    time1: departureTime,
                    time2: arrivalTime,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.arrow_forward_ios_rounded),
            label: Text(
              "Suivant",
              style: GoogleFonts.plusJakartaSans(),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isDark ? Colors.deepPurple : const Color(0xFF0060FC),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.3)
                  : Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Card(
          elevation: 0,
          color: isDark ? Colors.grey[800] : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(
              color: isDark ? Colors.grey[700]! : Colors.grey[200]!,
              width: 0.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 28,
                  color: isDark ? Colors.deepPurple : Colors.grey[700],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        value,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          color: isDark ? Colors.white70 : Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.edit_calendar,
                  color: isDark ? Colors.white54 : Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
