import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum AlertType { success, error, warning, progress }

Future<void> showAlert(
  BuildContext context, {
  required String title,
  required String message,
  Function? function,
  AlertType type = AlertType.success,
}) async {
  Color titleColor = Colors.black;
  Color iconColor = Colors.white;
  Color backgroundColor = Colors.white;
  double paddingVal = 10;
  Icon icon;

  switch (type) {
    case AlertType.success:
      backgroundColor = const Color(0xFF15B315);
      icon = Icon(
        Icons.check_circle_outline_rounded,
        color: iconColor,
        size: 80,
      );
      break;
    case AlertType.error:
      backgroundColor = const Color(0xFFFF0000);
      icon = Icon(Icons.error_outline_rounded, color: iconColor, size: 80);
      break;
    case AlertType.warning:
      backgroundColor = const Color(0xFFE59400);
      icon = Icon(Icons.warning_rounded, color: iconColor, size: 80);
      break;
    case AlertType.progress:
      backgroundColor = const Color(0xFFE59400);
      icon = Icon(Icons.hourglass_empty_rounded, color: iconColor, size: 50);
      paddingVal = 25;
      break;
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: titleColor),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                if (type == AlertType.progress)
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.amberAccent,
                      ),
                    ),
                  ),
                if (type != AlertType.progress)
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                Padding(padding: EdgeInsets.all(paddingVal), child: icon),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
                const SizedBox(height: 8),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (function != null) {
                  function(); // Execute the provided function
                } else {
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
              child: Text(_getButtonText(type)),
            ),
          ],
        ),
      );
    },
  );
}

String _getButtonText(AlertType type) {
  switch (type) {
    case AlertType.success:
      return 'OK';
    case AlertType.error:
      return 'Exit';
    case AlertType.warning:
      return 'OK';
    case AlertType.progress:
      return 'Cancel';
  }
}
