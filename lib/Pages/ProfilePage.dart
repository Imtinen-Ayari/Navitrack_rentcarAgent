/*import 'package:flutter/material.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import 'package:rent_car/Widgets/BaseScaffold.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static const Color bleu = Color(0xFF0060FC);
  static const Color noir = Color(0xFF000000);
  static const Color blanc = Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 3,
      title: "Profile",
      showBackButton: true,
      body: SafeArea(
        child: Column(
          children: [
            // Header sans AppBar, juste un container moderne
            Container(
              width: double.infinity,
              height: 160,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [bleu.withOpacity(0.85), const Color(0xFF0043C7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Pas de bouton settings ici, car tu peux le mettre dans AppBar si besoin
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: blanc,
                    child: const Icon(Icons.person, size: 48, color: bleu),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Agent Name",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "name@gmail.com",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            // Le reste de la page en dessous, comme avant...
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Agent information",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: noir),
                  ),
                  Text(
                    "Edit",
                    style: TextStyle(
                      color: bleu,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: const [
                  InfoRow(label: "Full Name", value: "Agent name"),
                  InfoRow(label: "Phone number", value: "+123456789"),
                  InfoRow(label: "Agency Name", value: "Rental Agent"),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Notifications",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: noir),
                  ),
                  Switch(
                    value: true,
                    onChanged: (val) {
                      // Logique notification
                    },
                    activeColor: noir,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: blanc,
                  foregroundColor: noir,
                  side: const BorderSide(color: noir),
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  logout();
                },
                child: const Text("Log Out"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({required this.label, required this.value, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 16, color: ProfilePage.noir)),
          Text(value,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ProfilePage.noir)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import 'package:rent_car/Widgets/BaseScaffold.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static const Color bleu = Color(0xFF0060FC);
  static const Color noir = Color(0xFF000000);
  static const Color blanc = Color(0xFFFFFFFF);

  void _onAvatarTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        height: 180,
        child: Column(
          children: [
            const Text("Changer la photo de profil",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.photo),
              label: const Text("Choisir une photo"),
              onPressed: () {
                // Intégrer image_picker ici
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 3,
      title: "Profile",
      showBackButton: true,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER MODERNE
            Container(
              width: double.infinity,
              height: 160,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [bleu.withOpacity(0.85), const Color(0xFF0043C7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => _onAvatarTap(context),
                    borderRadius: BorderRadius.circular(40),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: blanc,
                      child: const Icon(Icons.person, size: 48, color: bleu),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Agent Name",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "name@gmail.com",
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            // AGENT INFO
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Agent information",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: noir)),
                  Text("Edit",
                      style: GoogleFonts.poppins(
                          color: bleu, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: const [
                  InfoRow(label: "Full Name", value: "Agent name"),
                  InfoRow(label: "Phone number", value: "+123456789"),
                  InfoRow(label: "Agency Name", value: "Rental Agent"),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // NOTIFICATIONS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Notifications",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: noir)),
                  Switch(
                    value: true,
                    onChanged: (val) {
                      // Logique notification
                    },
                    activeColor: noir,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // LOG OUT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: blanc,
                  foregroundColor: noir,
                  side: const BorderSide(color: noir),
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  logout();
                },
                child: const Text("Log Out"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({required this.label, required this.value, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6FA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[800],
                )),
            Text(value,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_car/Widgets/BaseScaffold.dart';
import 'package:rent_car/services/Secure_Storage.dart';

class AgentProfilePage extends StatefulWidget {
  const AgentProfilePage({super.key});

  @override
  State<AgentProfilePage> createState() => _AgentProfileWithPhotoPageState();
}

class _AgentProfileWithPhotoPageState extends State<AgentProfilePage> {
  File? _profileImage;
  final picker = ImagePicker();

  // 🎯 Editable fields
  final nameController = TextEditingController(text: 'Amira Jouini');
  final emailController =
      TextEditingController(text: 'amira.jouini@rentcar.com');
  final phoneController = TextEditingController(text: '+216 25 485 865');
  final agencyController = TextEditingController(text: 'RentCar Nabeul');

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
    // 🎯 À connecter à SecureStorage ou API backend
    print('Nom : ${nameController.text}');
    print('Email : ${emailController.text}');
    print('Téléphone : ${phoneController.text}');
    print('Agence : ${agencyController.text}');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil mis à jour ✅')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Profile',
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
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.black,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : null,
                    child: _profileImage == null
                        ? const Icon(Icons.person,
                            size: 80, color: Colors.white)
                        : null,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Agent Name',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0060FC),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _editableField('Nom', nameController),
          _editableField('Email', emailController),
          _editableField('Téléphone', phoneController),
          _editableField('Agence', agencyController),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            icon: const Icon(Icons.save),
            label: const Text('Sauvegarder'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: _saveProfile,
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            icon: const Icon(Icons.logout),
            label: const Text('Log out'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            onPressed: () {
              logout();
            },
          ),
        ],
      ),
    );
  }

  Widget _editableField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_car/Widgets/BaseScaffold.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import 'EditAgentInfoPage.dart';

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
      title: 'Profile',
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
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: const Color.fromARGB(255, 101, 100, 100),
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : null,
                    child: _profileImage == null
                        ? const Icon(Icons.person,
                            size: 80, color: Colors.white)
                        : null,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Agent Name',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0060FC),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _agentProfileCard(context),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            icon: const Icon(Icons.logout, color: Colors.white),
            label: const Text(
              'Log out',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 15),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0060FC)),
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
                const Text(
                  'Agent Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  label: const Text('Edit',
                      style: TextStyle(color: Color(0xFF0060FC))),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _infoRow('Full Name', 'Agent Name'),
            _infoRow('Email', 'name@gmail.com'),
            _infoRow('Phone number', '+216 25 485 865'),
            _infoRow('Agency Name', 'RentCar'),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}*/
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_car/Widgets/BaseScaffold.dart';
import 'package:rent_car/services/Secure_Storage.dart';
import 'EditAgentInfoPage.dart';

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
      title: 'Profile',
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
