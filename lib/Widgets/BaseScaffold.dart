/*import 'package:flutter/material.dart';
import 'package:rent_car/Pages/SelectDatePage.dart';
import 'package:rent_car/Pages/HomePage.dart';
import 'package:rent_car/Pages/ProfilePage.dart';
import 'package:rent_car/Pages/ReportsListPage.dart';
import 'package:rent_car/Pages/VehiculeListePage.dart';

class BaseScaffold extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final PreferredSizeWidget? appBar;

  const BaseScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    Color activeColor = const Color(0xFF0060FC);
    Color inactiveColor = Colors.grey;

    Widget _navItem(IconData icon, int index, VoidCallback onTap) {
      return IconButton(
        icon: Icon(
          icon,
          color: currentIndex == index ? activeColor : inactiveColor,
        ),
        onPressed: onTap,
        iconSize: 30,
      );
    }

    return Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButton: FloatingActionButton(
        backgroundColor: activeColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SelectDatePage()),
          );
        },
        child: const Icon(Icons.add, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        elevation: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.home_rounded, 0, () {
                if (currentIndex != 0) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                }
              }),
              _navItem(Icons.insert_chart, 1, () {
                if (currentIndex != 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReportsPage()),
                  );
                }
              }),
              const SizedBox(width: 48), // espace pour le FAB
              _navItem(Icons.view_list, 2, () {
                if (currentIndex != 2) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VehiculeListePage()),
                  );
                }
              }),
              _navItem(Icons.account_circle_rounded, 3, () {
                if (currentIndex != 3) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
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

  const BaseScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.title,
    this.showBackButton = false, // false par défaut (pas de retour sur home)
  });

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
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
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
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
    Color activeColor = const Color(0xFF0060FC);
    Color inactiveColor = Colors.grey;

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
      appBar: _buildAppBar(context),
      body: body,
      floatingActionButton: FloatingActionButton(
        backgroundColor: activeColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SelectDatePage()),
          );
        },
        child: const Icon(Icons.add, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
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
} */
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
  final bool showFab; // ✅ on choisit si on montre le bouton flottant

  const BaseScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.title,
    this.showBackButton = false,
    this.showFab = true, // ✅ par défaut il s’affiche
  });

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
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
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
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
    Color activeColor = const Color(0xFF0060FC);
    Color inactiveColor = Colors.grey;

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
      appBar: _buildAppBar(context),
      body: body,
      floatingActionButton: showFab
          ? FloatingActionButton(
              backgroundColor: activeColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SelectDatePage()),
                );
              },
              child: const Icon(Icons.add, size: 32),
            )
          : null, // ✅ n’apparaît pas si showFab = false
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
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
