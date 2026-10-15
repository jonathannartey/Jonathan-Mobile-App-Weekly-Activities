// AI-assisted: Generated with Gemini on October 15, 2026. Modified by Jonathan Narwotey Nartey.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Main application widget using Material 3
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'INFT 425 App',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

// Home screen widget displaying the layout components
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar titled as required by course instructions
      appBar: AppBar(
        title: const Text('INFT 425 - Jonathan Narwotey Nartey'),
        backgroundColor: Colors.purple.shade100,
      ),
      // Centered column containing text, icons, and custom widgets
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hello World text in 36pt bold purple (customized size & color)
            const Text(
              'Hello World',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 20),
            // Code icon in green, 50px
            const Icon(
              Icons.code,
              color: Colors.green,
              size: 50,
            ),
            const SizedBox(height: 20),
            // Department text in 16pt italic, centered
            const Text(
              'Department of Computing Sciences and Engineering',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20),
            // Extra added widget: A motivational subtitle
            const Text(
              'Building Mobile Apps with Flutter!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}