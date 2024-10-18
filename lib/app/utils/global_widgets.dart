import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'theme_data.dart';

enum SnackbarType {
  success,
  warning,
  error,
}

final lightBlueGradient = [Colors.indigo.shade500, Colors.indigo.shade200];
final blueGradient = [const Color(0xFF1B90F7), Colors.blue.shade300];
final tealGradient = [const Color(0xFF00897B), Colors.teal.shade300];
final deepPurpleGradient = [const Color(0xFF7361F7), Colors.indigo.shade200];
final redGradient = [const Color(0xFFF8456C), Colors.red.shade200];
final cyanGradient = [Colors.cyan.shade700, Colors.cyan.shade300];
final orangeGradient = [Colors.orange[600]!, Colors.orange.shade200];

final textGradient = const LinearGradient(
  colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

const HEIGHT_06 = SizedBox(height: 6);
const HEIGHT_12 = SizedBox(height: 12);

void showSnackBar({
  required SnackbarType type,
  required String message,
  Duration? duration,
}) {
  final Color fontColor =
      type == SnackbarType.warning ? Colors.black : Colors.white;

  final Color bgColor = type == SnackbarType.success
      ? const Color(0xff28a745)
      : type == SnackbarType.warning
          ? const Color(0xffffc107)
          : const Color(0xffdc3545);
  Get.showSnackbar(
    GetSnackBar(
      message: message,
      messageText: Text(message, style: TextStyle(color: fontColor)),
      backgroundColor: bgColor,
      icon: type == SnackbarType.success
          ? Icon(Icons.check, color: fontColor)
          : Icon(Icons.error_outline, color: fontColor),
      duration: duration ?? 3.seconds,
      shouldIconPulse: false,
    ),
  );
}

void showSnackBarWithIcon(
    {required SnackbarType type,
    required String message,
    Icon? icon,
    Duration? duration,
    Widget? mainButton}) {
  final Color fontColor =
      type == SnackbarType.warning ? Colors.black : Colors.white;

  final Color bgColor = type == SnackbarType.success
      ? const Color(0xff28a745)
      : type == SnackbarType.warning
          ? const Color(0xffffc107)
          : const Color(0xffdc3545);
  Get.showSnackbar(
    GetSnackBar(
      message: message,
      messageText: Text(message, style: TextStyle(color: fontColor)),
      backgroundColor: bgColor,
      icon: icon ??
          (type == SnackbarType.success
              ? Icon(Icons.check, color: fontColor)
              : Icon(Icons.error_outline, color: fontColor)),
      duration: duration ?? 3.seconds,
      shouldIconPulse: false,
      mainButton: mainButton,
    ),
  );
}

const btnLoadingIndicator = SizedBox(
  height: 20,
  width: 20,
  child: CircularProgressIndicator(
    color: primaryColor,
    strokeWidth: 3,
  ),
);

class MandatoryLabel extends StatelessWidget {
  const MandatoryLabel({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: <InlineSpan>[
          WidgetSpan(
            child: Text(label),
          ),
          const WidgetSpan(
            child: Text(
              '*',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

getDrawer() {
  return Drawer();
}
