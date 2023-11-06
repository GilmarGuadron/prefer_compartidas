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
  // Método para guardar el tema seleccionado
  Future<void> saveThemePreference(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
  }
  // Método para obtener el tema guardado
  Future<bool> getThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDarkMode') ?? false; 
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Preferencias compartidas, ejemplo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Tema Oscuro'),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                   // Guarda el tema seleccionado
                  saveThemePreference(isDarkMode);
                },
                
              ),
              ElevatedButton(
  onPressed: () {
    final prefs = SharedPreferences.getInstance();
    prefs.then((preferences) {
      preferences.remove('isDarkMode');
    });

    setState(() {
      isDarkMode = false;
    });
  },
  child: Text('Quitar Configuración del Tema'),
),

              
            ],
          ),
        ),
      ),
    );
  }
  
  void resetThemePreference() {}
}

