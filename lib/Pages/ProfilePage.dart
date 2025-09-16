/*
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart'; // Ajouter cette import
import 'package:rent_car/Widgets/BaseScaffold.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import 'EditAgentInfoPage.dart';
import 'package:rent_car/theme/theme_notifier.dart';

class AgentProfilePage extends StatefulWidget {
  const AgentProfilePage({super.key});

  @override
  State<AgentProfilePage> createState() => _AgentProfileWithPhotoPageState();
}

class _AgentProfileWithPhotoPageState extends State<AgentProfilePage> {
  File? _profileImage;
  final picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source, imageQuality: 70);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil mis à jour ✅')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'My Profile',
      currentIndex: 3,
      showBackButton: true,
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _showImageSourceOptions,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor:
                            const Color.fromARGB(255, 101, 100, 100),
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : null,
                        child: _profileImage == null
                            ? const Icon(Icons.person,
                                size: 80, color: Colors.white)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.blue,
                          child: const Icon(Icons.edit,
                              size: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Agent Name',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0060FC),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _agentProfileCard(context),
          const SizedBox(height: 20),
          // Nouvelle section pour les paramètres de thème
          _themeSettingsCard(context),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            icon: const Icon(Icons.logout, color: Colors.white),
            label: Text(
              'Log out',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () {
              logout();
            },
          ),
        ],
      ),
    );
  }

  Widget _agentProfileCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Agent Information',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditAgentInfoPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit,
                      size: 18, color: Color(0xFF0060FC)),
                  label: Text('Edit',
                      style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF0060FC))),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Table(
              columnWidths: const {
                0: IntrinsicColumnWidth(),
                1: FlexColumnWidth(),
              },
              children: [
                _infoRow('Full Name', 'Agent Name'),
                _infoRow('Email', 'name@gmail.com'),
                _infoRow('Phone number', '+216 25 485 865'),
                _infoRow('Agency Name', 'RentCar'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Nouvelle section pour les paramètres de thème
  Widget _themeSettingsCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Appearance Settings',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return Column(
                  children: [
                    // Switch simple pour toggle
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Dark Mode',
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        themeProvider.isDarkMode ? 'On' : 'Off',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      value: themeProvider.isDarkMode,
                      activeColor: const Color(0xFF0060FC),
                      onChanged: (value) {
                        themeProvider.toggleTheme();
                      },
                      secondary: Icon(
                        themeProvider.isDarkMode
                            ? Icons.dark_mode
                            : Icons.light_mode,
                        color: const Color(0xFF0060FC),
                      ),
                    ),

                    const Divider(),

                    // Options détaillées
                    Text(
                      'Theme Preference',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),

                    RadioListTile<ThemeMode>(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Follow System',
                        style: GoogleFonts.plusJakartaSans(fontSize: 14),
                      ),
                      subtitle: Text(
                        'Use device settings',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                      ),
                      value: ThemeMode.system,
                      groupValue: themeProvider.themeMode,
                      activeColor: const Color(0xFF0060FC),
                      onChanged: (ThemeMode? value) {
                        if (value != null) {
                          themeProvider.setTheme(value);
                        }
                      },
                    ),

                    RadioListTile<ThemeMode>(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Light Mode',
                        style: GoogleFonts.plusJakartaSans(fontSize: 14),
                      ),
                      value: ThemeMode.light,
                      groupValue: themeProvider.themeMode,
                      activeColor: const Color(0xFF0060FC),
                      onChanged: (ThemeMode? value) {
                        if (value != null) {
                          themeProvider.setTheme(value);
                        }
                      },
                    ),

                    RadioListTile<ThemeMode>(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Dark Mode',
                        style: GoogleFonts.plusJakartaSans(fontSize: 14),
                      ),
                      value: ThemeMode.dark,
                      groupValue: themeProvider.themeMode,
                      activeColor: const Color(0xFF0060FC),
                      onChanged: (ThemeMode? value) {
                        if (value != null) {
                          themeProvider.setTheme(value);
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  TableRow _infoRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(
            '$label:',
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(value, style: GoogleFonts.plusJakartaSans()),
        ),
      ],
    );
  }
}
*/
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rent_car/Widgets/BaseScaffold.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import 'package:rent_car/Pages/EditAgentInfoPage.dart';
import 'package:rent_car/theme/theme_notifier.dart';
import 'package:rent_car/services/Agent_provider.dart';
import 'package:rent_car/Models/Agent.dart';

class AgentProfilePage extends StatefulWidget {
  const AgentProfilePage({super.key});

  @override
  State<AgentProfilePage> createState() => _AgentProfileWithPhotoPageState();
}

