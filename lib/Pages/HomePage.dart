/*import 'package:flutter/material.dart';
import 'package:rent_car/Pages/ContractListPage.dart';
import 'package:rent_car/Pages/BusMapPage.dart';
import 'package:rent_car/Pages/ReportsListPage.dart';
import 'package:rent_car/Pages/SelectDatePage.dart';
import 'package:rent_car/Widgets/HomePageButton.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import 'package:rent_car/Pages/VehiculeListePage.dart';
import 'package:rent_car/Pages/AddPhotoPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Welcome Rent Car Agent!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              color: Colors.white,
              iconSize: 30,
              onPressed: () {
                logout();
              },
            ),
          ],
        ),
        toolbarHeight: 120,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        elevation: 10,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomButton(
              text: 'Make contact',
              icon: const Icon(
                Icons.handshake_rounded,
                size: 50,
                color: Colors.black,
              ),
              onPressed: () {
                print('🟢 Bouton "Make contact" pressé');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectDatePage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Contract List",
              icon: const Icon(Icons.view_list, size: 40, color: Colors.black),
              onPressed: () {
                print('🟢 Bouton "Contract List" pressé');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactListPage()),
                );
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Track Vehicles',
              icon: const Icon(Icons.map, size: 40, color: Colors.black),
              onPressed: () {
                print('🟢 Bouton "Track Vehicles" pressé');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BusMapPage()),
                );
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Reports List",
              icon: const Icon(Icons.view_list, size: 40, color: Colors.black),
              onPressed: () {
                print('🟢 Bouton "Reports List" pressé');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReportsPage()),
                );
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Vehicles List",
              icon: const Icon(Icons.view_list, size: 40, color: Colors.black),
              onPressed: () {
                print('🟢 Bouton "Vehicles List" pressé');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VehiculeListePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:rent_car/Pages/ContractListPage.dart';
import 'package:rent_car/Pages/BusMapPage.dart';
import 'package:rent_car/Pages/ReportsListPage.dart';
import 'package:rent_car/Pages/SelectDatePage.dart';
import 'package:rent_car/Widgets/HomePageButton.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import 'package:rent_car/Pages/VehiculeListePage.dart';
import 'package:rent_car/Pages/AddPhotoPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Welcome Rent Car Agent!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              color: Colors.white,
              iconSize: 30,
              onPressed: () {
                logout();
              },
            ),
          ],
        ),
        toolbarHeight: 120,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        elevation: 10,
      ),
      body: SingleChildScrollView(
        // ✅ Correction ici
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomButton(
                text: 'Make contact',
                icon: const Icon(Icons.handshake_rounded,
                    size: 50, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SelectDatePage()),
                  );
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: "Contract List",
                icon:
                    const Icon(Icons.view_list, size: 40, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactListPage()),
                  );
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Track Vehicles',
                icon: const Icon(Icons.map, size: 40, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BusMapPage()),
                  );
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: "Reports List",
                icon:
                    const Icon(Icons.view_list, size: 40, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReportsPage()),
                  );
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: "Vehicles List",
                icon:
                    const Icon(Icons.view_list, size: 40, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VehiculeListePage()),
                  );
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: "Add Photo (Test)",
                icon: const Icon(Icons.photo_library,
                    size: 40, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const AddPhotoPage(contractId: 'fake-contract'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:rent_car/Pages/ContractListPage.dart';
import 'package:rent_car/Pages/BusMapPage.dart';
import 'package:rent_car/Pages/ReportsListPage.dart';
import 'package:rent_car/Pages/SelectDatePage.dart';
import 'package:rent_car/Pages/VehiculeListePage.dart';
import 'package:rent_car/Pages/AddPhotoPage.dart';
import 'package:rent_car/Widgets/HomePageButton.dart';
import 'package:rent_car/services/Secure_Storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeContent(), // Accueil avec boutons (StatelessWidget ok sans const)
    ContactListPage(), // Liste des contrats (StatefulWidget => PAS const)
    BusMapPage(), // Carte bus (idem)
    ReportsPage(), // Rapports
    VehiculeListePage(), // Véhicules
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              // Text statique, on peut garder const
              'Welcome Rent Car Agent!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              color: Colors.white,
              iconSize: 30,
              onPressed: () {
                logout();
              },
            ),
          ],
        ),
        toolbarHeight: 120,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        elevation: 10,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Contrats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Bus',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            label: 'Rapports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Véhicules',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomButton(
              text: 'Make contact',
              icon: const Icon(Icons.handshake_rounded,
                  size: 50, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SelectDatePage()), // PAS const ici
                );
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Contract List",
              icon: const Icon(Icons.view_list, size: 40, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ContactListPage()), // PAS const ici
                );
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Track Vehicles',
              icon: const Icon(Icons.map, size: 40, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BusMapPage()), // PAS const ici
                );
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Reports List",
              icon: const Icon(Icons.view_list, size: 40, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReportsPage()), // PAS const ici
                );
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Vehicles List",
              icon: const Icon(Icons.view_list, size: 40, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          VehiculeListePage()), // PAS const ici
                );
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Add Photo (Test)",
              icon: const Icon(Icons.photo_library,
                  size: 40, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPhotoPage(
                        contractId: 'fake-contract'), // PAS const ici
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:rent_car/Pages/ContractListPage.dart';
import 'package:rent_car/Pages/BusMapPage.dart';
import 'package:rent_car/Pages/ProfilePage.dart';
import 'package:rent_car/Pages/ReportsListPage.dart';
import 'package:rent_car/Pages/SelectDatePage.dart';
import 'package:rent_car/Pages/VehiculeListePage.dart';
import 'package:rent_car/Pages/AddPhotoPage.dart';
import 'package:rent_car/Widgets/HomePageButton.dart';
import 'package:rent_car/services/Secure_Storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    ContactListPage(),
    SelectDatePage(),
    //BusMapPage(),
    ReportsPage(),
    //VehiculeListePage(),
    ProfilePage(),
  ];

  final List<String> _titles = [
    'Welcome Rent Car Agent',
    'Contract List',
    "Let's Make a Contrat",
    'Reports List',
    'Vehicles List',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _titles[_selectedIndex],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              color: Colors.white,
              iconSize: 30,
              onPressed: () {
                logout();
              },
            ),
          ],
        ),
        toolbarHeight: 120,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        elevation: 10,
      ),

      body: _pages[_selectedIndex],

      // 🔘 Bouton central
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onItemTapped(2), // 👉 index pour BusMapPage
        backgroundColor: const Color(0xFF0060FC),
        child: const Icon(Icons.add, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // 📎 Barre de navigation avec encoche
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        elevation: 10,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home,
                    color:
                        _selectedIndex == 0 ? Color(0xFF0060FC) : Colors.grey),
                onPressed: () => _onItemTapped(0),
              ),
              IconButton(
                icon: Icon(Icons.description,
                    color:
                        _selectedIndex == 1 ? Color(0xFF0060FC) : Colors.grey),
                onPressed: () => _onItemTapped(1),
              ),
              const SizedBox(width: 48), // espace pour bouton central
              IconButton(
                icon: Icon(Icons.insert_chart,
                    color:
                        _selectedIndex == 3 ? Color(0xFF0060FC) : Colors.grey),
                onPressed: () => _onItemTapped(3),
              ),
              IconButton(
                icon: Icon(Icons.person,
                    color:
                        _selectedIndex == 4 ? Color(0xFF0060FC) : Colors.grey),
                onPressed: () => _onItemTapped(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomButton(
              text: 'Make contact',
              icon: const Icon(Icons.handshake_rounded,
                  size: 50, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SelectDatePage()),
                );
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Contract List",
              icon: const Icon(Icons.view_list, size: 40, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactListPage()),
                );
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Track Vehicles',
              icon: const Icon(Icons.map, size: 40, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BusMapPage()),
                );
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Reports List",
              icon: const Icon(Icons.view_list, size: 40, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportsPage()),
                );
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Vehicles List",
              icon: const Icon(Icons.view_list, size: 40, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VehiculeListePage()),
                );
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Add Photo (Test)",
              icon: const Icon(Icons.photo_library,
                  size: 40, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddPhotoPage(contractId: 'fake-contract'),
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:rent_car/Pages/ContractListPage.dart';
import 'package:rent_car/Pages/BusMapPage.dart';
import 'package:rent_car/Pages/ProfilePage.dart';
import 'package:rent_car/Pages/ReportsListPage.dart';
import 'package:rent_car/Pages/SelectDatePage.dart';
import 'package:rent_car/Pages/VehiculeListePage.dart';
import 'package:rent_car/Pages/AddPhotoPage.dart';
import 'package:rent_car/Widgets/HomePageButton.dart';
import 'package:rent_car/services/Secure_Storage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        toolbarHeight: 120,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        elevation: 10,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Welcome Rent Car Agent',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            /*IconButton(
              icon: const Icon(Icons.logout),
              color: Colors.white,
              iconSize: 30,
              onPressed: () {
                logout();
              },
            ),*/
          ],
        ),
      ),
      body: const HomeContent(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0060FC),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SelectDatePage()),
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
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home_rounded, color: Colors.grey),
                onPressed: () {
                  /*Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));*/
                },
              ),
              IconButton(
                icon: const Icon(Icons.insert_chart, color: Colors.grey),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ReportsPage()));
                },
              ),
              const SizedBox(width: 48),
              IconButton(
                icon: const Icon(Icons.view_list, color: Colors.grey),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VehiculeListePage()));
                },
              ),
              IconButton(
                icon: const Icon(Icons.account_circle_rounded,
                    color: Colors.grey),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: <Widget>[
          CustomButton(
            text: 'Make contact',
            icon: const Icon(Icons.handshake_rounded,
                size: 50, color: Colors.black),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SelectDatePage()));
            },
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: "Contract List",
            icon: const Icon(Icons.view_list, size: 40, color: Colors.black),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ContactListPage()));
            },
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: 'Reports List',
            icon: const Icon(Icons.insert_chart, size: 40, color: Colors.black),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReportsPage()));
            },
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: "Vehicles List",
            icon: const Icon(Icons.view_list, size: 40, color: Colors.black),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VehiculeListePage()));
            },
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: "Add Photo (Test)",
            icon:
                const Icon(Icons.photo_library, size: 40, color: Colors.black),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddPhotoPage(contractId: 'fake-contract'),
                  ));
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:rent_car/Widgets/BaseScaffold.dart';
import 'package:rent_car/Pages/ContractListPage.dart';
import 'package:rent_car/Pages/AddPhotoPage.dart';
import 'package:rent_car/Pages/ReportsListPage.dart';
import 'package:rent_car/Pages/SelectDatePage.dart';
import 'package:rent_car/Pages/VehiculeListePage.dart';
import 'package:rent_car/Widgets/HomePageButton.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: const HomeContent(),
      currentIndex: 0, // Home est actif
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: <Widget>[
          CustomButton(
            text: 'Make contact',
            icon: const Icon(Icons.handshake_rounded,
                size: 50, color: Colors.black),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SelectDatePage()));
            },
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: "Contract List",
            icon: const Icon(Icons.view_list, size: 40, color: Colors.black),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ContactListPage()));
            },
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: 'Reports List',
            icon: const Icon(Icons.insert_chart, size: 40, color: Colors.black),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReportsPage()));
            },
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: "Vehicles List",
            icon: const Icon(Icons.view_list, size: 40, color: Colors.black),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VehiculeListePage()));
            },
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: "Add Photo (Test)",
            icon:
                const Icon(Icons.photo_library, size: 40, color: Colors.black),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddPhotoPage(contractId: 'fake-contract'),
                  ));
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:rent_car/Widgets/BaseScaffold.dart';
import 'package:rent_car/Pages/SelectDatePage.dart';
import 'package:rent_car/Widgets/HomePageButton.dart';
import 'package:rent_car/Pages/ContractListPage.dart';
import 'package:rent_car/Pages/AddPhotoPage.dart';
import 'package:rent_car/Pages/ReportsListPage.dart';
import 'package:rent_car/Pages/VehiculeListePage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 0,
      title: 'Welcome Rent Car Agent',
      //showBackButton: false,
      body: const HomeContent(),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: <Widget>[
          CustomButton(
            text: 'Make contact',
            icon: const Icon(Icons.handshake_rounded,
                size: 50, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SelectDatePage()),
              );
            },
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: "Contract List",
            icon: const Icon(Icons.view_list, size: 40, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactListPage()),
              );
            },
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: 'Reports List',
            icon: const Icon(Icons.insert_chart, size: 40, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReportsPage()),
              );
            },
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: "Vehicles List",
            icon: const Icon(Icons.view_list, size: 40, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VehiculeListePage()),
              );
            },
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: "Add Photo (Test)",
            icon:
                const Icon(Icons.photo_library, size: 40, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AddPhotoPage(contractId: 'fake-contract'),
                ),
              );
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rent_car/Widgets/BaseScaffold.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import 'package:intl/intl.dart';
import "../.env.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 0,
      title: 'Welcome Rent Car Agent',
      body: const HomeContent(),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  bool loading = true;
  int availableVehicles = 0;
  int rentedVehicles = 0;
  int activeContracts = 0;
  int expiringContracts = 0;
  List<String> recentActivities = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      String? token = await readToken();
      String? userId = await readClientID();
      final headers = {"Authorization": "Bearer $token"};

      //Véhicules disponibles
      final vehiclesRes = await http.get(
        Uri.parse(
            '$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/count-available-vehicles?id_user=$userId'),
        headers: {"Authorization": "Bearer $token"},
      );

      // Véhicules loués
      final rentedRes = await http.get(
        Uri.parse(
            '$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/count-unavailable-vehicles?id_user=$userId'),
        headers: {"Authorization": "Bearer $token"},
      );
      final contractsRes = await http.get(
        Uri.parse(
            '$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/getall-by-user/$userId'),
        headers: headers,
      );

      print(
          "Available vehicles status: ${vehiclesRes.statusCode}, body: ${vehiclesRes.body}");
      print(
          "Rented vehicles status: ${rentedRes.statusCode}, body: ${rentedRes.body}");
      print(
          "Contracts status: ${contractsRes.statusCode}, body: ${contractsRes.body}");

      if (vehiclesRes.statusCode == 200 &&
          contractsRes.statusCode == 200 &&
          rentedRes.statusCode == 200) {
        availableVehicles = int.parse(vehiclesRes.body);
        rentedVehicles = int.parse(rentedRes.body);
        final contracts = jsonDecode(contractsRes.body) as List;
        activeContracts =
            contracts.where((c) => c['status'] == 'active').length;

        String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
        expiringContracts = contracts
            .where(
                (c) => c['endDate'] != null && c['endDate'].startsWith(today))
            .length;

        contracts.sort((a, b) => DateTime.parse(b['createdAt'])
            .compareTo(DateTime.parse(a['createdAt'])));

        recentActivities = contracts
            .take(3)
            .map((c) => "Contract #${c['id']} created on ${c['createdAt']}")
            .toList();
      }

      setState(() {
        loading = false;
      });
    } catch (e) {
      print("Error: $e");
      setState(() => loading = false);
    }
  }

  Widget _statCard(IconData icon, Color iconColor, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 26),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 15))),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _activityCard(String label) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(label, style: const TextStyle(fontSize: 15)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Welcome, Agent name !",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Text("Quick Stats",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade400)),
          const SizedBox(height: 10),
          _statCard(Icons.directions_car, Colors.red, "Available Vehicles",
              availableVehicles.toString()),
          const SizedBox(height: 10),
          _statCard(Icons.key, Colors.amber, "Vehicles Currently Rented",
              rentedVehicles.toString()),
          const SizedBox(height: 10),
          _statCard(Icons.description, Colors.blue, "Active Contracts",
              activeContracts.toString()),
          const SizedBox(height: 10),
          _statCard(Icons.timer, Colors.redAccent, "Contracts Expiring Today",
              expiringContracts.toString()),
          const SizedBox(height: 30),
          Text("Recent Activity",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade400)),
          const SizedBox(height: 10),
          for (var activity in recentActivities) ...[
            _activityCard(activity),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rent_car/Widgets/BaseScaffold.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import 'package:intl/intl.dart';
import "../.env.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 0,
      title: 'Welcome Rent Car Agent',
      body: const HomeContent(),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  bool loading = true;
  int availableVehicles = 0;
  int rentedVehicles = 0;
  int activeContracts = 0;
  int expiringContracts = 0;
  List<String> recentActivities = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      String? token = await readToken();
      String? userId = await readClientID();
      final headers = {"Authorization": "Bearer $token"};

      final vehiclesRes = await http.get(
        Uri.parse(
            '$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/count-available-vehicles?id_user=$userId'),
        headers: headers,
      );

      final rentedRes = await http.get(
        Uri.parse(
            '$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/count-unavailable-vehicles?id_user=$userId'),
        headers: headers,
      );

      final contractsRes = await http.get(
        Uri.parse(
            '$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/getall-by-user/$userId'),
        headers: headers,
      );

      if (vehiclesRes.statusCode == 200 &&
          contractsRes.statusCode == 200 &&
          rentedRes.statusCode == 200) {
        availableVehicles = int.parse(vehiclesRes.body);
        rentedVehicles = int.parse(rentedRes.body);
        final contracts = jsonDecode(contractsRes.body) as List;
        activeContracts =
            contracts.where((c) => c['status'] == 'active').length;

        String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
        expiringContracts = contracts
            .where(
                (c) => c['endDate'] != null && c['endDate'].startsWith(today))
            .length;

        contracts.sort((a, b) => DateTime.parse(b['createdAt'])
            .compareTo(DateTime.parse(a['createdAt'])));

        recentActivities = contracts
            .take(3)
            .map((c) => "Contract #${c['id']} created on ${c['createdAt']}")
            .toList();
      }

      setState(() {
        loading = false;
      });
    } catch (e) {
      print("Error: $e");
      setState(() => loading = false);
    }
  }

  Widget _statCard(IconData icon, Color iconColor, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50, // bleu clair au lieu de violet
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 26),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 15))),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _activityCard(String label) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.blue.shade50, // bleu clair au lieu de violet
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(label, style: const TextStyle(fontSize: 15)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phrase enlevée ici
          Text("Quick Stats",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700)), // bleu foncé
          const SizedBox(height: 10),
          _statCard(Icons.directions_car, Colors.red, "Available Vehicles",
              availableVehicles.toString()),
          const SizedBox(height: 10),
          _statCard(Icons.key, Colors.amber, "Vehicles Currently Rented",
              rentedVehicles.toString()),
          const SizedBox(height: 10),
          _statCard(Icons.description, Colors.blue, "Active Contracts",
              activeContracts.toString()),
          const SizedBox(height: 10),
          _statCard(Icons.timer, Colors.redAccent, "Contracts Expiring Today",
              expiringContracts.toString()),
          const SizedBox(height: 30),
          Text("Recent Activity",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700)), // bleu foncé
          const SizedBox(height: 10),
          for (var activity in recentActivities) ...[
            _activityCard(activity),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rent_car/Widgets/BaseScaffold.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import 'package:intl/intl.dart';
import "../.env.dart";
import 'package:rent_car/Pages/ReportsListPage.dart';
import 'package:rent_car/Pages/ContractListPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = true;
  int availableVehicles = 0;
  int rentedVehicles = 0;
  int activeContracts = 0;
  int expiringContracts = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      String? token = await readToken();
      String? userId = await readClientID();
      final headers = {"Authorization": "Bearer $token"};

      final vehiclesRes = await http.get(
        Uri.parse(
            '$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/count-available-vehicles?id_user=$userId'),
        headers: headers,
      );

      final rentedRes = await http.get(
        Uri.parse(
            '$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/count-unavailable-vehicles?id_user=$userId'),
        headers: headers,
      );

      final contractsRes = await http.get(
        Uri.parse(
            '$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/getall-by-user/$userId'),
        headers: headers,
      );

      if (vehiclesRes.statusCode == 200 &&
          contractsRes.statusCode == 200 &&
          rentedRes.statusCode == 200) {
        availableVehicles = int.tryParse(vehiclesRes.body) ?? 0;
        rentedVehicles = int.tryParse(rentedRes.body) ?? 0;

        final decoded = jsonDecode(contractsRes.body);
        List contracts = decoded is List ? decoded : (decoded["data"] ?? []);

        activeContracts =
            contracts.where((c) => c['status'] == 'active').length;

        String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
        expiringContracts = contracts
            .where(
                (c) => c['endDate'] != null && c['endDate'].startsWith(today))
            .length;
      }

      setState(() => loading = false);
    } catch (e) {
      print("Error: $e");
      setState(() => loading = false);
    }
  }

  Widget _statCard(IconData icon, Color iconColor, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconColor.withOpacity(0.15),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
              child: Text(label,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500))),
          Text(value,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _actionButton(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.blue.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(2, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 26),
            const SizedBox(width: 15),
            Expanded(
              child: Text(label,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 0,
      title: 'Welcome Rent Car Agent',
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Quick Stats",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700)),
                  const SizedBox(height: 15),
                  _statCard(Icons.directions_car, Colors.green,
                      "Available Vehicles", availableVehicles.toString()),
                  const SizedBox(height: 12),
                  _statCard(Icons.key, Colors.orange,
                      "Vehicles Currently Rented", rentedVehicles.toString()),
                  const SizedBox(height: 12),
                  _statCard(Icons.description, Colors.blue, "Active Contracts",
                      activeContracts.toString()),
                  const SizedBox(height: 12),
                  _statCard(Icons.timer, Colors.red, "Contracts Expiring Today",
                      expiringContracts.toString()),
                  const SizedBox(height: 30),
                  Text("Actions",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700)),
                  const SizedBox(height: 15),
                  _actionButton(
                      icon: Icons.assignment,
                      label: "Contracts",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContactListPage()));
                      }),
                  const SizedBox(height: 20),
                  _actionButton(
                      icon: Icons.bar_chart,
                      label: "Reports",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReportsPage()),
                        );
                      }),
                ],
              ),
            ),
    );
  }
}
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rent_car/Widgets/BaseScaffold.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import 'package:intl/intl.dart';
import "../.env.dart";
import 'package:rent_car/Pages/ReportsListPage.dart';
import 'package:rent_car/Pages/ContractListPage.dart';
import 'package:rent_car/Pages/SearchPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = true;
  int availableVehicles = 0;
  int rentedVehicles = 0;
  int activeContracts = 0;
  int expiringContracts = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }



  Future<void> fetchData() async {
    try {
      String? token = await readToken();
      String? userId = await readClientID();
      final headers = {"Authorization": "Bearer $token"};

      print("🔐 Token: $token");
      print("👤 UserId: $userId");

      final vehiclesRes = await http.get(
        Uri.parse(
            '$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/count-available-vehicles?id_user=$userId'),
        headers: headers,
      );

      final rentedRes = await http.get(
        Uri.parse(
            '$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/count-unavailable-vehicles?id_user=$userId'),
        headers: headers,
      );

      final contractsRes = await http.get(
        Uri.parse(
            '$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/getall-by-user/$userId'),
        headers: headers,
      );

      print(
          "🚗 Available vehicles response: ${vehiclesRes.statusCode} -> ${vehiclesRes.body}");
      print(
          "🔒 Rented vehicles response: ${rentedRes.statusCode} -> ${rentedRes.body}");
      print(
          "📑 Contracts response: ${contractsRes.statusCode} -> ${contractsRes.body}");

      if (vehiclesRes.statusCode == 200 &&
          contractsRes.statusCode == 200 &&
          rentedRes.statusCode == 200) {
        availableVehicles = int.tryParse(vehiclesRes.body) ?? 0;
        rentedVehicles = int.tryParse(rentedRes.body) ?? 0;

        final decoded = jsonDecode(contractsRes.body);
        List contracts = decoded is List ? decoded : (decoded["data"] ?? []);
        print("📋 Total contracts fetched: ${contracts.length}");

        DateTime now = DateTime.now();
        DateTime today = DateTime(now.year, now.month, now.day);

        // --- Utilitaire pour parser dateDebut / dateRetour ---
        DateTime? parseDate(dynamic raw) {
          try {
            if (raw == null) return null;

            if (raw is List && raw.length >= 3) {
              return DateTime(
                raw[0],
                raw[1],
                raw[2],
                raw.length > 3 ? raw[3] : 0,
                raw.length > 4 ? raw[4] : 0,
                raw.length > 5 ? raw[5] : 0,
              );
            } else if (raw is String) {
              return DateTime.tryParse(raw);
            }
          } catch (_) {}
          return null;
        }

        // ===== CONTRATS ACTIFS =====
        activeContracts = contracts.where((c) {
          DateTime? dateDebut = parseDate(c['dateDebut']);
          DateTime? dateRetour = parseDate(c['dateRetour']);

          if (dateDebut == null || dateRetour == null) {
            print("⚪ Skipped contract ${c['numeroContrat']} (missing dates)");
            return false;
          }

          bool isActive =
              (dateDebut.isBefore(now) || dateDebut.isAtSameMomentAs(now)) &&
                  dateRetour.isAfter(now);

          if (isActive) {
            print(
                "✅ Active contract: ${c['numeroContrat']} - From $dateDebut To $dateRetour");
          } else {
            print(
                "❌ Not active: ${c['numeroContrat']} - From $dateDebut To $dateRetour");
          }
          return isActive;
        }).length;

        // ===== CONTRATS EXPIRANT AUJOURD'HUI =====
        expiringContracts = contracts.where((c) {
          DateTime? dateRetour = parseDate(c['dateRetour']);
          if (dateRetour == null) return false;

          DateTime returnDateOnly =
              DateTime(dateRetour.year, dateRetour.month, dateRetour.day);

          bool expiringToday = returnDateOnly.isAtSameMomentAs(today);

          if (expiringToday) {
            print(
                "⏰ CONTRACT EXPIRING TODAY: ${c['numeroContrat']} - Return: $dateRetour");
          }
          return expiringToday;
        }).length;

        print("🎯 FINAL RESULTS:");
        print("   📊 Active Contracts: $activeContracts");
        print("   ⏰ Contracts Expiring Today: $expiringContracts");
        print("   🚗 Available Vehicles: $availableVehicles");
        print("   🔒 Rented Vehicles: $rentedVehicles");
      }

      if (mounted) setState(() => loading = false);
    } catch (e) {
      print("❌ Global Error: $e");
      if (mounted) setState(() => loading = false);
    }
  }

  Widget _statCard(IconData icon, Color iconColor, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, // fond blanc
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(2, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconColor.withOpacity(0.15),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
              child: Text(label,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontFamily: 'PlusJakartaSans'))),
          Text(value,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ],
      ),
    );
  }

  Widget _actionButton(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 22, 105, 238),
              Color(0xFF4D9EF6)
            ], // dégradé bleu
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(2, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 26),
            const SizedBox(width: 15),
            Expanded(
              child: Text(label,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 0,
      title: 'Bienvenue Rent Car Agent',
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Quick Stats",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  const SizedBox(height: 15),
                  _statCard(Icons.directions_car, Colors.green,
                      "Available Vehicles", availableVehicles.toString()),
                  const SizedBox(height: 12),
                  _statCard(Icons.key, Colors.orange,
                      "Vehicles Currently Rented", rentedVehicles.toString()),
                  const SizedBox(height: 12),
                  _statCard(Icons.description, Colors.blue, "Active Contracts",
                      activeContracts.toString()),
                  const SizedBox(height: 12),
                  _statCard(Icons.timer, Colors.red, "Contracts Expiring Today",
                      expiringContracts.toString()),
                  const SizedBox(height: 30),
                  const Text("Actions",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  const SizedBox(height: 15),
                  _actionButton(
                      icon: Icons.assignment,
                      label: "Contracts",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContactListPage()));
                      }),
                  const SizedBox(height: 20),
                  _actionButton(
                      icon: Icons.bar_chart,
                      label: "Reports",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReportsPage()),
                        );
                      }),
                ],
              ),
            ),
    );
  }
}
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rent_car/Widgets/BaseScaffold.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import "../.env.dart";
import 'package:rent_car/Pages/ReportsListPage.dart';
import 'package:rent_car/Pages/ContractListPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = true;
  int availableVehicles = 0;
  int rentedVehicles = 0;
  int activeContracts = 0;
  int expiringContracts = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  DateTime? _parseDate(dynamic raw) {
    try {
      if (raw == null) return null;
      if (raw is List && raw.length >= 3) {
        return DateTime(
          raw[0],
          raw[1],
          raw[2],
          raw.length > 3 ? raw[3] : 0,
          raw.length > 4 ? raw[4] : 0,
          raw.length > 5 ? raw[5] : 0,
        );
      } else if (raw is String) {
        return DateTime.tryParse(raw);
      }
    } catch (e) {
      debugPrint("❌ Date parsing error for $raw: $e");
    }
    return null;
  }

  Future<void> fetchData() async {
    try {
      String? token = await readToken();
      String? userId = await readClientID();
      final headers = {"Authorization": "Bearer $token"};

      final vehiclesRes = await http.get(
        Uri.parse(
            '$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/count-available-vehicles?id_user=$userId'),
        headers: headers,
      );

      final rentedRes = await http.get(
        Uri.parse(
            '$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/count-unavailable-vehicles?id_user=$userId'),
        headers: headers,
      );

      final contractsRes = await http.get(
        Uri.parse(
            '$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/getall-by-user/$userId'),
        headers: headers,
      );

      if (vehiclesRes.statusCode == 200 &&
          contractsRes.statusCode == 200 &&
          rentedRes.statusCode == 200) {
        availableVehicles = int.tryParse(vehiclesRes.body) ?? 0;
        rentedVehicles = int.tryParse(rentedRes.body) ?? 0;

        final decoded = jsonDecode(contractsRes.body);
        List contracts = decoded is List ? decoded : (decoded["data"] ?? []);

        DateTime now = DateTime.now();

        activeContracts = contracts.where((c) {
          DateTime? dateDepart = _parseDate(c['dateDepart']);
          DateTime? dateRetour = _parseDate(c['dateRetour']);
          if (dateDepart == null || dateRetour == null) return false;
          return (dateDepart.isBefore(now) ||
                  dateDepart.isAtSameMomentAs(now)) &&
              dateRetour.isAfter(now);
        }).length;

        expiringContracts = contracts.where((c) {
          DateTime? dateRetour = _parseDate(c['dateRetour']);
          if (dateRetour == null) return false;
          return dateRetour.year == now.year &&
              dateRetour.month == now.month &&
              dateRetour.day == now.day;
        }).length;
      }

      if (mounted) setState(() => loading = false);
    } catch (e) {
      if (mounted) setState(() => loading = false);
    }
  }

  Widget _statCard(IconData icon, Color iconColor, String label, String value) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor, // Utilise la couleur du thème
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(2, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconColor.withOpacity(0.15),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color.fromARGB(255, 22, 105, 238), Color(0xFF4D9EF6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: theme.primaryColor.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(2, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 26),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'PlusJakartaSans'),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseScaffold(
      currentIndex: 0,
      title: 'Bienvenue Rent Car Agent',
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Stats",
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  _statCard(Icons.directions_car, Colors.green,
                      "Available Vehicles", availableVehicles.toString()),
                  const SizedBox(height: 12),
                  _statCard(Icons.key, Colors.orange,
                      "Vehicles Currently Rented", rentedVehicles.toString()),
                  const SizedBox(height: 12),
                  _statCard(Icons.description, Colors.blue, "Active Contracts",
                      activeContracts.toString()),
                  const SizedBox(height: 12),
                  _statCard(Icons.timer, Colors.red, "Contracts Expiring Today",
                      expiringContracts.toString()),
                  const SizedBox(height: 30),
                  Text(
                    "Actions",
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  _actionButton(
                    icon: Icons.assignment,
                    label: "Contracts",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContactListPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _actionButton(
                    icon: Icons.bar_chart,
                    label: "Reports",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReportsPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}


*/
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rent_car/Widgets/BaseScaffold.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import 'package:google_fonts/google_fonts.dart';
import "../.env.dart";
import 'package:rent_car/Pages/ReportsListPage.dart';
import 'package:rent_car/Pages/ContractListPage.dart';
import 'package:rent_car/services/Agent_provider.dart';
import 'package:provider/provider.dart';
import 'package:rent_car/Pages/PdfListPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = true;
  int availableVehicles = 0;
  int rentedVehicles = 0;
  int activeContracts = 0;
  int expiringContracts = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  DateTime? _parseDate(dynamic raw) {
    try {
      if (raw == null) return null;
      if (raw is List && raw.length >= 3) {
        return DateTime(
          raw[0],
          raw[1],
          raw[2],
          raw.length > 3 ? raw[3] : 0,
          raw.length > 4 ? raw[4] : 0,
          raw.length > 5 ? raw[5] : 0,
        );
      } else if (raw is String) {
        return DateTime.tryParse(raw);
      }
    } catch (e) {
      debugPrint("❌ Date parsing error for $raw: $e");
    }
    return null;
  }

  Future<void> fetchData() async {
    try {
      String? token = await readToken();
      String? userId = await readClientID();
      final headers = {"Authorization": "Bearer $token"};

      final vehiclesRes = await http.get(
        Uri.parse(
            '$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/count-available-vehicles?id_user=$userId'),
        headers: headers,
      );

      final rentedRes = await http.get(
        Uri.parse(
            '$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/count-unavailable-vehicles?id_user=$userId'),
        headers: headers,
      );

      final contractsRes = await http.get(
        Uri.parse(
            '$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/getall-by-user/$userId'),
        headers: headers,
      );

      if (vehiclesRes.statusCode == 200 &&
          contractsRes.statusCode == 200 &&
          rentedRes.statusCode == 200) {
        availableVehicles = int.tryParse(vehiclesRes.body) ?? 0;
        rentedVehicles = int.tryParse(rentedRes.body) ?? 0;

        final decoded = jsonDecode(contractsRes.body);
        List contracts = decoded is List ? decoded : (decoded["data"] ?? []);

        DateTime now = DateTime.now();

        activeContracts = contracts.where((c) {
          DateTime? dateDepart = _parseDate(c['dateDepart']);
          DateTime? dateRetour = _parseDate(c['dateRetour']);
          if (dateDepart == null || dateRetour == null) return false;
          return (dateDepart.isBefore(now) ||
                  dateDepart.isAtSameMomentAs(now)) &&
              dateRetour.isAfter(now);
        }).length;

        expiringContracts = contracts.where((c) {
          DateTime? dateRetour = _parseDate(c['dateRetour']);
          if (dateRetour == null) return false;
          return dateRetour.year == now.year &&
              dateRetour.month == now.month &&
              dateRetour.day == now.day;
        }).length;
      }

      if (mounted) setState(() => loading = false);
    } catch (e) {
      if (mounted) setState(() => loading = false);
    }
  }

  Widget _statCard(IconData icon, Color iconColor, String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.08),
            blurRadius: isDark ? 15 : 10,
            offset: const Offset(2, 6),
          ),
        ],
        border: isDark
            ? Border.all(color: Colors.grey.withOpacity(0.2), width: 0.5)
            : null,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconColor.withOpacity(isDark ? 0.25 : 0.15),
            child: Icon(
              icon,
              color: isDark ? iconColor.withOpacity(0.9) : iconColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradientColors = isDark
        ? const [
            Color(0xFF4C1D95),
            Color(0xFF6B46C1)
          ] // deepPurple gradient pour dark
        : const [
            Color(0xFF0060FC),
            Color(0xFF4D9EF6)
          ]; // bleu gradient pour light

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color:
                  (isDark ? Colors.deepPurple : Colors.blue).withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(2, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 26),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final agent = context.watch<AgentProvider>().currentAgent;

    return BaseScaffold(
      currentIndex: 0,
      title: 'Bienvenue ${agent?.name ?? "Agent"}',
      body: loading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Statistiques Rapides",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _statCard(
                    Icons.directions_car,
                    Colors.green,
                    "Véhicules Disponibles",
                    availableVehicles.toString(),
                  ),
                  const SizedBox(height: 12),
                  _statCard(
                    Icons.key,
                    Colors.orange,
                    "Véhicules Actuellement Loués",
                    rentedVehicles.toString(),
                  ),
                  const SizedBox(height: 12),
                  _statCard(
                    Icons.description,
                    isDark ? Colors.lightBlue : Colors.blue,
                    "Contrats Actifs",
                    activeContracts.toString(),
                  ),
                  const SizedBox(height: 12),
                  _statCard(
                    Icons.timer,
                    Colors.red,
                    "Contrats Expirant Aujourd’hui",
                    expiringContracts.toString(),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Opérations",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _actionButton(
                    icon: Icons.assignment,
                    label: "Contracts",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContactListPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _actionButton(
                    icon: Icons.bar_chart,
                    label: "Rapports",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReportsPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _actionButton(
                    icon: Icons.picture_as_pdf,
                    label: "PDFs Contrats",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PdfListPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
