/*import 'package:flutter/material.dart';
import 'package:rent_car/Models/Conducteur.dart';
import 'package:rent_car/Models/Vehicule.dart';
import 'package:rent_car/Widgets/DialogAlert.dart';
import 'package:rent_car/services/Contract_service.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import 'package:searchfield/searchfield.dart';
import 'package:rent_car/Pages/AddPhotoPage.dart';

class MakeContractPage extends StatefulWidget {
  final DateTime depart;
  final DateTime arrival;
  final TimeOfDay time1;
  final TimeOfDay time2;

  const MakeContractPage({
    required this.depart,
    required this.arrival,
    required this.time1,
    required this.time2,
  });

  @override
  _MakeContractPageState createState() => _MakeContractPageState();
}

class _MakeContractPageState extends State<MakeContractPage> {
  List<Conducteur> conductors = [];
  List<Vehicle> vehicles = [];
  Set<String> cond1 = {};
  Set<String> cond2 = {};
  Set<String> veh = {};
  Conducteur? selectedConductor;
  Conducteur? selectedConductor1;
  Vehicle? selectedVehicle;
  final _formKey = GlobalKey<FormState>();
  final timbreF1 = TextEditingController();
  final totalHT1 = TextEditingController();
  final driver1 = TextEditingController();
  final driver2 = TextEditingController();
  final vehicle = TextEditingController();
  String? selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    await loadConducteurs();
    await loadVehicles();

    for (var i = 0; i < conductors.length; i++) {
      cond1.add(
          "${conductors[i].pieceIdentite}-${conductors[i].nom} ${conductors[i].prenom}");
      cond2.add(
          "${conductors[i].pieceIdentite}-${conductors[i].nom} ${conductors[i].prenom}");
    }
    for (var i = 0; i < vehicles.length; i++) {
      veh.add(vehicles[i].matricule);
    }
  }

  @override
  void dispose() {
    timbreF1.dispose();
    totalHT1.dispose();
    driver1.dispose();
    driver2.dispose();
    vehicle.dispose();
    super.dispose();
  }

  Future<void> loadConducteurs() async {
    try {
      String? userID = await readClientID();
      String? token = await readToken();
      List<Conducteur> fetchedConductors =
          await getConducteursByUser(userID!, token!);
      if (mounted) {
        setState(() {
          conductors = fetchedConductors;
          if (conductors.isNotEmpty) {
            selectedConductor = conductors.first;
          }
        });
      }
    } catch (e) {
      print("Error loading conductors: $e");
    }
  }

  Future<void> loadVehicles() async {
    try {
      String? userID = await readClientID();
      String? token = await readToken();
      List<Vehicle> fetchedVehicles =
          await getavailableVehiclesByUser(userID!, token!);
      print("📦 [DEBUG] Résultat de l'API (véhicules) : $fetchedVehicles");
      print("🔢 [DEBUG] Nombre de véhicules reçus : ${fetchedVehicles.length}");
      setState(() {
        vehicles = fetchedVehicles;
        if (vehicles.isNotEmpty) {
          selectedVehicle = vehicles.first;
        }
      });
    } catch (e) {
      print("Error loading vehicles: $e");
    }
  }

  List<String> paymentMethods = [
    'espèces',
    'chèque',
    'carte bancaire',
    'opération bancaire',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30),
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Let\'s Make a Contract',
            style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold)),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: EdgeInsets.only(bottom: 25.0),
            child: Text('Now, let\'s move on to filling out this form',
                style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ),
        centerTitle: true,
        toolbarHeight: 140,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        elevation: 10,
      ),
      body: (conductors.isEmpty && vehicles.isEmpty)
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    label(context, "First Conductor :"),
                    SearchF(
                        context, "First Conductor", driver1, cond1, cond2, veh),
                    const SizedBox(height: 15),
                    label(context, "Second Conductor :"),
                    SearchF(context, "Second Conductor", driver2, cond1, cond2,
                        veh),
                    const SizedBox(height: 15),
                    label(context, "Vehicle :"),
                    SearchF(context, "Vehicle", vehicle, cond1, cond2, veh),
                    const SizedBox(height: 15),
                    label(context, "Payment Method :"),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: selectedPaymentMethod,
                      hint: const Text("Méthode de paiement"),
                      onChanged: (value) =>
                          setState(() => selectedPaymentMethod = value),
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Veuillez choisir un mode de paiement'
                          : null,
                      decoration: inputDecoration(context),
                      items: paymentMethods
                          .map((method) => DropdownMenuItem<String>(
                              value: method, child: Text(method)))
                          .toList(),
                    ),
                    const SizedBox(height: 15),
                    label(context, "Timbre Fiscal :"),
                    buildTextField(context, timbreF1, "Enter TimbreF"),
                    const SizedBox(height: 15),
                    label(context, "TotalHT :"),
                    buildTextField(context, totalHT1, "Enter TotalHT"),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(5),
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              for (var c in conductors) {
                if ("${c.pieceIdentite}-${c.nom} ${c.prenom}" == driver1.text)
                  selectedConductor = c;
                if ("${c.pieceIdentite}-${c.nom} ${c.prenom}" == driver2.text)
                  selectedConductor1 = c;
              }
              selectedVehicle = vehicles.firstWhere(
                  (v) => v.matricule == vehicle.text,
                  orElse: () => selectedVehicle!);
              if (selectedConductor == null || selectedVehicle == null) {
                await showAlert(context,
                    title: "Erreur",
                    message:
                        "Veuillez sélectionner un conducteur et un véhicule.",
                    type: AlertType.error,
                    function: () => Navigator.of(context).pop());
                return;
              }
              DateTime date1 = widget.depart.add(Duration(
                  hours: widget.time1.hour, minutes: widget.time1.minute));
              DateTime date2 = widget.arrival.add(Duration(
                  hours: widget.time2.hour, minutes: widget.time2.minute));
              String contratId = await createContrat(
                selectedVehicle!.id,
                selectedConductor!.id,
                selectedConductor1?.id ?? "",
                date1,
                date2,
                selectedPaymentMethod!,
                double.parse(timbreF1.text),
                double.parse(totalHT1.text),
              );
              if (contratId != "ok" && contratId.isNotEmpty) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddPhotoPage(contractId: contratId)));
              } else {
                await showAlert(context,
                    title: "Erreur",
                    message: "La création du contrat a échoué.",
                    type: AlertType.error,
                    function: () => Navigator.of(context).pop());
              }
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text('Make Contract',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

Widget label(BuildContext context, String text) => Text(text,
    style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary));

InputDecoration inputDecoration(BuildContext context) => InputDecoration(
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(20)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 2),
          borderRadius: BorderRadius.circular(20)),
    );

Widget buildTextField(
        BuildContext context, TextEditingController controller, String hint) =>
    TextFormField(
      keyboardType: TextInputType.number,
      controller: controller,
      validator: (value) =>
          (value == null || value.isEmpty) ? 'Champ requis' : null,
      decoration: inputDecoration(context).copyWith(
          hintText: hint,
          hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.secondary, fontSize: 14)),
    );

Widget SearchF(
  BuildContext context,
  String hint,
  TextEditingController controller,
  Set<String> cond1,
  Set<String> cond2,
  Set<String> veh,
) {
  final Set<String> dataSet = hint == 'First Conductor'
      ? cond1
      : hint == 'Second Conductor'
          ? cond2
          : veh;

  return SearchField<String>(
    controller: controller,
    suggestions: dataSet
        .map(
          (e) => SearchFieldListItem<String>(
            e,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(e, style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ),
        )
        .toList(),
    hint: hint,
    searchInputDecoration: inputDecoration(context).copyWith(
      hintText: hint,
      prefixIcon: hint == 'Vehicle'
          ? Icon(
              Icons.directions_bus_filled_outlined,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
            )
          : Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
            ),
    ),
    itemHeight: 50,
    validator: (value) {
      if (hint != 'Second Conductor' && (value == null || value.isEmpty)) {
        return 'Veuillez sélectionner un $hint';
      }
      return null;
    },
    maxSuggestionsInViewPort: 3,
    suggestionItemDecoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
  );
}*/
import 'package:flutter/material.dart';
import 'package:rent_car/Models/Conducteur.dart';
import 'package:rent_car/Models/Vehicule.dart';
import 'package:rent_car/Widgets/DialogAlert.dart';
import 'package:rent_car/services/Contract_service.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import 'package:searchfield/searchfield.dart';
import 'package:rent_car/Pages/AddPhotoPage.dart';

