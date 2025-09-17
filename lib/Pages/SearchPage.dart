/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rent_car/Models/Contact.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import "../.env.dart";
import 'package:rent_car/Widgets/BaseScaffold.dart';
import 'package:rent_car/Pages/ContractDetails.dart';
import 'package:google_fonts/google_fonts.dart';

class ContratSearchPage extends StatefulWidget {
  const ContratSearchPage({super.key});

  @override
  State<ContratSearchPage> createState() => _ContratSearchPageState();
}

class _ContratSearchPageState extends State<ContratSearchPage> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Recherche Contrats",
      currentIndex: 1,
      showFab: !isSearching,
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
  String selectedFilter = 'Contract number';
  final List<String> filterOptions = ['Contract number', 'Client', 'Vehicle'];

  bool isLoading = true;

  final FocusNode _searchFocus = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchContrats();

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
    _searchController.dispose();
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
          case 'Contract number':
            return contrat.numeroContract
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase());
          case 'Client':
            return (contrat.conducteur?.nom ?? '')
                .toLowerCase()
                .contains(searchText.toLowerCase());
          case 'Vehicle':
            return (contrat.vehicule?.matricule ?? '')
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildSearchCard(context),
          _buildFilterCard(context),
          if (searchText.isNotEmpty) _buildResultsCard(context),
          _buildContractsListCard(context),
        ],
      ),
    );
  }

  Widget _buildSearchCard(BuildContext context) {
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
                    Icons.search,
                    color: isDark ? Colors.blue[300] : Colors.blue[700],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Rechercher un Contrat',
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
            TextField(
              controller: _searchController,
              focusNode: _searchFocus,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white : Colors.black87,
              ),
              decoration: InputDecoration(
                labelText: 'Rechercher...',
                labelStyle: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white70 : Colors.grey[600],
                ),
                prefixIcon: Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.blue.withOpacity(0.2)
                        : Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.search,
                    color: isDark ? Colors.blue[300] : Colors.blue[700],
                    size: 20,
                  ),
                ),
                suffixIcon: searchText.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: isDark ? Colors.white70 : Colors.grey[600],
                        ),
                        onPressed: () {
                          setState(() {
                            searchText = '';
                            _searchController.clear();
                            filteredContrats = allContrats;
                          });
                          _searchFocus.unfocus();
                        },
                      )
                    : null,
                filled: true,
                fillColor: isDark
                    ? Colors.grey[900]?.withOpacity(0.5)
                    : Colors.grey[50],
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: isDark
                      ? BorderSide(
                          color: Colors.grey.withOpacity(0.3), width: 1)
                      : BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isDark ? Colors.deepPurple[400]! : Colors.blue,
                    width: 2,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
                filterContrats();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterCard(BuildContext context) {
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
                        ? Colors.orange.withOpacity(0.2)
                        : Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.filter_list,
                    color: isDark ? Colors.orange[300] : Colors.orange[700],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Filtres de Recherche',
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
            Text(
              'Rechercher par',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white70 : Colors.grey[700],
              ),
            ),
            const SizedBox(height: 12),
            ...filterOptions
                .map((filter) => _buildFilterOption(context, filter))
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption(BuildContext context, String filter) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = selectedFilter == filter;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? (isDark
                ? Colors.blue.withOpacity(0.2)
                : Colors.blue.withOpacity(0.1))
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isSelected
            ? Border.all(
                color: isDark ? Colors.blue[300]! : Colors.blue,
                width: 1,
              )
            : null,
      ),
      child: RadioListTile<String>(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(
          filter,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected
                ? (isDark ? Colors.blue[300] : Colors.blue[700])
                : (isDark ? Colors.white : Colors.black87),
          ),
        ),
        value: filter,
        groupValue: selectedFilter,
        activeColor: isDark ? Colors.blue[300] : Colors.blue,
        onChanged: (String? value) {
          if (value != null) {
            setState(() {
              selectedFilter = value;
            });
            filterContrats();
          }
        },
      ),
    );
  }

  Widget _buildResultsCard(BuildContext context) {
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
        child: Row(
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
                Icons.analytics,
                color: isDark ? Colors.green[300] : Colors.green[700],
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Résultats de Recherche',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${filteredContrats.length} contrat(s) trouvé(s)',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: isDark ? Colors.white70 : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContractsListCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isLoading) {
      return Card(
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
        child: Container(
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Colors.blue,
                ),
                const SizedBox(height: 16),
                Text(
                  'Chargement des contrats...',
                  style: GoogleFonts.plusJakartaSans(
                    color: isDark ? Colors.white70 : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (filteredContrats.isEmpty) {
      return Card(
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
        child: Container(
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  searchText.isEmpty ? Icons.search : Icons.search_off,
                  size: 64,
                  color: isDark ? Colors.white54 : Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  searchText.isEmpty
                      ? "Commencez à taper pour rechercher"
                      : "Aucun contrat trouvé",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  searchText.isEmpty
                      ? "Utilisez les filtres pour affiner votre recherche"
                      : "Essayez avec d'autres mots-clés",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    color: isDark ? Colors.white70 : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

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
                        ? Colors.purple.withOpacity(0.2)
                        : Colors.purple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.assignment,
                    color: isDark ? Colors.purple[300] : Colors.purple[700],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Liste des Contrats',
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

            // Liste des contrats
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredContrats.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final contrat = filteredContrats[index];
                return _buildContractItem(context, contrat);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContractItem(BuildContext context, Contrat contrat) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900]?.withOpacity(0.5) : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: isDark ? Border.all(color: Colors.grey.withOpacity(0.2)) : null,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.blue.withOpacity(0.2)
                : Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.description,
            color: isDark ? Colors.blue[300] : Colors.blue[700],
            size: 24,
          ),
        ),
        title: Text(
          "Contrat N°${contrat.numeroContract}",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubtitleRow(
                context,
                'Client',
                contrat.conducteur?.nom ?? 'N/A',
              ),
              const SizedBox(height: 4),
              _buildSubtitleRow(
                context,
                'Véhicule',
                '${contrat.vehicule?.matricule ?? ''}',
              ),
              const SizedBox(height: 4),
              _buildSubtitleRow(
                context,
                'Total',
                '${contrat.totalTTc.toString()} DT',
              ),
            ],
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: isDark ? Colors.white54 : Colors.grey[600],
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ContratDetailsPage(contrat: contrat),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubtitleRow(BuildContext context, String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white70 : Colors.grey[700],
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
*/
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:rent_car/Models/Contact.dart';
import 'package:rent_car/Pages/ContractDetails.dart';
import 'package:rent_car/Widgets/BaseScaffold.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import "../.env.dart";

class ContratSearchPage extends StatefulWidget {
  const ContratSearchPage({super.key});

  @override
  State<ContratSearchPage> createState() => _ContratSearchPageState();
}

class _ContratSearchPageState extends State<ContratSearchPage> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Recherche Contrats",
      currentIndex: 1,
      showFab: !isSearching,
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
  List<String> searchSuggestions = [];

  String searchText = '';
  String selectedFilter = 'Contract number';
  final List<String> filterOptions = ['Contract number', 'Client', 'Vehicle'];

  bool isLoading = true;
  bool showSuggestions = false;
  Timer? _debounceTimer;

  final FocusNode _searchFocus = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    fetchContrats();

    _searchFocus.addListener(() {
      if (_searchFocus.hasFocus) {
        widget.onSearchFocus();
        setState(() {
          showSuggestions = searchText.isNotEmpty;
        });
      } else {
        widget.onSearchUnfocus();
        Future.delayed(const Duration(milliseconds: 150), () {
          if (mounted) setState(() => showSuggestions = false);
        });
      }
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchFocus.dispose();
    _searchController.dispose();
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

  void _onSearchChanged(String value) {
    setState(() {
      searchText = value;
    });

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        filterContrats();
        generateSuggestions();
      }
    });

    setState(() {
      showSuggestions = value.isNotEmpty && _searchFocus.hasFocus;
    });
  }

  String getSearchValue(Contrat contrat) {
    switch (selectedFilter) {
      case 'Contract number':
        return contrat.numeroContract.toString();
      case 'Client':
        return contrat.conducteur?.nom ?? '';
      case 'Vehicle':
        return contrat.vehicule?.matricule ?? '';
      default:
        return '';
    }
  }

  void filterContrats() {
    setState(() {
      filteredContrats = allContrats.where((contrat) {
        return getSearchValue(contrat)
            .toLowerCase()
            .contains(searchText.toLowerCase());
      }).toList();
    });
  }

  void generateSuggestions() {
    if (searchText.isEmpty) {
      setState(() => searchSuggestions = []);
      return;
    }

    final Set<String> suggestions = {};
    for (var contrat in allContrats) {
      final value = getSearchValue(contrat);
      if (value.toLowerCase().contains(searchText.toLowerCase())) {
        suggestions.add(value);
      }
    }

    setState(() {
      searchSuggestions = suggestions.take(5).toList();
    });
  }

  void _selectSuggestion(String suggestion) {
    setState(() {
      searchText = suggestion;
      _searchController.text = suggestion;
      showSuggestions = false;
    });
    _searchFocus.unfocus();
    filterContrats();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        Column(
          children: [
            // Header avec recherche
            Container(
              color: isDark ? Colors.grey[900] : Colors.grey[50],
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CompositedTransformTarget(
                    link: _layerLink,
                    child: _buildSearchField(),
                  ),
                  const SizedBox(height: 12),
                  _buildFilterDropdown(),
                ],
              ),
            ),

            // Résultats
            if (searchText.isNotEmpty && !showSuggestions)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: isDark ? Colors.grey[800] : Colors.blue[50],
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: isDark ? Colors.blue[300] : Colors.blue[700],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${filteredContrats.length} contrat(s) trouvé(s)',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.blue[300] : Colors.blue[700],
                      ),
                    ),
                  ],
                ),
              ),

            // Liste des contrats
            Expanded(
              child: _buildContractsList(),
            ),
          ],
        ),

        // Overlay des suggestions
        if (showSuggestions && searchSuggestions.isNotEmpty)
          _buildSuggestionsOverlay(),
      ],
    );
  }

  Widget _buildSearchField() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        focusNode: _searchFocus,
        style: GoogleFonts.inter(
          fontSize: 16,
          color: isDark ? Colors.white : Colors.black87,
        ),
        decoration: InputDecoration(
          hintText: 'Rechercher un contrat...',
          hintStyle: GoogleFonts.inter(
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
          prefixIcon: Icon(
            Icons.search,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
          suffixIcon: searchText.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                  onPressed: () {
                    setState(() {
                      searchText = '';
                      _searchController.clear();
                      filteredContrats = allContrats;
                      showSuggestions = false;
                    });
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: isDark ? Colors.grey[800] : Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        onChanged: _onSearchChanged,
      ),
    );
  }

  Widget _buildFilterDropdown() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Text(
          'Rechercher par: ',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.grey[300] : Colors.grey[700],
          ),
        ),
        const SizedBox(width: 8),
        DropdownButton<String>(
          value: selectedFilter,
          dropdownColor: isDark ? Colors.grey[800] : Colors.white,
          items: filterOptions.map((filter) {
            return DropdownMenuItem<String>(
              value: filter,
              child: Text(
                filter,
                style: GoogleFonts.inter(
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                selectedFilter = value;
              });
              if (searchText.isNotEmpty) {
                filterContrats();
                generateSuggestions();
              }
            }
          },
        ),
      ],
    );
  }

  Widget _buildSuggestionsOverlay() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CompositedTransformFollower(
      link: _layerLink,
      showWhenUnlinked: false,
      offset: const Offset(0, 64),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[800] : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: searchSuggestions.length,
          separatorBuilder: (_, __) => Divider(
            height: 1,
            color: isDark ? Colors.grey[700] : Colors.grey[300],
          ),
          itemBuilder: (context, index) {
            final suggestion = searchSuggestions[index];
            return ListTile(
              dense: true,
              leading: Icon(
                Icons.search,
                size: 18,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
              title: Text(
                suggestion,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              onTap: () => _selectSuggestion(suggestion),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContractsList() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (filteredContrats.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              searchText.isEmpty ? Icons.search : Icons.search_off,
              size: 64,
              color: isDark ? Colors.grey[600] : Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              searchText.isEmpty
                  ? "Rechercher un contrat"
                  : "Aucun contrat trouvé",
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.grey[300] : Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              searchText.isEmpty
                  ? "Utilisez la barre de recherche ci-dessus"
                  : "Essayez avec d'autres mots-clés",
              style: GoogleFonts.inter(
                fontSize: 14,
                color: isDark ? Colors.grey[500] : Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: filteredContrats.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final contrat = filteredContrats[index];
        return _buildContractItem(contrat);
      },
    );
  }

  Widget _buildContractItem(Contrat contrat) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: isDark ? 2 : 1,
      color: isDark ? Colors.grey[800] : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDark ? Colors.blue[900] : Colors.blue[50],
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            Icons.description,
            color: isDark ? Colors.blue[300] : Colors.blue[700],
            size: 20,
          ),
        ),
        title: Text(
          "Contrat N°${contrat.numeroContract}",
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 16,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                  const SizedBox(width: 6),
                  Text(
                    contrat.conducteur?.nom ?? 'N/A',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: isDark ? Colors.grey[300] : Colors.grey[700],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.directions_car_outlined,
                    size: 16,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                  const SizedBox(width: 6),
                  Text(
                    contrat.vehicule?.matricule ?? 'N/A',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: isDark ? Colors.grey[300] : Colors.grey[700],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.monetization_on_outlined,
                    size: 16,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${contrat.totalTTc.toString()} DT',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.green[300] : Colors.green[700],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: isDark ? Colors.grey[500] : Colors.grey[600],
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ContratDetailsPage(contrat: contrat),
            ),
          );
        },
      ),
    );
  }
}
