import 'package:flutter/material.dart';

extension SnackBarExtension on BuildContext {
  void showSnackBar(String message,
      {Duration duration = const Duration(seconds: 2)}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color(0xFF2C4858),
        content: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            message,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500),
          )
        ),
        duration: duration,
      ),
    );
  }
}

extension NavigationExtension on BuildContext {
  void navigateTo(Widget screen) {
    Navigator.of(this).push(MaterialPageRoute(builder: (_) => screen));
  }

  Future<T?> pushPage<T>(Widget screen) {
    return Navigator.of(this)
        .push<T>(MaterialPageRoute(builder: (_) => screen));
  }

  void replaceWith(Widget screen) {
    Navigator.of(this)
        .pushReplacement(MaterialPageRoute(builder: (_) => screen));
  }

  void navigateBack() {
    Navigator.of(this).pop();
  }
}
