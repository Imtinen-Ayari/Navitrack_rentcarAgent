import 'package:flutter/material.dart';
import 'package:rent_car/Widgets/BusMapWidget.dart';
import 'package:google_fonts/google_fonts.dart';

class BusMapPage extends StatefulWidget {
  @override
  _BusMapPageState createState() => _BusMapPageState();
}

class _BusMapPageState extends State<BusMapPage> {
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [const Color(0xFF1F1F1F), const Color(0xFF2D2D2D)]
                : [const Color(0xFF0060FC), const Color(0xFF4D9EF6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      toolbarHeight: 100,
      title: Text(
        'Carte de flotte',
        style: GoogleFonts.plusJakartaSans(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildAppBar(context),
      body: BusMapWidget(),
    );
  }
}
