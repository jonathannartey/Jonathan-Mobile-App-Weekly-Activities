// AI-assisted: Generated with [Copilot] on [14/10/2026]. Modified by [Jonathan Nartey].
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'INFT 425',
      debugShowCheckedModeBanner: false,

      // Enable Material 3 and use a blue color scheme
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),

      home: const HomePage(),
    );
  }
}

/// Main screen widget
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar displayed at the top of the screen
      appBar: AppBar(
        title: const Text('INFT 425 - Jonathan Nartey'),
      ),

      // Body of the Scaffold
      body: Center(
        // Center widget keeps the Column in the middle of the screen
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hello World text styled in green, bold, and 35pt
            const Text(
              'Hello World',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 135, 76, 175),
              ),
            ),

            const SizedBox(height: 16),

            // Flutter-related code icon
            const Icon(
              Icons.code,
              color: Color.fromARGB(255, 99, 76, 175),
              size: 50,
            ),

            const SizedBox(height: 12),

            // School icon displayed in red
            const Icon(
              Icons.school,
              color: Colors.red,
              size: 45,
            ),

            const SizedBox(height: 16),

            // Department name displayed as centered italic text
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Department of Computing Sciences and Information Technology',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}