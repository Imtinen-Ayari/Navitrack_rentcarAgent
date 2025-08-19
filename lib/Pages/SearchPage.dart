/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rent_car/Models/Contact.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import "../.env.dart";

class ContratSearchPage extends StatefulWidget {
  const ContratSearchPage({super.key});

  @override
  State<ContratSearchPage> createState() => _ContratSearchPageState();
}

class _ContratSearchPageState extends State<ContratSearchPage> {
  List<Contrat> allContrats = [];
  List<Contrat> filteredContrats = [];

  String searchText = '';
  String selectedFilter = 'Contrat';
  final List<String> filterOptions = ['Contrat', 'Client', 'Véhicule'];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchContrats();
  }

  Future<void> fetchContrats() async {
    try {
      final token = await readToken();
      final userId = await readClientID();

      final response = await http.get(
        Uri.parse(
            "$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/getall-by-user/$userId"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        final contratsFromApi =
            data.map((json) => Contrat.fromJson(json)).toList();

        setState(() {
          allContrats = contratsFromApi.cast<Contrat>();
          filteredContrats = allContrats;
          isLoading = false;
        });
      } else {
        throw Exception("Erreur ${response.statusCode}");
      }
    } catch (e) {
      print("Erreur lors du fetch des contrats: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterContrats() {
    setState(() {
      filteredContrats = allContrats.where((contrat) {
        switch (selectedFilter) {
          case 'Contrat':
            return contrat.numeroContract
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase());
          case 'Client':
            return (contrat.conducteur?.nom ?? '')
                .toLowerCase()
                .contains(searchText.toLowerCase());
          case 'Véhicule':
            return (contrat.vehicule?.marque ?? '')
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                (contrat.vehicule?.model ?? '')
                    .toLowerCase()
                    .contains(searchText.toLowerCase());
          default:
            return true;
        }
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recherche Contrats"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Row TextField + Dropdown
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Rechercher",
                      hintText: "Entrez le texte à rechercher",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    onChanged: (value) {
                      searchText = value;
                      filterContrats();
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButton<String>(
                    value: selectedFilter,
                    items: filterOptions
                        .map((filter) => DropdownMenuItem(
                            value: filter, child: Text(filter)))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedFilter = value;
                          filterContrats();
                        });
                      }
                    },
                    underline: const SizedBox(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Résultats
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredContrats.isEmpty
                      ? const Center(child: Text("Aucun contrat trouvé"))
                      : ListView.separated(
                          itemCount: filteredContrats.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            final contrat = filteredContrats[index];
                            return ListTile(
                              leading: const Icon(Icons.assignment,
                                  color: Colors.teal),
                              title:
                                  Text("Contrat n°${contrat.numeroContract}"),
                              subtitle: Text(
                                "Client: ${contrat.conducteur?.nom ?? 'N/A'}\n"
                                "Véhicule: ${contrat.vehicule?.marque ?? ''} ${contrat.vehicule?.model ?? ''}",
                              ),
                              isThreeLine: true,
                              trailing:
                                  const Icon(Icons.arrow_forward_ios, size: 16),
                              onTap: () {
                                // TODO: Navigation vers détails contrat
                              },
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rent_car/Models/Contact.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import "../.env.dart";
import 'package:rent_car/Widgets/BaseScaffold.dart';

class ContratSearchPage extends StatefulWidget {
  const ContratSearchPage({super.key});

  @override
  State<ContratSearchPage> createState() => _ContratSearchPageState();
}

class _ContratSearchPageState extends State<ContratSearchPage> {
  List<Contrat> allContrats = [];
  List<Contrat> filteredContrats = [];

  String searchText = '';
  String selectedFilter = 'Contrat';
  final List<String> filterOptions = ['Contrat', 'Client', 'Véhicule'];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchContrats();
  }

  Future<void> fetchContrats() async {
    try {
      final token = await readToken();
      final userId = await readClientID();

      final response = await http.get(
        Uri.parse(
            "$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/getall-by-user/$userId"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        final contratsFromApi =
            data.map((json) => Contrat.fromJson(json)).toList();

        setState(() {
          allContrats = contratsFromApi.cast<Contrat>();
          filteredContrats = allContrats;
          isLoading = false;
            bool isSearching = false;
        });
      } else {
        throw Exception("Erreur ${response.statusCode}");
      }
    } catch (e) {
      print("Erreur lors du fetch des contrats: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterContrats() {
    setState(() {
      filteredContrats = allContrats.where((contrat) {
        switch (selectedFilter) {
          case 'Contrat':
            return contrat.numeroContract
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase());
          case 'Client':
            return (contrat.conducteur?.nom ?? '')
                .toLowerCase()
                .contains(searchText.toLowerCase());
          case 'Véhicule':
            return (contrat.vehicule?.marque ?? '')
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                (contrat.vehicule?.model ?? '')
                    .toLowerCase()
                    .contains(searchText.toLowerCase());
          default:
            return true;
        }
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Recherche Contrats",
      currentIndex: 2, // Page Recherche active
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Row TextField + Dropdown
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Rechercher",
                      hintText: "Entrez le texte à rechercher",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    onChanged: (value) {
                      searchText = value;
                      filterContrats();
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButton<String>(
                    value: selectedFilter,
                    items: filterOptions
                        .map((filter) => DropdownMenuItem(
                            value: filter, child: Text(filter)))
                        .toList(),
onChanged: (value) {
  searchText = value;
 // true si l'
  filterContrats();
  setState(() {}); // déclenche le rebuild
},
                    underline: const SizedBox(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Résultats
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredContrats.isEmpty
                      ? const Center(child: Text("Aucun contrat trouvé"))
                      : ListView.separated(
                          itemCount: filteredContrats.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            final contrat = filteredContrats[index];
                            return ListTile(
                              leading: const Icon(Icons.assignment,
                                  color: Color(0xFF0060FC)),
                              title:
                                  Text("Contrat n°${contrat.numeroContract}"),
                              subtitle: Text(
                                "Client: ${contrat.conducteur?.nom ?? 'N/A'}\n"
                                "Véhicule: ${contrat.vehicule?.marque ?? ''} ${contrat.vehicule?.model ?? ''}",
                              ),
                              isThreeLine: true,
                              trailing:
                                  const Icon(Icons.arrow_forward_ios, size: 16),
                              onTap: () {
                                // TODO: Navigation vers détails contrat
                              },
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rent_car/Models/Contact.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import "../.env.dart";
import 'package:rent_car/Widgets/BaseScaffold.dart';

class ContratSearchPage extends StatefulWidget {
  const ContratSearchPage({super.key});

  @override
  State<ContratSearchPage> createState() => _ContratSearchPageState();
}

class _ContratSearchPageState extends State<ContratSearchPage> {
  List<Contrat> allContrats = [];
  List<Contrat> filteredContrats = [];

  String searchText = '';
  String selectedFilter = 'Contrat';
  final List<String> filterOptions = ['Contrat', 'Client', 'Véhicule'];

  bool isLoading = true;
  bool isSearching = false; // <-- suivi de l'état de recherche

  @override
  void initState() {
    super.initState();
    fetchContrats();
  }

  Future<void> fetchContrats() async {
    try {
      final token = await readToken();
      final userId = await readClientID();

      final response = await http.get(
        Uri.parse(
            "$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/getall-by-user/$userId"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        final contratsFromApi =
            data.map((json) => Contrat.fromJson(json)).toList();

        setState(() {
          allContrats = contratsFromApi.cast<Contrat>();
          filteredContrats = allContrats;
          isLoading = false;
        });
      } else {
        throw Exception("Erreur ${response.statusCode}");
      }
    } catch (e) {
      print("Erreur lors du fetch des contrats: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterContrats() {
    setState(() {
      filteredContrats = allContrats.where((contrat) {
        switch (selectedFilter) {
          case 'Contrat':
            return contrat.numeroContract
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase());
          case 'Client':
            return (contrat.conducteur?.nom ?? '')
                .toLowerCase()
                .contains(searchText.toLowerCase());
          case 'Véhicule':
            return (contrat.vehicule?.marque ?? '')
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                (contrat.vehicule?.model ?? '')
                    .toLowerCase()
                    .contains(searchText.toLowerCase());
          default:
            return true;
        }
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Recherche Contrats",
      currentIndex: 1,
      showFab: !isSearching, 
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Row TextField + Dropdown
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Rechercher",
                      hintText: "Entrez le texte à rechercher",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    onChanged: (value) {
                      searchText = value;
                      isSearching = value.isNotEmpty; // <-- mise à jour
                      filterContrats();
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButton<String>(
                    value: selectedFilter,
                    items: filterOptions
                        .map((filter) => DropdownMenuItem(
                            value: filter, child: Text(filter)))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedFilter = value;
                          filterContrats();
                        });
                      }
                    },
                    underline: const SizedBox(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Résultats
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredContrats.isEmpty
                      ? const Center(child: Text("Aucun contrat trouvé"))
                      : ListView.separated(
                          itemCount: filteredContrats.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            final contrat = filteredContrats[index];
                            return ListTile(
                              leading: const Icon(Icons.assignment,
                                  color: Color(0xFF0060FC)),
                              title:
                                  Text("Contrat n°${contrat.numeroContract}"),
                              subtitle: Text(
                                "Client: ${contrat.conducteur?.nom ?? 'N/A'}\n"
                                "Véhicule: ${contrat.vehicule?.marque ?? ''} ${contrat.vehicule?.model ?? ''}",
                              ),
                              isThreeLine: true,
                              trailing:
                                  const Icon(Icons.arrow_forward_ios, size: 16),
                              onTap: () {
                                // TODO: Navigation vers détails contrat
                              },
                            );
                          },
                        ),
            ),
          ],
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
}*/
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rent_car/Models/Contact.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import "../.env.dart";
import 'package:rent_car/Widgets/BaseScaffold.dart';
import 'package:rent_car/Pages/ContractDetails.dart';

class ContratSearchPage extends StatefulWidget {
  const ContratSearchPage({super.key});

  @override
  State<ContratSearchPage> createState() => _ContratSearchPageState();
}

class _ContratSearchPageState extends State<ContratSearchPage> {
  bool isSearching = false; // 👈 suivi état recherche

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Recherche Contrats",
      currentIndex: 1,
      showFab: !isSearching, // 👈 FAB caché si recherche en cours
      body: ContratSearchPageContent(
        onSearchFocus: () => setState(() => isSearching = true),
        onSearchUnfocus: () => setState(() => isSearching = false),
      ),
    );
  }
}

class ContratSearchPageContent extends StatefulWidget {
  final VoidCallback onSearchFocus;
  final VoidCallback onSearchUnfocus;

  const ContratSearchPageContent({
    super.key,
    required this.onSearchFocus,
    required this.onSearchUnfocus,
  });

  @override
  State<ContratSearchPageContent> createState() =>
      _ContratSearchPageContentState();
}

class _ContratSearchPageContentState extends State<ContratSearchPageContent> {
  List<Contrat> allContrats = [];
  List<Contrat> filteredContrats = [];

  String searchText = '';
  String selectedFilter = 'Contrat';
  final List<String> filterOptions = ['Contrat', 'Client', 'Véhicule'];

  bool isLoading = true;

  final FocusNode _searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    fetchContrats();

    // écoute focus
    _searchFocus.addListener(() {
      if (_searchFocus.hasFocus) {
        widget.onSearchFocus();
      } else {
        widget.onSearchUnfocus();
      }
    });
  }

  @override
  void dispose() {
    _searchFocus.dispose();
    super.dispose();
  }

  Future<void> fetchContrats() async {
    try {
      final token = await readToken();
      final userId = await readClientID();

      final response = await http.get(
        Uri.parse(
            "$apiUrl/api/cubeIT/NaviTrack/rest/contrat-location/getall-by-user/$userId"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        final contratsFromApi =
            data.map((json) => Contrat.fromJson(json)).toList();

        setState(() {
          allContrats = contratsFromApi.cast<Contrat>();
          filteredContrats = allContrats;
          isLoading = false;
        });
      } else {
        throw Exception("Erreur ${response.statusCode}");
      }
    } catch (e) {
      print("Erreur lors du fetch des contrats: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterContrats() {
    setState(() {
      filteredContrats = allContrats.where((contrat) {
        switch (selectedFilter) {
          case 'Contrat':
            return contrat.numeroContract
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase());
          case 'Client':
            return (contrat.conducteur?.nom ?? '')
                .toLowerCase()
                .contains(searchText.toLowerCase());
          case 'Véhicule':
            return (contrat.vehicule?.marque ?? '')
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                (contrat.vehicule?.model ?? '')
                    .toLowerCase()
                    .contains(searchText.toLowerCase());
          default:
            return true;
        }
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          // Row TextField + Dropdown
          Row(
            children: [
              Expanded(
                child: TextField(
                  focusNode: _searchFocus,
                  decoration: InputDecoration(
                    labelText: "Rechercher",
                    hintText: "Entrez le texte à rechercher",
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF0060FC), // 👈 toujours bleu
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  onChanged: (value) {
                    searchText = value;
                    filterContrats();
                  },
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButton<String>(
                  value: selectedFilter,
                  items: filterOptions
                      .map((filter) =>
                          DropdownMenuItem(value: filter, child: Text(filter)))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedFilter = value;
                        filterContrats();
                      });
                    }
                  },
                  underline: const SizedBox(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Résultats
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredContrats.isEmpty
                    ? const Center(child: Text("Aucun contrat trouvé"))
                    : ListView.separated(
                        itemCount: filteredContrats.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          final contrat = filteredContrats[index];
                          return ListTile(
                            leading: const Icon(Icons.assignment,
                                color: Color(0xFF0060FC)),
                            title: Text("Contrat n°${contrat.numeroContract}"),
                            subtitle: Text(
                              "Client: ${contrat.conducteur?.nom ?? 'N/A'}\n"
                              "Véhicule: ${contrat.vehicule?.marque ?? ''} ${contrat.vehicule?.model ?? ''}",
                            ),
                            isThreeLine: true,
                            trailing:
                                const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ContratDetailsPage(contrat: contrat),
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
