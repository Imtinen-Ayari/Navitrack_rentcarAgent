/*
import 'package:flutter/material.dart';
import 'package:rent_car/Pages/ContractDetails.dart';
import 'package:rent_car/Pages/HomePage.dart';
import 'package:rent_car/Pages/ProfilePage.dart';
import 'package:rent_car/Pages/ReportsListPage.dart';
import 'package:rent_car/Pages/SearchPage.dart';
import 'package:rent_car/Pages/SelectDatePage.dart';
import 'package:rent_car/Pages/VehiculeListePage.dart';

class BaseScaffold extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final String title;
  final bool showBackButton;
  final bool showFab;

  const BaseScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.title,
    this.showBackButton = false,
    this.showFab = true,
  });

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [
                    const Color(0xFF1F1F1F), // gris foncé
                    const Color(0xFF2D2D2D), // gris plus clair
                  ]
                : [
                    const Color(0xFF0060FC), // bleu
                    const Color(0xFF4D9EF6), // bleu clair
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(0)),
        ),
      ),
      toolbarHeight: 100,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'PlusJakartaSans',
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
              color: Colors.white,
            )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // couleurs dynamiques
    Color activeColor = Theme.of(context).colorScheme.primary;
    Color inactiveColor = isDark ? Colors.grey[400]! : Colors.grey[600]!;
    Color bottomBarColor = isDark ? const Color(0xFF2D2D2D) : Colors.white;
    Color fabColor = Theme.of(context).colorScheme.primary;

    Widget _navItem(IconData icon, int index, VoidCallback onTap) {
      return IconButton(
        icon: Icon(
          icon,
          color: currentIndex == index ? activeColor : inactiveColor,
        ),
        onPressed: () {
          if (currentIndex != index) {
            onTap();
          }
        },
        iconSize: 30,
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildAppBar(context),
      body: body,
      floatingActionButton: showFab
          ? FloatingActionButton(
              backgroundColor: fabColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SelectDatePage()),
                );
              },
              child: const Icon(
                Icons.add,
                size: 32,
                color: Colors.white,
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: bottomBarColor,
        elevation: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.home_rounded, 0, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              }),
              _navItem(Icons.search_rounded, 1, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContratSearchPage()),
                );
              }),
              const SizedBox(width: 48),
              _navItem(Icons.directions_car, 2, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VehiculeListePage()),
                );
              }),
              _navItem(Icons.account_circle_rounded, 3, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AgentProfilePage()),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:rent_car/Pages/ContractDetails.dart';
import 'package:rent_car/Pages/HomePage.dart';
import 'package:rent_car/Pages/ProfilePage.dart';
import 'package:rent_car/Pages/ReportsListPage.dart';
import 'package:rent_car/Pages/SearchPage.dart';
import 'package:rent_car/Pages/SelectDatePage.dart';
import 'package:rent_car/Pages/VehiculeListePage.dart';
import 'package:google_fonts/google_fonts.dart';

class BaseScaffold extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final String title;
  final bool showBackButton;
  final bool showFab;

  const BaseScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.title,
    this.showBackButton = false,
    this.showFab = true,
  });

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [
                    const Color(0xFF1F1F1F), // gris foncé
                    const Color(0xFF2D2D2D), // gris plus clair
                  ]
                : [
                    const Color(0xFF0060FC), // bleu
                    const Color(0xFF4D9EF6), // bleu clair
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      toolbarHeight: 100,
      title: Text(
        title,
        style: GoogleFonts.plusJakartaSans(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
              color: Colors.white,
            )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // couleurs dynamiques
    Color activeColor = isDark ? Colors.deepPurple[300]! : Color(0xFF0060FC)!;
    Color inactiveColor = isDark ? Colors.grey[400]! : Colors.grey[600]!;
    Color bottomBarColor = isDark ? const Color(0xFF2D2D2D) : Colors.white;
    Color fabColor = Theme.of(context).primaryColor;

    Widget _navItem(IconData icon, int index, VoidCallback onTap) {
      return IconButton(
        icon: Icon(
          icon,
          color: currentIndex == index ? activeColor : inactiveColor,
        ),
        onPressed: () {
          if (currentIndex != index) {
            onTap();
          }
        },
        iconSize: 30,
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildAppBar(context),
      body: body,
      floatingActionButton: showFab
          ? FloatingActionButton(
              backgroundColor: fabColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SelectDatePage()),
                );
              },
              child: const Icon(
                Icons.add,
                size: 32,
                color: Colors.white,
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: bottomBarColor,
        elevation: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.home_rounded, 0, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              }),
              _navItem(Icons.search_rounded, 1, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContratSearchPage()),
                );
              }),
              const SizedBox(width: 48),
              _navItem(Icons.directions_car, 2, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VehiculeListePage()),
                );
              }),
              _navItem(Icons.account_circle_rounded, 3, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AgentProfilePage()),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
