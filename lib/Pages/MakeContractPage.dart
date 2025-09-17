import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:rent_car/Models/Conducteur.dart';
import 'package:rent_car/Models/Vehicule.dart';
import 'package:rent_car/Widgets/DialogAlert.dart';
import 'package:rent_car/services/Contract_service.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import 'package:rent_car/Pages/AddPhotoPage.dart';
import 'package:rent_car/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:signature/signature.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class MakeContractPage extends StatefulWidget {
  final DateTime depart;
  final DateTime arrival;
  final TimeOfDay time1;
  final TimeOfDay time2;

  const MakeContractPage({
    Key? key,
    required this.depart,
    required this.arrival,
    required this.time1,
    required this.time2,
  }) : super(key: key);

  @override
  _MakeContractPageState createState() => _MakeContractPageState();
}

class _MakeContractPageState extends State<MakeContractPage> {
  List<Conducteur> conductors = [];
  List<Vehicle> vehicles = [];
  List<Vehicle> vehiclesAfterCreation = [];

  Conducteur? selectedConductor1;
  Conducteur? selectedConductor2;
  Vehicle? selectedVehicle;

  final _formKey = GlobalKey<FormState>();
  final timbreFController = TextEditingController();
  final totalHTController = TextEditingController();
  final tvaController = TextEditingController();

  String? selectedPaymentMethod;
  bool isLoading = true;
  bool isSubmitting = false;
  bool showVehiclesAfterCreation = false;
  bool isMobileIssueDetected = false;

  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    print("🚀 MakeContractPage initState called");
    print("📱 Platform: ${Platform.operatingSystem}");
    print("📅 Depart: ${widget.depart}, Time1: ${widget.time1}");
    print("📅 Arrival: ${widget.arrival}, Time2: ${widget.time2}");