class _AgentProfileWithPhotoPageState extends State<AgentProfilePage> {
  File? _profileImage;
  final picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source, imageQuality: 70);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _showImageSourceOptions() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border:
                isDark ? Border.all(color: Colors.grey.withOpacity(0.2)) : null,
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.5)
                    : Colors.grey.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Choisir une Photo',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.blue.withOpacity(0.2)
                            : Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.photo_library,
                        color: isDark ? Colors.blue[300] : Colors.blue[700],
                      ),
                    ),
                    title: Text(
                      'Galerie',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      'Choisir depuis la galerie',
                      style: GoogleFonts.plusJakartaSans(
                        color: isDark ? Colors.white70 : Colors.grey[600],
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      _pickImage(ImageSource.gallery);
                    },
                  ),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.green.withOpacity(0.2)
                            : Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        color: isDark ? Colors.green[300] : Colors.green[700],
                      ),
                    ),
                    title: Text(
                      'Caméra',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      'Prendre une nouvelle photo',
                      style: GoogleFonts.plusJakartaSans(
                        color: isDark ? Colors.white70 : Colors.grey[600],
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      _pickImage(ImageSource.camera);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AgentProvider>(
      builder: (context, agentProvider, child) {
        // Reload profile après que le provider soit accessible
        WidgetsBinding.instance.addPostFrameCallback((_) {
          agentProvider.reloadProfile();
        });

        final agent = agentProvider.currentAgent;

        if (agent == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return BaseScaffold(
          title: 'Mon Profil',
          currentIndex: 3,
          showBackButton: true,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildProfileHeaderCard(context, agent),
                _buildAgentInfoCard(context, agent),
                _buildThemeSettingsCard(context),
                const SizedBox(height: 16),
                _buildLogoutButton(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileHeaderCard(BuildContext context, Agent agent) {
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
          children: [
            GestureDetector(
              onTap: _showImageSourceOptions,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: isDark
                        ? Colors.grey[800]
                        : const Color.fromARGB(255, 101, 100, 100),
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : null,
                    child: _profileImage == null
                        ? Icon(
                            Icons.person,
                            size: 80,
                            color: isDark ? Colors.white70 : Colors.white,
                          )
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor:
                            isDark ? Colors.deepPurple[400] : Colors.blue,
                        child: const Icon(
                          Icons.edit,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              agent.name,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            Text(
              agent.agency,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                color: isDark ? Colors.white70 : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAgentInfoCard(BuildContext context, Agent agent) {
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
                    Icons.person,
                    color: isDark ? Colors.blue[300] : Colors.blue[700],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Informations Agent',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.blue.withOpacity(0.2)
                        : Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditAgentInfoPage(),
                        ),
                      ).then((_) {
                        // Refresh profile after editing
                        Provider.of<AgentProvider>(context, listen: false)
                            .reloadProfile();
                      });
                    },
                    icon: Icon(
                      Icons.edit,
                      size: 16,
                      color: isDark ? Colors.blue[300] : Colors.blue[700],
                    ),
                    label: Text(
                      'Modifier',
                      style: GoogleFonts.plusJakartaSans(
                        color: isDark ? Colors.blue[300] : Colors.blue[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildInfoRow(context, 'Nom Complet', agent.name),
            const SizedBox(height: 12),
            _buildInfoRow(context, 'Email', agent.email),
            const SizedBox(height: 12),
            _buildInfoRow(context, 'Téléphone', agent.phone),
            const SizedBox(height: 12),
            _buildInfoRow(context, 'Agence', agent.agency),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSettingsCard(BuildContext context) {
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
                    Icons.palette,
                    color: isDark ? Colors.orange[300] : Colors.orange[700],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Paramètres d\'Apparence',
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
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return Column(
                  children: [
                    _buildThemeToggleRow(context, themeProvider),
                    const SizedBox(height: 16),
                    Text(
                      'Préférence de Thème',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white70 : Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildThemeOptionRow(
                        context,
                        themeProvider,
                        ThemeMode.system,
                        'Suivre le Système',
                        'S\'adapte aux paramètres de l\'appareil'),
                    const SizedBox(height: 12),
                    _buildThemeOptionRow(
                        context,
                        themeProvider,
                        ThemeMode.light,
                        'Mode Clair',
                        'Interface claire et lumineuse'),
                    const SizedBox(height: 12),
                    _buildThemeOptionRow(context, themeProvider, ThemeMode.dark,
                        'Mode Sombre', 'Repose les yeux'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeToggleRow(
      BuildContext context, ThemeProvider themeProvider) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            'Mode Sombre',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : Colors.grey[700],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                themeProvider.isDarkMode ? 'Activé' : 'Désactivé',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              Switch.adaptive(
                value: themeProvider.isDarkMode,
                activeColor: isDark ? Colors.deepPurple[400] : Colors.blue,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildThemeOptionRow(BuildContext context, ThemeProvider themeProvider,
      ThemeMode mode, String title, String subtitle) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = themeProvider.themeMode == mode;

    return GestureDetector(
      onTap: () => themeProvider.setTheme(mode),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark
                  ? Colors.deepPurple.withOpacity(0.2)
                  : Colors.blue.withOpacity(0.1))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(
                  color: isDark ? Colors.deepPurple[400]! : Colors.blue,
                  width: 1)
              : null,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? (isDark ? Colors.deepPurple[300] : Colors.blue[700])
                          : (isDark ? Colors.white70 : Colors.grey[700]),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: isDark ? Colors.white54 : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Radio<ThemeMode>(
              value: mode,
              groupValue: themeProvider.themeMode,
              activeColor: isDark ? Colors.deepPurple[400] : Colors.blue,
              onChanged: (ThemeMode? value) {
                if (value != null) themeProvider.setTheme(value);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : Colors.grey[700],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.logout, color: Colors.white),
        label: Text(
          'Se Déconnecter',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          elevation: isDark ? 8 : 4,
          shadowColor: isDark
              ? Colors.black.withOpacity(0.5)
              : Colors.red.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: () {
          logout();
        },
      ),
    );
  }

  void logout() {
    storage.deleteAll();
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }
}