class MakeContractPage extends StatefulWidget {
  final DateTime depart;
  final DateTime arrival;
  final TimeOfDay time1;
  final TimeOfDay time2;

  const MakeContractPage({
    required this.depart,
    required this.arrival,
    required this.time1,
    required this.time2,
  });

  @override
  _MakeContractPageState createState() => _MakeContractPageState();
}

class _MakeContractPageState extends State<MakeContractPage> {
  List<Conducteur> conductors = [];
  List<Vehicle> vehicles = [];
  Set<String> cond1 = {};
  Set<String> cond2 = {};
  Set<String> veh = {};
  Conducteur? selectedConductor;
  Conducteur? selectedConductor1;
  Vehicle? selectedVehicle;
  final _formKey = GlobalKey<FormState>();
  final timbreF1 = TextEditingController();
  final totalHT1 = TextEditingController();
  final driver1 = TextEditingController();
  final driver2 = TextEditingController();
  final vehicle = TextEditingController();
  String? selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    await loadConducteurs();
    await loadVehicles();

    for (var i = 0; i < conductors.length; i++) {
      cond1.add(
          "${conductors[i].pieceIdentite}-${conductors[i].nom} ${conductors[i].prenom}");
      cond2.add(
          "${conductors[i].pieceIdentite}-${conductors[i].nom} ${conductors[i].prenom}");
    }
    for (var i = 0; i < vehicles.length; i++) {
      veh.add(vehicles[i].matricule);
    }
  }

  @override
  void dispose() {
    timbreF1.dispose();
    totalHT1.dispose();
    driver1.dispose();
    driver2.dispose();
    vehicle.dispose();
    super.dispose();
  }

  Future<void> loadConducteurs() async {
    try {
      String? userID = await readClientID();
      String? token = await readToken();
      List<Conducteur> fetchedConductors =
          await getConducteursByUser(userID!, token!);
      if (mounted) {
        setState(() {
          conductors = fetchedConductors;
          if (conductors.isNotEmpty) {
            selectedConductor = conductors.first;
          }
        });
      }
    } catch (e) {
      print("Error loading conductors: $e");
    }
  }

  Future<void> loadVehicles() async {
    try {
      String? userID = await readClientID();
      String? token = await readToken();
      List<Vehicle> fetchedVehicles =
          await getavailableVehiclesByUser(userID!, token!);
      print("📦 [DEBUG] Résultat de l'API (véhicules) : $fetchedVehicles");
      print("🔢 [DEBUG] Nombre de véhicules reçus : ${fetchedVehicles.length}");
      setState(() {
        vehicles = fetchedVehicles;
        if (vehicles.isNotEmpty) {
          selectedVehicle = vehicles.first;
        }
      });
    } catch (e) {
      print("Error loading vehicles: $e");
    }
  }

  List<String> paymentMethods = [
    'espèces',
    'chèque',
    'carte bancaire',
    'opération bancaire',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        toolbarHeight: 140,
        elevation: 10,
        backgroundColor: Colors.transparent,
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Text(
                'Let\'s Make a Contract',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text(
                'Now, let\'s move on to filling out this form',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              )
            ],
          ),
        ),
      ),
      body: (conductors.isEmpty && vehicles.isEmpty)
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    label(context, "First Conductor :"),
                    SearchF(
                        context, "First Conductor", driver1, cond1, cond2, veh),
                    const SizedBox(height: 15),
                    label(context, "Second Conductor :"),
                    SearchF(context, "Second Conductor", driver2, cond1, cond2,
                        veh),
                    const SizedBox(height: 15),
                    label(context, "Vehicle :"),
                    SearchF(context, "Vehicle", vehicle, cond1, cond2, veh),
                    const SizedBox(height: 15),
                    label(context, "Payment Method :"),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        value: selectedPaymentMethod,
                        hint: Text(
                          "Payment method",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 14,
                          ),
                        ),
                        onChanged: (value) =>
                            setState(() => selectedPaymentMethod = value),
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'Veuillez choisir un mode de paiement'
                            : null,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.payment,
                            color: Theme.of(context).colorScheme.primary,
                            size: 20,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 18, horizontal: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey.shade200),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2,
                            ),
                          ),
                        ),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        items: paymentMethods
                            .map((method) => DropdownMenuItem<String>(
                                value: method,
                                child: Text(
                                  method,
                                  style: const TextStyle(fontSize: 14),
                                )))
                            .toList(),
                        borderRadius: BorderRadius.circular(16),
                        dropdownColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15),
                    label(context, "Timbre Fiscal :"),
                    buildTextField(context, timbreF1, "Enter TimbreF"),
                    const SizedBox(height: 15),
                    label(context, "TotalHT :"),
                    buildTextField(context, totalHT1, "Enter TotalHT"),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(15),
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              for (var c in conductors) {
                if ("${c.pieceIdentite}-${c.nom} ${c.prenom}" == driver1.text)
                  selectedConductor = c;
                if ("${c.pieceIdentite}-${c.nom} ${c.prenom}" == driver2.text)
                  selectedConductor1 = c;
              }
              selectedVehicle = vehicles.firstWhere(
                  (v) => v.matricule == vehicle.text,
                  orElse: () => selectedVehicle!);
              if (selectedConductor == null || selectedVehicle == null) {
                await showAlert(context,
                    title: "Erreur",
                    message:
                        "Veuillez sélectionner un conducteur et un véhicule.",
                    type: AlertType.error,
                    function: () => Navigator.of(context).pop());
                return;
              }
              DateTime date1 = widget.depart.add(Duration(
                  hours: widget.time1.hour, minutes: widget.time1.minute));
              DateTime date2 = widget.arrival.add(Duration(
                  hours: widget.time2.hour, minutes: widget.time2.minute));
              String contratId = await createContrat(
                selectedVehicle!.id,
                selectedConductor!.id,
                selectedConductor1?.id ?? "",
                date1,
                date2,
                selectedPaymentMethod!,
                double.parse(timbreF1.text),
                double.parse(totalHT1.text),
              );
              if (contratId != "ok" && contratId.isNotEmpty) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddPhotoPage(contractId: contratId)));
              } else {
                await showAlert(context,
                    title: "Erreur",
                    message: "La création du contrat a échoué.",
                    type: AlertType.error,
                    function: () => Navigator.of(context).pop());
              }
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0060FC),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.description_outlined),
              SizedBox(width: 8),
              Text(
                'Make Contract',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget label(BuildContext context, String text) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
          letterSpacing: 0.1,
        ),
      ),
    );