    // Initialize default values
    tvaController.text = '0';
    _loadData();
    _checkMobileSpecificIssues();
  }

  Future<void> _loadData() async {
    print("📦 Loading data started...");
    setState(() => isLoading = true);

    try {
      await Future.wait([
        _loadConducteurs(),
        _loadVehicles(),
      ]);

      print("✅ Data loaded successfully");
      print("👥 Conductors count: ${conductors.length}");
      print("🚗 Vehicles count: ${vehicles.length}");
    } catch (e) {
      print("❌ Error loading data: $e");
      if (mounted) {
        await showAlert(
          context,
          title: "Erreur",
          message: "Erreur lors du chargement des données: $e",
          type: AlertType.error,
          function: () => Navigator.of(context).pop(),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
        print("📦 Loading data completed");
      }
    }
  }

  Future<void> _showPDFConfirmationDialog(String contratId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return AlertDialog(
          backgroundColor: isDark ? Colors.grey[800] : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                Icons.picture_as_pdf,
                color: Colors.red,
                size: 24,
              ),
              SizedBox(width: 12),
              Text(
                'Génération du PDF',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Votre contrat a été créé avec succès !',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Souhaitez-vous générer le document PDF maintenant ?',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[700] : Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isDark ? Colors.grey[600]! : Colors.blue[200]!,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 16,
                          color: isDark ? Colors.blue[300] : Colors.blue[600],
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Le PDF contiendra :',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.blue[300] : Colors.blue[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Informations du contrat\n'
                      '• Détails du véhicule et conducteur(s)\n'
                      '• Montants et signature\n'
                      '• Document officiel pour vos archives',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: isDark ? Colors.white70 : Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Note : Le PDF sera sauvegardé sur votre appareil et ouvert automatiquement.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                _navigateToPhotoPage(contratId);
              },
              child: Text(
                'Plus tard',
                style: GoogleFonts.plusJakartaSans(
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                Navigator.of(context).pop();

                await _generateAndSavePDF(contratId);
                _navigateToPhotoPage(contratId);
              },
              icon: Icon(Icons.picture_as_pdf, size: 18),
              label: Text(
                'Générer PDF',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateToPhotoPage(String contratId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPhotoPage(contractId: contratId),
      ),
    );
  }

  @override
  void dispose() {
    print("♻️ MakeContractPage disposed");
    timbreFController.dispose();
    totalHTController.dispose();
    tvaController.dispose();
    super.dispose();
  }

  Future<void> _loadConducteurs() async {
    print("👥 Loading conductors...");
    try {
      String? userID = await readClientID();
      String? token = await readToken();

      print("🔑 User ID: $userID");
      print("🔑 Token: ${token != null ? 'Present' : 'Null'}");

      if (userID == null || token == null) {
        throw Exception('User ID ou token manquant');
      }

      List<Conducteur> fetchedConductors =
          await getConducteursByUser(userID, token);

      print("✅ Conductors loaded: ${fetchedConductors.length}");

      if (mounted) {
        setState(() {
          conductors = fetchedConductors;
        });
      }
    } catch (e) {
      print("❌ Error loading conductors: $e");
      rethrow;
    }
  }

  Future<void> _loadVehicles() async {
    print("🚗 Loading vehicles...");
    try {
      String? userID = await readClientID();
      String? token = await readToken();

      if (userID == null || token == null) {
        throw Exception('User ID ou token manquant');
      }

      List<Vehicle> fetchedVehicles =
          await getavailableVehiclesByUser(userID, token);

      print("✅ Vehicles loaded: ${fetchedVehicles.length}");
      _logVehicleList(fetchedVehicles, "INITIAL");

      if (mounted) {
        setState(() {
          vehicles = fetchedVehicles;
        });
      }
    } catch (e) {
      print("❌ Error loading vehicles: $e");
      rethrow;
    }
  }

  Future<void> _loadVehiclesAfterContract() async {
    print("🔄 Loading vehicles after contract creation...");
    try {
      String? userID = await readClientID();
      String? token = await readToken();

      if (userID == null || token == null) {
        throw Exception('User ID ou token manquant');
      }

      String cacheBuster = 't=${DateTime.now().millisecondsSinceEpoch}';

      print("📱 Cache buster for mobile: $cacheBuster");

      List<Vehicle> fetchedVehicles = await getavailableVehiclesByUser(
          userID, token,
          cacheBuster: cacheBuster);

      print("✅ Vehicles after contract: ${fetchedVehicles.length}");
      _logVehicleList(fetchedVehicles, "AFTER CONTRACT - MOBILE");

      if (selectedVehicle != null) {
        bool isStillAvailable =
            fetchedVehicles.any((v) => v.id == selectedVehicle!.id);
        if (isStillAvailable) {
          print("📱❌ MOBILE ISSUE DETECTED: Vehicle still available!");
          setState(() {
            isMobileIssueDetected = true;
          });
        }
      }

      if (mounted) {
        setState(() {
          vehiclesAfterCreation = fetchedVehicles;
          showVehiclesAfterCreation = true;
        });
      }
    } catch (e) {
      print("❌ Error loading vehicles after contract: $e");
    }
  }

  void _logVehicleList(List<Vehicle> vehicles, String context) {
    print("📋 VEHICLE LIST ($context):");
    if (vehicles.isEmpty) {
      print("   ⚠️ No vehicles available");
      return;
    }

    for (var vehicle in vehicles) {
      print(
          "   🚗 ${vehicle.matricule} (${vehicle.marque} ${vehicle.model}) - ID: ${vehicle.id}");
    }

    if (selectedVehicle != null) {
      bool isStillAvailable = vehicles.any((v) => v.id == selectedVehicle!.id);
      print(
          "   📊 Selected vehicle '${selectedVehicle!.matricule}' available: $isStillAvailable");

      if (isStillAvailable && context.contains("AFTER")) {
        print(
            "   🚨 ALERTE: Le véhicule devrait être marqué comme indisponible!");
      }
    }
  }

  void _checkMobileSpecificIssues() {
    print("📱 DIAGNOSTIC MOBILE SPÉCIFIQUE:");
    print("   - Platform: ${Platform.operatingSystem}");
    print("   - OS Version: ${Platform.operatingSystemVersion}");
    print("   - Network: ${DateTime.now()}");

    Connectivity().checkConnectivity().then((result) {
      print("   - Connectivity: $result");
    });

    print("   - Timezone: ${DateTime.now().timeZoneOffset}");
    print("   - Local time: ${DateTime.now()}");
    print("   - UTC time: ${DateTime.now().toUtc()}");
  }

  Future<void> _checkTimeSyncIssue() async {
    print("⏰ VÉRIFICATION SYNCHRONISATION TEMPS MOBILE:");

    try {
      DateTime mobileTime = DateTime.now();
      print("   - Mobile time: $mobileTime");

      final response = await http.get(
        Uri.parse('http://197.14.56.128:8080/api/time'),
        headers: {'Cache-Control': 'no-cache'},
      ).timeout(Duration(seconds: 5));

      if (response.statusCode == 200) {
        DateTime serverTime = DateTime.parse(response.body);
        print("   - Server time: $serverTime");
        print("   - Time difference: ${serverTime.difference(mobileTime)}");
      }
    } catch (e) {
      print("   - Cannot get server time: $e");
    }
  }

  String? _validateNumericField(String? value, String fieldName,
      {bool required = true}) {
    if (value == null || value.isEmpty) {
      return required ? 'Champ requis' : null;
    }

    if (double.tryParse(value) == null) {
      return 'Veuillez entrer un nombre valide';
    }

    if (double.parse(value) < 0) {
      return '$fieldName ne peut pas être négatif';
    }

    return null;
  }

  Future<void> _generateAndSavePDF(String contratId) async {
    try {
      if (_signatureController.isEmpty) {
        await showAlert(
          context,
          title: "Erreur",
          message: "Veuillez dessiner la signature avant de générer le PDF.",
          type: AlertType.error,
          function: () => Navigator.of(context).pop(),
        );
        return;
      }

      final Uint8List? signatureBytes = await _signatureController.toPngBytes();

      if (signatureBytes == null) {
        await showAlert(
          context,
          title: "Erreur",
          message: "Erreur lors de la conversion de la signature.",
          type: AlertType.error,
          function: () => Navigator.of(context).pop(),
        );
        return;
      }

      PdfDocument document = PdfDocument();
      PdfPage page = document.pages.add();
      PdfGraphics graphics = page.graphics;

      PdfColor primaryBlue = PdfColor(37, 99, 235);
      PdfColor darkGray = PdfColor(55, 65, 81);
      PdfColor lightGray = PdfColor(243, 244, 246);
      PdfColor successGreen = PdfColor(16, 185, 129);

      PdfFont titleFont = PdfStandardFont(PdfFontFamily.helvetica, 24,
          style: PdfFontStyle.bold);
      PdfFont sectionFont = PdfStandardFont(PdfFontFamily.helvetica, 14,
          style: PdfFontStyle.bold);
      PdfFont bodyFont = PdfStandardFont(PdfFontFamily.helvetica, 11);
      PdfFont smallFont = PdfStandardFont(PdfFontFamily.helvetica, 9);

      double pageWidth = page.size.width;
      double pageHeight = page.size.height;
      double margin = 50;

      graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageWidth, 80),
        brush: PdfSolidBrush(primaryBlue),
      );

      graphics.drawString(
        'CONTRAT DE LOCATION',
        titleFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(margin, 25, pageWidth - 100, 30),
        format: PdfStringFormat(alignment: PdfTextAlignment.center),
      );
      double yPos = 120;

      graphics.drawString(
        'N° $contratId',
        bodyFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(pageWidth - 200, 55, 150, 20),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
      );

      // === DATE ===
      graphics.drawString(
        'Date: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
        bodyFont,
        brush: PdfSolidBrush(darkGray),
        bounds: Rect.fromLTWH(margin, yPos, 200, 15),
      );

      yPos += 40;

      _drawSimpleSection(graphics, 'CLIENT', yPos, margin, pageWidth,
          primaryBlue, sectionFont);
      yPos += 30;

      graphics.drawRectangle(
        bounds: Rect.fromLTWH(margin, yPos, pageWidth - 100, 50),
        brush: PdfSolidBrush(lightGray),
        pen: PdfPen(PdfColor(209, 213, 219), width: 1),
      );

      graphics.drawString(
        'Nom: ${selectedConductor1?.nom ?? ''} ${selectedConductor1?.prenom ?? ''}',
        bodyFont,
        brush: PdfSolidBrush(darkGray),
        bounds: Rect.fromLTWH(margin + 15, yPos + 18, pageWidth - 130, 15),
      );

      yPos += 80;

      _drawSimpleSection(graphics, 'VÉHICULE', yPos, margin, pageWidth,
          primaryBlue, sectionFont);
      yPos += 30;

      graphics.drawRectangle(
        bounds: Rect.fromLTWH(margin, yPos, pageWidth - 100, 80),
        brush: PdfSolidBrush(lightGray),
        pen: PdfPen(PdfColor(209, 213, 219), width: 1),
      );

      yPos += 15;
      graphics.drawString(
        'Marque/Modèle: ${selectedVehicle?.marque ?? ''} ${selectedVehicle?.model ?? ''}',
        bodyFont,
        brush: PdfSolidBrush(darkGray),
        bounds: Rect.fromLTWH(margin + 15, yPos, pageWidth - 130, 15),
      );

      yPos += 20;
      graphics.drawString(
        'Matricule: ${selectedVehicle?.matricule ?? ''}',
        bodyFont,
        brush: PdfSolidBrush(darkGray),
        bounds: Rect.fromLTWH(margin + 15, yPos, pageWidth - 130, 15),
      );

      yPos += 50;

      _drawSimpleSection(graphics, 'MONTANTS', yPos, margin, pageWidth,
          primaryBlue, sectionFont);
      yPos += 30;

      List<Map<String, String>> amounts = [
        {'label': 'Total HT', 'value': '${totalHTController.text} DT'},
        {'label': 'TVA', 'value': '${tvaController.text} DT'},
        {'label': 'Timbre Fiscal', 'value': '${timbreFController.text} DT'},
      ];

      for (int i = 0; i < amounts.length; i++) {
        PdfColor bgColor = i % 2 == 0 ? PdfColor(255, 255, 255) : lightGray;

        graphics.drawRectangle(
          bounds: Rect.fromLTWH(margin, yPos, pageWidth - 100, 25),
          brush: PdfSolidBrush(bgColor),
          pen: PdfPen(PdfColor(209, 213, 219), width: 0.5),
        );

        graphics.drawString(
          amounts[i]['label']!,
          bodyFont,
          brush: PdfSolidBrush(darkGray),
          bounds: Rect.fromLTWH(margin + 15, yPos + 8, 200, 15),
        );

        graphics.drawString(
          amounts[i]['value']!,
          bodyFont,
          brush: PdfSolidBrush(darkGray),
          bounds: Rect.fromLTWH(pageWidth - 200, yPos + 8, 100, 15),
          format: PdfStringFormat(alignment: PdfTextAlignment.right),
        );

        yPos += 25;
      }

      graphics.drawRectangle(
        bounds: Rect.fromLTWH(margin, yPos, pageWidth - 100, 30),
        brush: PdfSolidBrush(primaryBlue),
      );

      graphics.drawString(
        'TOTAL',
        PdfStandardFont(PdfFontFamily.helvetica, 12, style: PdfFontStyle.bold),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(margin + 15, yPos + 10, 200, 15),
      );

      double total = (double.tryParse(totalHTController.text) ?? 0) +
          (double.tryParse(tvaController.text) ?? 0) +
          (double.tryParse(timbreFController.text) ?? 0);

      graphics.drawString(
        '${total.toStringAsFixed(2)} DT',
        PdfStandardFont(PdfFontFamily.helvetica, 12, style: PdfFontStyle.bold),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(pageWidth - 200, yPos + 10, 100, 15),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
      );

      yPos += 60;

      _drawSimpleSection(graphics, 'SIGNATURE', yPos, margin, pageWidth,
          primaryBlue, sectionFont);
      yPos += 30;

      graphics.drawRectangle(
        bounds: Rect.fromLTWH(margin, yPos, 250, 100),
        brush: PdfBrushes.white,
        pen: PdfPen(darkGray, width: 1),
      );

      PdfBitmap signatureImage = PdfBitmap(signatureBytes);
      graphics.drawImage(
        signatureImage,
        Rect.fromLTWH(margin + 5, yPos + 5, 240, 90),
      );

      graphics.drawString(
        'Signé le ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
        smallFont,
        brush: PdfSolidBrush(darkGray),
        bounds: Rect.fromLTWH(margin, yPos + 110, 250, 12),
      );

      graphics.drawString(
        'Document généré automatiquement',
        smallFont,
        brush: PdfSolidBrush(darkGray),
        bounds: Rect.fromLTWH(margin, pageHeight - 30, pageWidth - 100, 12),
        format: PdfStringFormat(alignment: PdfTextAlignment.center),
      );

      List<int> bytes = await document.save();
      document.dispose();

      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/contrat_simple_$contratId.pdf';
      File(path).writeAsBytesSync(bytes);

      await OpenFile.open(path);

      print("✅ PDF simple généré: $path");
    } catch (e) {
      print("❌ Erreur: $e");
      await showAlert(
        context,
        title: "Erreur",
        message: "Erreur lors de la génération du PDF: $e",
        type: AlertType.error,
        function: () => Navigator.of(context).pop(),
      );
    }
  }

  void _drawSimpleSection(PdfGraphics graphics, String title, double yPos,
      double margin, double pageWidth, PdfColor color, PdfFont font) {
    graphics.drawLine(
      PdfPen(color, width: 2),
      Offset(margin, yPos),
      Offset(margin + 80, yPos),
    );

    graphics.drawString(
      title,
      font,
      brush: PdfSolidBrush(color),
      bounds: Rect.fromLTWH(margin, yPos + 5, pageWidth - 100, 20),
    );
  }

  Future<void> _submitContract() async {
    print("📝 Submitting contract...");

    if (!_formKey.currentState!.validate()) {
      print("❌ Form validation failed");
      return;
    }

    setState(() => isSubmitting = true);

    try {
      if (selectedConductor1 == null || selectedVehicle == null) {
        print("❌ Validation failed: Missing conductor or vehicle");
        await showAlert(
          context,
          title: "Erreur",
          message:
              "Veuillez sélectionner au moins un conducteur et un véhicule.",
          type: AlertType.error,
          function: () => Navigator.of(context).pop(),
        );
        return;
      }

      if (selectedPaymentMethod == null) {
        print("❌ Validation failed: Missing payment method");
        await showAlert(
          context,
          title: "Erreur",
          message: "Veuillez sélectionner un mode de paiement.",
          type: AlertType.error,
          function: () => Navigator.of(context).pop(),
        );
        return;
      }

      DateTime dateDepart = DateTime(
        widget.depart.year,
        widget.depart.month,
        widget.depart.day,
        widget.time1.hour,
        widget.time1.minute,
      );

      DateTime dateRetour = DateTime(
        widget.arrival.year,
        widget.arrival.month,
        widget.arrival.day,
        widget.time2.hour,
        widget.time2.minute,
      );

      print("📅 Date details:");
      print("   - Original depart: ${widget.depart}");
      print("   - Time1: ${widget.time1}");
      print("   - Final dateDepart: $dateDepart");
      print("   - Original arrival: ${widget.arrival}");
      print("   - Time2: ${widget.time2}");
      print("   - Final dateRetour: $dateRetour");

      print("📋 Contract data:");
      print("   - Vehicle ID: ${selectedVehicle!.id}");
      print("   - Conductor 1 ID: ${selectedConductor1!.id}");
      print("   - Conductor 2 ID: ${selectedConductor2?.id}");
      print("   - Payment Method: $selectedPaymentMethod");
      print("   - Timbre Fiscal: ${timbreFController.text}");
      print("   - Total HT: ${totalHTController.text}");
      print("   - TVA: ${tvaController.text}");

      print("🔄 Calling createContrat API...");
      String contratId = await createContrat(
        vehicleId: selectedVehicle!.id,
        conducteur1Id: selectedConductor1!.id,
        conducteur2Id: selectedConductor2?.id,
        dateDepart: dateDepart,
        dateRetour: dateRetour,
        modePayement: selectedPaymentMethod!,
        timbreF: double.parse(timbreFController.text),
        totalHT: double.parse(totalHTController.text),
        tva: double.parse(tvaController.text),
      );

      print("📄 API Response - Contract ID: '$contratId'");

      if (contratId.isNotEmpty && contratId != "ok") {
        print("✅ Contract created successfully with ID: $contratId");

        await _loadVehiclesAfterContract();
        await _checkTimeSyncIssue();

        if (mounted) {
          await _showPDFConfirmationDialog(contratId);
        }
      } else {
        print("❌ Contract creation failed - empty or invalid ID");
        await showAlert(
          context,
          title: "Erreur",
          message: "La création du contrat a échoué.",
          type: AlertType.error,
          function: () => Navigator.of(context).pop(),
        );
      }
    } catch (e, stackTrace) {
      print("❌ Error creating contract: $e");
      print("📋 Stack trace: $stackTrace");
      if (mounted) {
        await showAlert(
          context,
          title: "Erreur",
          message: "Erreur lors de la création du contrat: $e",
          type: AlertType.error,
          function: () => Navigator.of(context).pop(),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isSubmitting = false);
        print("📝 Contract submission completed");
      }
    }
  }

  List<String> paymentMethods = [
    'espèces',
    'chèque',
    'carte bancaire',
    'opération bancaire',
  ];

  Widget _buildMobileRefreshButton() {
    return ElevatedButton.icon(
      onPressed: () {
        print("🔄 Manual refresh triggered on mobile");
        _loadVehiclesAfterContract();
        _checkMobileSpecificIssues();
      },
      icon: Icon(Icons.refresh),
      label: Text("Rafraîchir la disponibilité"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    print("🎨 Building MakeContractPage UI");

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[100],
      appBar: AppTheme.buildRoundedAppBar(
        context,
        'Créer un contract',
        showBackButton: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Subtitle avec style cohérent
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Now, let\'s move on to filling out this form',
                        style: GoogleFonts.plusJakartaSans(
                          color: isDark ? Colors.white70 : Colors.grey[600],
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // First Conductor (Required)
                    _buildLabel("Premier Conducteur * :"),
                    _buildConductorDropdown(
                      hint: "Sélectionner le premier conducteur",
                      value: selectedConductor1,
                      onChanged: (conductor) {
                        print(
                            "👤 First conductor selected: ${conductor?.nom} ${conductor?.prenom}");
                        setState(() => selectedConductor1 = conductor);
                      },
                      required: true,
                    ),
                    const SizedBox(height: 15),

                    // Second Conductor (Optional)
                    _buildLabel("Deuxième Conducteur :"),
                    _buildConductorDropdown(
                      hint: "Sélectionner le deuxième conducteur (optionnel)",
                      value: selectedConductor2,
                      onChanged: (conductor) {
                        print(
                            "👤 Second conductor selected: ${conductor?.nom} ${conductor?.prenom}");
                        setState(() => selectedConductor2 = conductor);
                      },
                      required: false,
                      includeEmptyOption: true,
                    ),
                    const SizedBox(height: 15),

                    _buildLabel("Véhicule * :"),
                    _buildVehicleDropdown(),
                    const SizedBox(height: 15),

                    _buildLabel("Mode de Paiement * :"),
                    const SizedBox(height: 8),
                    _buildPaymentMethodDropdown(),
                    const SizedBox(height: 15),

                    _buildLabel("Timbre Fiscal * :"),
                    _buildNumericTextField(
                        timbreFController, "Entrer Timbre Fiscal",
                        required: true),
                    const SizedBox(height: 15),

                    _buildLabel("Total HT * :"),
                    _buildNumericTextField(totalHTController, "Entrer Total HT",
                        required: true),
                    const SizedBox(height: 15),

                    _buildLabel("TVA :"),
                    _buildNumericTextField(tvaController, "Entrer TVA",
                        required: false),
                    const SizedBox(height: 15),

                    _buildLabel("Signature du client :"),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Signature(
                        controller: _signatureController,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => _signatureController.clear(),
                          child: const Text("Effacer"),
                        ),
                      ],
                    ),

                    if (showVehiclesAfterCreation) ...[
                      const SizedBox(height: 20),
                      _buildLabel("Véhicules disponibles après création:"),
                      _buildVehicleStatusList(),
                    ],

                    if (isMobileIssueDetected) ...[
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.orange[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.orange),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.warning, color: Colors.orange),
                                SizedBox(width: 8),
                                Text(
                                  "Problème mobile détecté",
                                  style: TextStyle(
                                    color: Colors.orange[800],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Le véhicule peut apparaître comme disponible à cause du cache mobile. Veuillez rafraîchir ou contacter le support.",
                              style: TextStyle(color: Colors.orange[700]),
                            ),
                            SizedBox(height: 12),
                            _buildMobileRefreshButton(),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        color: isDark ? Colors.grey[850] : Colors.white,
        padding: const EdgeInsets.all(15),
        child: ElevatedButton(
          onPressed: isSubmitting ? null : _submitContract,
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
          child: isSubmitting
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text('Création en cours...',
                        style: GoogleFonts.plusJakartaSans()),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.description_outlined),
                    const SizedBox(width: 8),
                    Text(
                      'Créer le Contrat',
                      style: GoogleFonts.plusJakartaSans(
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

  Widget _buildConductorDropdown({
    required String hint,
    required Conducteur? value,
    required ValueChanged<Conducteur?> onChanged,
    required bool required,
    bool includeEmptyOption = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    List<Conducteur> availableConductors = conductors;
    if (!required && selectedConductor1 != null) {
      availableConductors = conductors
          .where((conductor) => conductor.id != selectedConductor1!.id)
          .toList();
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
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
      child: DropdownButtonFormField<Conducteur>(
        isExpanded: true,
        value: value,
        hint: Text(
          hint,
          style: GoogleFonts.plusJakartaSans(
            color: isDark ? Colors.white54 : Colors.grey.shade500,
            fontSize: 14,
          ),
        ),
        onChanged: onChanged,
        validator: (conductor) => (required && conductor == null)
            ? 'Veuillez sélectionner un conducteur'
            : null,
        decoration: _inputDecoration(
          hint: hint,
          icon: Icons.person,
        ),
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: isDark
              ? Colors.deepPurple
              : Theme.of(context).colorScheme.primary,
        ),
        items: [
          if (includeEmptyOption)
            DropdownMenuItem<Conducteur>(
              value: null,
              child: Text(
                "Aucun conducteur",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: isDark ? Colors.white54 : Colors.grey.shade500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ...availableConductors
              .map((conductor) => DropdownMenuItem<Conducteur>(
                    value: conductor,
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 18,
                          color: isDark
                              ? Colors.deepPurple
                              : Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "${conductor.pieceIdentite} - ${conductor.nom} ${conductor.prenom}",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ],
        borderRadius: BorderRadius.circular(16),
        dropdownColor: isDark ? Colors.grey[800] : Colors.white,
      ),
    );
  }

  Widget _buildVehicleDropdown() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
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
      child: DropdownButtonFormField<Vehicle>(
        isExpanded: true,
        value: selectedVehicle,
        hint: Text(
          "Sélectionner un véhicule",
          style: GoogleFonts.plusJakartaSans(
            color: isDark ? Colors.white54 : Colors.grey.shade500,
            fontSize: 14,
          ),
        ),
        onChanged: (vehicle) {
          print(
              "🚗 Vehicle selected: ${vehicle?.matricule} (${vehicle?.marque} ${vehicle?.model})");
          setState(() => selectedVehicle = vehicle);
        },
        validator: (vehicle) =>
            (vehicle == null) ? 'Veuillez sélectionner un véhicule' : null,
        decoration: _inputDecoration(
          hint: "Sélectionner un véhicule",
          icon: Icons.directions_car,
        ),
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: isDark
              ? Colors.deepPurple
              : Theme.of(context).colorScheme.primary,
        ),
        items: vehicles
            .map((vehicle) => DropdownMenuItem<Vehicle>(
                  value: vehicle,
                  child: Row(
                    children: [
                      Icon(
                        Icons.directions_car,
                        size: 18,
                        color: isDark
                            ? Colors.deepPurple
                            : Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${vehicle.matricule}",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
        borderRadius: BorderRadius.circular(16),
        dropdownColor: isDark ? Colors.grey[800] : Colors.white,
      ),
    );
  }

  Widget _buildVehicleStatusList() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.grey[600]! : Colors.grey[300]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "État des véhicules après création du contrat:",
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          if (vehiclesAfterCreation.isEmpty)
            Text(
              "Aucun véhicule disponible",
              style: GoogleFonts.plusJakartaSans(
                color: isDark ? Colors.white70 : Colors.grey[600],
              ),
            )
          else
            ...vehiclesAfterCreation.map((vehicle) {
              bool wasSelected =
                  selectedVehicle != null && vehicle.id == selectedVehicle!.id;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Icon(
                      wasSelected ? Icons.check_circle : Icons.circle,
                      color: wasSelected ? Colors.red : Colors.green,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        vehicle.matricule,
                        style: GoogleFonts.plusJakartaSans(
                          color: isDark ? Colors.white : Colors.black87,
                          fontWeight:
                              wasSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                    Text(
                      wasSelected ? "Réservé" : "Disponible",
                      style: GoogleFonts.plusJakartaSans(
                        color: wasSelected ? Colors.red : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: isDark
              ? Colors.white.withOpacity(0.9)
              : Colors.black87.withOpacity(0.8),
          letterSpacing: 0.1,
        ),
      ),
    );
  }

  Widget _buildPaymentMethodDropdown() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
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
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        value: selectedPaymentMethod,
        hint: Text(
          "Mode de paiement",
          style: GoogleFonts.plusJakartaSans(
            color: isDark ? Colors.white54 : Colors.grey.shade500,
            fontSize: 14,
          ),
        ),
        onChanged: (value) {
          print("💰 Payment method selected: $value");
          setState(() => selectedPaymentMethod = value);
        },
        validator: (value) => (value == null || value.isEmpty)
            ? 'Veuillez choisir un mode de paiement'
            : null,
        decoration: _inputDecoration(
          hint: "Mode de paiement",
          icon: Icons.payment,
        ),
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: isDark
              ? Colors.deepPurple
              : Theme.of(context).colorScheme.primary,
        ),
        items: paymentMethods
            .map((method) => DropdownMenuItem<String>(
                  value: method,
                  child: Text(
                    method,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ))
            .toList(),
        borderRadius: BorderRadius.circular(16),
        dropdownColor: isDark ? Colors.grey[800] : Colors.white,
      ),
    );
  }

  Widget _buildNumericTextField(
    TextEditingController controller,
    String hint, {
    bool required = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
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
      child: TextFormField(
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        controller: controller,
        validator: (value) =>
            _validateNumericField(value, hint, required: required),
        decoration: _inputDecoration(hint: hint),
        style: GoogleFonts.plusJakartaSans(
          color: isDark ? Colors.white : Colors.black87,
        ),
        onChanged: (value) {
          print("📊 $hint changed to: $value");
        },
      ),
    );
  }

  InputDecoration _inputDecoration({String? hint, IconData? icon}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: isDark ? Colors.grey[800] : Colors.grey.shade50,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: isDark ? Colors.grey[700]! : Colors.grey.shade200,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: isDark
              ? Colors.deepPurple
              : Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
      ),
      hintStyle: GoogleFonts.plusJakartaSans(
        color: isDark ? Colors.white54 : Colors.grey.shade500,
        fontSize: 14,
      ),
    );
  }
}
