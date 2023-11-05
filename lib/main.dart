import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    // Recupera la configuración del tema al iniciar la aplicación
    getThemePreference().then((value) {
      setState(() {
        isDarkMode = value;
      });
    });
  }
}