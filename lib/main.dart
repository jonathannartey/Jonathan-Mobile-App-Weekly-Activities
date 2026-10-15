// AI-assisted: Generated with ChatGPT on 14 October 2026. Modified by Jonathan Nartey.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'INFT 425',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with your name
      appBar: AppBar(
        title: const Text('INFT 425 - Jonathan Nartey'),
        backgroundColor: const Color.fromARGB(255, 185, 154, 191),
      ),
      // Body is a centered column
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Main greeting text
            Text(
              'Hello World',
              style: TextStyle(
                fontSize: 36, // changed from 40 to 36
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 68, 54, 70), // changed from blue to purple
              ),
            ),
            SizedBox(height: 20),
            // Flutter icon
            Icon(
              Icons.code,
              size: 50,
              color: Colors.green,
            ),
            SizedBox(height: 20),
            // Department name
            Text(
              'Department of Computing Sciences and Engineering',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Extra widget I added
            Icon(
              Icons.school,
              size: 40,
              color: Color.fromARGB(255, 160, 134, 95),
            ),
          ],
        ),
      ),
    );
  }
}