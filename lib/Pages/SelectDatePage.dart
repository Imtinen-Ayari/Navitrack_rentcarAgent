/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rent_car/Pages/MakeContractPage.dart';

class SelectDatePage extends StatefulWidget {
  const SelectDatePage({Key? key}) : super(key: key);

  @override
  SelectDatePageState createState() => SelectDatePageState();
}

class SelectDatePageState extends State<SelectDatePage> {
  DateTime departureDate = DateTime.now();
  DateTime arrivalDate = DateTime.now();
  TimeOfDay departureTime = TimeOfDay.now();
  TimeOfDay arrivalTime = TimeOfDay.now();

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(BuildContext context, bool isDeparture) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isDeparture ? departureDate : arrivalDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        if (isDeparture) {
          departureDate = pickedDate;
        } else {
          arrivalDate = pickedDate;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isDeparture) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isDeparture ? departureTime : arrivalTime,
    );

    if (pickedTime != null) {
      setState(() {
        if (isDeparture) {
          departureTime = pickedTime;
        } else {
          arrivalTime = pickedTime;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Let\'s Make a Contract',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: EdgeInsets.only(bottom: 25.0),
            child: Text(
              'First Start by selecting Dates and Times',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
        centerTitle: true,
        toolbarHeight: 120,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildDateTile(
                context,
                'Departure Date',
                dateFormat.format(departureDate),
                () => _selectDate(context, true),
              ),
              const SizedBox(height: 10),
              _buildDateTile(
                context,
                'Arrival Date',
                dateFormat.format(arrivalDate),
                () => _selectDate(context, false),
              ),
              const SizedBox(height: 10),
              _buildTimeTile(
                context,
                'Departure Time',
                departureTime.format(context),
                () => _selectTime(context, true),
              ),
              const SizedBox(height: 10),
              _buildTimeTile(
                context,
                'Arrival Time',
                arrivalTime.format(context),
                () => _selectTime(context, false),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.all(5),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MakeContractPage(
                  depart: departureDate,
                  arrival: arrivalDate,
                  time1: departureTime,
                  time2: arrivalTime,
                ),
              ),
            );
          },
          child: const Text(
            'Next Step',
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateTile(
    BuildContext context,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(color: Colors.black.withOpacity(0.8)),
          ),
          trailing: Icon(
            Icons.calendar_today,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeTile(
    BuildContext context,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(color: Colors.black.withOpacity(0.7)),
          ),
          trailing: Icon(
            Icons.access_time,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
} 

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rent_car/Pages/MakeContractPage.dart';

class SelectDatePage extends StatefulWidget {
  const SelectDatePage({Key? key}) : super(key: key);

  @override
  SelectDatePageState createState() => SelectDatePageState();
}

class SelectDatePageState extends State<SelectDatePage> {
  DateTime departureDate = DateTime.now();
  DateTime arrivalDate = DateTime.now();
  TimeOfDay departureTime = TimeOfDay.now();
  TimeOfDay arrivalTime = TimeOfDay.now();

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(BuildContext context, bool isDeparture) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isDeparture ? departureDate : arrivalDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        if (isDeparture) {
          departureDate = pickedDate;
        } else {
          arrivalDate = pickedDate;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isDeparture) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isDeparture ? departureTime : arrivalTime,
    );

    if (pickedTime != null) {
      setState(() {
        if (isDeparture) {
          departureTime = pickedTime;
        } else {
          arrivalTime = pickedTime;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        toolbarHeight: 130,
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0060FC), Color(0xFF4D9EF6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(top: 40.0),
          child: Column(
            children: [
              Text(
                "Let’s Make a Contract",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text(
                "Select Dates and Times",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              )
            ],
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 160.0, left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              _buildCardTile(
                context,
                icon: Icons.calendar_month_rounded,
                label: "Departure Date",
                value: dateFormat.format(departureDate),
                onTap: () => _selectDate(context, true),
              ),
              const SizedBox(height: 12),
              _buildCardTile(
                context,
                icon: Icons.calendar_today,
                label: "Arrival Date",
                value: dateFormat.format(arrivalDate),
                onTap: () => _selectDate(context, false),
              ),
              const SizedBox(height: 12),
              _buildCardTile(
                context,
                icon: Icons.access_time,
                label: "Departure Time",
                value: departureTime.format(context),
                onTap: () => _selectTime(context, true),
              ),
              const SizedBox(height: 12),
              _buildCardTile(
                context,
                icon: Icons.access_time_filled,
                label: "Arrival Time",
                value: arrivalTime.format(context),
                onTap: () => _selectTime(context, false),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MakeContractPage(
                  depart: departureDate,
                  arrival: arrivalDate,
                  time1: departureTime,
                  time2: arrivalTime,
                ),
              ),
            );
          },
          icon: const Icon(Icons.arrow_forward_ios_rounded),
          label: const Text("Next Step"),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0060FC),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
          ),
        ),
      ),
    );
  }

  Widget _buildCardTile(BuildContext context,
      {required IconData icon,
      required String label,
      required String value,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Row(
            children: [
              Icon(icon, size: 28, color: Colors.grey[700]),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(value,
                        style:
                            TextStyle(fontSize: 15, color: Colors.grey[800])),
                  ],
                ),
              ),
              const Icon(Icons.edit_calendar, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
} */
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rent_car/Pages/MakeContractPage.dart';

class SelectDatePage extends StatefulWidget {
  const SelectDatePage({Key? key}) : super(key: key);

  @override
  SelectDatePageState createState() => SelectDatePageState();
}

class SelectDatePageState extends State<SelectDatePage> {
  DateTime departureDate = DateTime.now();
  DateTime arrivalDate = DateTime.now();
  TimeOfDay departureTime = TimeOfDay.now();
  TimeOfDay arrivalTime = TimeOfDay.now();

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(BuildContext context, bool isDeparture) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isDeparture ? departureDate : arrivalDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        isDeparture ? departureDate = pickedDate : arrivalDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isDeparture) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isDeparture ? departureTime : arrivalTime,
    );

    if (pickedTime != null) {
      setState(() {
        isDeparture ? departureTime = pickedTime : arrivalTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        toolbarHeight: 130,
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0060FC), Color(0xFF4D9EF6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(top: 40.0),
          child: Column(
            children: [
              Text(
                "Let’s Make a Contract",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6),
              Text(
                "Select Dates and Times",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              )
            ],
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 160.0, left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              _buildCardTile(
                context,
                icon: Icons.calendar_month_rounded,
                label: "Departure Date",
                value: dateFormat.format(departureDate),
                onTap: () => _selectDate(context, true),
              ),
              const SizedBox(height: 12),
              _buildCardTile(
                context,
                icon: Icons.calendar_today,
                label: "Arrival Date",
                value: dateFormat.format(arrivalDate),
                onTap: () => _selectDate(context, false),
              ),
              const SizedBox(height: 12),
              _buildCardTile(
                context,
                icon: Icons.access_time,
                label: "Departure Time",
                value: departureTime.format(context),
                onTap: () => _selectTime(context, true),
              ),
              const SizedBox(height: 12),
              _buildCardTile(
                context,
                icon: Icons.access_time_filled,
                label: "Arrival Time",
                value: arrivalTime.format(context),
                onTap: () => _selectTime(context, false),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              16, 0, 16, 24), // marge inférieure augmentée
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MakeContractPage(
                    depart: departureDate,
                    arrival: arrivalDate,
                    time1: departureTime,
                    time2: arrivalTime,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.arrow_forward_ios_rounded),
            label: const Text("Next Step"),
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
          ),
        ),
      ),
    );
  }

  Widget _buildCardTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Row(
            children: [
              Icon(icon, size: 28, color: Colors.grey[700]),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 4),
                    Text(value,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[800],
                        )),
                  ],
                ),
              ),
              const Icon(Icons.edit_calendar, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
/*
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rent_car/Pages/MakeContractPage.dart';

class SelectDatePage extends StatefulWidget {
  const SelectDatePage({Key? key}) : super(key: key);

  @override
  SelectDatePageState createState() => SelectDatePageState();
}

class SelectDatePageState extends State<SelectDatePage> {
  DateTime departureDate = DateTime.now();
  DateTime arrivalDate = DateTime.now();
  TimeOfDay departureTime = TimeOfDay.now();
  TimeOfDay arrivalTime = TimeOfDay.now();

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(BuildContext context, bool isDeparture) async {
    final DateTime firstDate = isDeparture ? DateTime.now() : departureDate;

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isDeparture ? departureDate : arrivalDate,
      firstDate: firstDate,
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        if (isDeparture) {
          departureDate = pickedDate;

          // Si la date de départ est modifiée après la date d’arrivée,
          // on ajuste la date d’arrivée pour qu’elle ne soit pas avant.
          if (arrivalDate.isBefore(departureDate)) {
            arrivalDate = departureDate;
          }
        } else {
          arrivalDate = pickedDate;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isDeparture) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isDeparture ? departureTime : arrivalTime,
    );

    if (pickedTime != null) {
      setState(() {
        if (isDeparture) {
          departureTime = pickedTime;

          // Si la date est la même, on ajuste l'heure d'arrivée si besoin
          if (arrivalDate.isAtSameMomentAs(departureDate)) {
            final depMinutes = departureTime.hour * 60 + departureTime.minute;
            final arrMinutes = arrivalTime.hour * 60 + arrivalTime.minute;
            if (arrMinutes <= depMinutes) {
              arrivalTime = TimeOfDay(
                  hour: (departureTime.hour + 1) % 24,
                  minute: departureTime.minute);
            }
          }
        } else {
          arrivalTime = pickedTime;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        toolbarHeight: 130,
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0060FC), Color(0xFF4D9EF6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(top: 40.0),
          child: Column(
            children: [
              Text(
                "Let’s Make a Contract",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6),
              Text(
                "Select Dates and Times",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              )
            ],
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 160.0, left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              _buildCardTile(
                context,
                icon: Icons.calendar_month_rounded,
                label: "Departure Date",
                value: dateFormat.format(departureDate),
                onTap: () => _selectDate(context, true),
              ),
              const SizedBox(height: 12),
              _buildCardTile(
                context,
                icon: Icons.calendar_today,
                label: "Arrival Date",
                value: dateFormat.format(arrivalDate),
                onTap: () => _selectDate(context, false),
              ),
              const SizedBox(height: 12),
              _buildCardTile(
                context,
                icon: Icons.access_time,
                label: "Departure Time",
                value: departureTime.format(context),
                onTap: () => _selectTime(context, true),
              ),
              const SizedBox(height: 12),
              _buildCardTile(
                context,
                icon: Icons.access_time_filled,
                label: "Arrival Time",
                value: arrivalTime.format(context),
                onTap: () => _selectTime(context, false),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: ElevatedButton.icon(
            onPressed: () {
              final departureDateTime = DateTime(
                departureDate.year,
                departureDate.month,
                departureDate.day,
                departureTime.hour,
                departureTime.minute,
              );
              final arrivalDateTime = DateTime(
                arrivalDate.year,
                arrivalDate.month,
                arrivalDate.day,
                arrivalTime.hour,
                arrivalTime.minute,
              );

              if (!arrivalDateTime.isAfter(departureDateTime)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Arrival date/time must be after departure'),
                    duration: Duration(seconds: 3),
                  ),
                );
                return;
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MakeContractPage(
                    depart: departureDate,
                    arrival: arrivalDate,
                    time1: departureTime,
                    time2: arrivalTime,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.arrow_forward_ios_rounded),
            label: const Text("Next Step"),
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
          ),
        ),
      ),
    );
  }

  Widget _buildCardTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Row(
            children: [
              Icon(icon, size: 28, color: Colors.grey[700]),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 4),
                    Text(value,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[800],
                        )),
                  ],
                ),
              ),
              const Icon(Icons.edit_calendar, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}*/
