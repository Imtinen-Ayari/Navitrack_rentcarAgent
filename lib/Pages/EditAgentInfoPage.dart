import 'package:flutter/material.dart';

class EditAgentInfoPage extends StatefulWidget {
  const EditAgentInfoPage({super.key});

  @override
  State<EditAgentInfoPage> createState() => _EditAgentInfoPageState();
}

class _EditAgentInfoPageState extends State<EditAgentInfoPage> {
  final nameController = TextEditingController(text: 'Agent name');
  final emailController = TextEditingController(text: 'name@gmail.com');
  final phoneController = TextEditingController(text: '+216 25 485 865');
  final agencyController = TextEditingController(text: 'RentCar');

  void _saveChanges() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Modifications enregistrées ✅'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF0060FC);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
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
        title: const Text(
          'Modifier Agent',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            _editableField(
                label: 'Nom', icon: Icons.person, controller: nameController),
            _editableField(
                label: 'Email', icon: Icons.email, controller: emailController),
            _editableField(
                label: 'Téléphone',
                icon: Icons.phone,
                controller: phoneController),
            _editableField(
                label: 'Agence',
                icon: Icons.business,
                controller: agencyController),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _saveChanges,
              icon: const Icon(Icons.save),
              label: const Text('Sauvegarder les modifications'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _editableField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        keyboardType: label.toLowerCase().contains('téléphone')
            ? TextInputType.phone
            : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
          labelStyle: const TextStyle(fontWeight: FontWeight.w500),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xFF0060FC), width: 2),
          ),
        ),
      ),
    );
  }
}
