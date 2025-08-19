import 'package:flutter/material.dart';
import 'package:rent_car/Widgets/BusMapWidget.dart';


class BusMapPage extends StatefulWidget {
  @override
  _BusMapPageState createState() => _BusMapPageState();
}

class _BusMapPageState extends State<BusMapPage> {
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
        title: Text(
          'Fleet Map',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: BusMapWidget(), // Using the BusMapWidget here
    );
  }
}