// Modern input decoration with subtle shadow
InputDecoration inputDecoration(BuildContext context,
        {String? hint, IconData? icon}) =>
    InputDecoration(
      hintText: hint,
      prefixIcon: icon != null
          ? Icon(
              icon,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
              size: 20,
            )
          : null,
      filled: true,
      fillColor: Colors.grey.shade50,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
      ),
      hintStyle: TextStyle(
        color: Colors.grey.shade500,
        fontSize: 14,
      ),
    );

// Modern text field with container shadow
Widget buildTextField(
        BuildContext context, TextEditingController controller, String hint) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: controller,
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Champ requis' : null,
        decoration: inputDecoration(context, hint: hint),
      ),
    );

// Modern search field with better styling
Widget SearchF(
  BuildContext context,
  String hint,
  TextEditingController controller,
  Set<String> cond1,
  Set<String> cond2,
  Set<String> veh,
) {
  final Set<String> dataSet = hint == 'First Conductor'
      ? cond1
      : hint == 'Second Conductor'
          ? cond2
          : veh;

  final IconData icon = hint == 'Vehicle'
      ? Icons.directions_bus_filled_outlined
      : Icons.person_outline;

  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: SearchField<String>(
      controller: controller,
      suggestions: dataSet
          .map(
            (e) => SearchFieldListItem<String>(
              e,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      size: 18,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        e,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
      hint: hint,
      searchInputDecoration: inputDecoration(context, hint: hint, icon: icon),
      itemHeight: 56,
      validator: (value) {
        if (hint != 'Second Conductor' && (value == null || value.isEmpty)) {
          return 'Veuillez sélectionner un $hint';
        }
        return null;
      },
      maxSuggestionsInViewPort: 4,
      suggestionItemDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    ),
  );
}
