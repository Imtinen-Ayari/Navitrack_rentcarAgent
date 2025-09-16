/*import 'package:flutter/material.dart';

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
          'Update Agent',
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
                label: 'Name', icon: Icons.person, controller: nameController),
            _editableField(
                label: 'Email', icon: Icons.email, controller: emailController),
            _editableField(
                label: 'Phone number',
                icon: Icons.phone,
                controller: phoneController),
            _editableField(
                label: 'Agency',
                icon: Icons.business,
                controller: agencyController),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _saveChanges,
              icon: const Icon(Icons.save),
              label: const Text('Apply Changes'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 23, 190, 28),
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
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent_car/Models/Agent.dart';

class EditAgentInfoPage extends StatefulWidget {
  final Agent agent;
  const EditAgentInfoPage({super.key, required this.agent});

  @override
  State<EditAgentInfoPage> createState() => _EditAgentInfoPageState();
}

class _EditAgentInfoPageState extends State<EditAgentInfoPage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController agencyController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.agent.name);
    emailController = TextEditingController(text: widget.agent.email);
    phoneController = TextEditingController(text: widget.agent.phone);
    agencyController = TextEditingController(text: widget.agent.agency);
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [const Color(0xFF1F1F1F), const Color(0xFF2D2D2D)]
                : [const Color(0xFF0060FC), const Color(0xFF4D9EF6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      toolbarHeight: 100,
      title: Text(
        'Update Agent',
        style: GoogleFonts.plusJakartaSans(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  void _saveChanges() {
    // ici tu renvoies l'agent mis à jour
    final updatedAgent = Agent(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      agency: agencyController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Modifications enregistrées ✅',
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );

    Navigator.pop(context, updatedAgent); // 🔥 retour avec données modifiées
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    agencyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            // Avatar
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF8B5CF6).withOpacity(0.2)
                      : Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: isDark
                        ? const Color(0xFF8B5CF6)
                        : const Color(0xFF0060FC),
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: isDark
                      ? const Color(0xFF8B5CF6)
                      : const Color(0xFF0060FC),
                ),
              ),
            ),

            const SizedBox(height: 30),

            _editableField(
              label: 'Nom',
              icon: Icons.person_outline,
              controller: nameController,
            ),
            _editableField(
              label: 'Email',
              icon: Icons.email_outlined,
              controller: emailController,
            ),
            _editableField(
              label: 'Numéro de téléphone',
              icon: Icons.phone_outlined,
              controller: phoneController,
            ),
            _editableField(
              label: 'Agence',
              icon: Icons.business_outlined,
              controller: agencyController,
            ),

            const SizedBox(height: 40),

            // bouton
            Container(
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF10B981), Color(0xFF059669)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF10B981).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: _saveChanges,
                icon: const Icon(Icons.save_outlined,
                    color: Colors.white, size: 24),
                label: Text(
                  'Appliquer les Modifications',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? const Color(0xFFD1D5DB) : const Color(0xFF374151),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            style: GoogleFonts.plusJakartaSans(
              color: isDark ? Colors.white : Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            keyboardType: label.toLowerCase().contains('téléphone')
                ? TextInputType.phone
                : label.toLowerCase().contains('email')
                    ? TextInputType.emailAddress
                    : TextInputType.text,
            decoration: InputDecoration(
              filled: true,
              fillColor: isDark ? const Color(0xFF374151) : Colors.white,
              prefixIcon: Icon(
                icon,
                color:
                    isDark ? const Color(0xFF8B5CF6) : const Color(0xFF0060FC),
                size: 22,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: isDark
                      ? Colors.grey.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.3),
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: isDark
                      ? Colors.grey.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: isDark
                      ? const Color(0xFF8B5CF6)
                      : const Color(0xFF0060FC),
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rent_car/Models/Agent.dart';
import 'package:rent_car/services/Agent_provider.dart';

class EditAgentInfoPage extends StatefulWidget {
  const EditAgentInfoPage({super.key});

  @override
  State<EditAgentInfoPage> createState() => _EditAgentInfoPageState();
}

class _EditAgentInfoPageState extends State<EditAgentInfoPage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController agencyController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final agentProvider = Provider.of<AgentProvider>(context, listen: false);
    final agent = agentProvider.currentAgent;

    nameController = TextEditingController(text: agent?.name ?? '');
    emailController = TextEditingController(text: agent?.email ?? '');
    phoneController = TextEditingController(text: agent?.phone ?? '');
    agencyController = TextEditingController(text: agent?.agency ?? '');
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [const Color(0xFF1F1F1F), const Color(0xFF2D2D2D)]
                : [const Color(0xFF0060FC), const Color(0xFF4D9EF6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      toolbarHeight: 100,
      title: Text(
        'Modifier le Profil',
        style: GoogleFonts.plusJakartaSans(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  void _saveChanges() async {
    final agentProvider = Provider.of<AgentProvider>(context, listen: false);

    final updatedAgent = Agent(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      agency: agencyController.text,
    );

    final success = await agentProvider.updateAgentProfile(updatedAgent);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Modifications enregistrées ✅',
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: const Color(0xFF10B981),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Erreur lors de la sauvegarde ❌',
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    agencyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            // Avatar
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF8B5CF6).withOpacity(0.2)
                      : Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: isDark
                        ? const Color(0xFF8B5CF6)
                        : const Color(0xFF0060FC),
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: isDark
                      ? const Color(0xFF8B5CF6)
                      : const Color(0xFF0060FC),
                ),
              ),
            ),

            const SizedBox(height: 30),

            _editableField(
              label: 'Nom',
              icon: Icons.person_outline,
              controller: nameController,
            ),
            _editableField(
              label: 'Email',
              icon: Icons.email_outlined,
              controller: emailController,
            ),
            _editableField(
              label: 'Numéro de téléphone',
              icon: Icons.phone_outlined,
              controller: phoneController,
            ),
            _editableField(
              label: 'Agence',
              icon: Icons.business_outlined,
              controller: agencyController,
            ),

            const SizedBox(height: 40),

            // bouton
            Container(
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF10B981), Color(0xFF059669)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF10B981).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: _saveChanges,
                icon: const Icon(Icons.save_outlined,
                    color: Colors.white, size: 24),
                label: Text(
                  'Appliquer les Modifications',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? const Color(0xFFD1D5DB) : const Color(0xFF374151),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            style: GoogleFonts.plusJakartaSans(
              color: isDark ? Colors.white : Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            keyboardType: label.toLowerCase().contains('téléphone')
                ? TextInputType.phone
                : label.toLowerCase().contains('email')
                    ? TextInputType.emailAddress
                    : TextInputType.text,
            decoration: InputDecoration(
              filled: true,
              fillColor: isDark ? const Color(0xFF374151) : Colors.white,
              prefixIcon: Icon(
                icon,
                color:
                    isDark ? const Color(0xFF8B5CF6) : const Color(0xFF0060FC),
                size: 22,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: isDark
                      ? Colors.grey.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.3),
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: isDark
                      ? Colors.grey.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: isDark
                      ? const Color(0xFF8B5CF6)
                      : const Color(0xFF0060FC),
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
