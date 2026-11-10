// AI-assisted: Generated with Gemini on 2026-02-26. Modified by Jonathan Narwotey Nartey.
import 'package:flutter/material.dart';

void main() {
  runApp(const StudentApp());
}

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Profile App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('INFT 425 - Jonathan Narwotey Nartey'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Profile Avatar
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 20),
            // Name
            const Text(
              'Jonathan Narwotey Nartey',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Student ID
            const Text(
              'ID: 224IT01001233',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Divider(),
            // Details Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.book, color: Colors.blue),
                      title: Text('Course'),
                      subtitle: Text('BSc Information Technology'),
                    ),
                    ListTile(
                      leading: Icon(Icons.school, color: Colors.green),
                      title: Text('Current Module'),
                      subtitle: Text('Week 6: Flutter UI & Layouts'),
                    ),
                    ListTile(
                      leading: Icon(Icons.star, color: Colors.amber),
                      title: Text('Academic Standing'),
                      subtitle: Text('First Class Honors (GPA: 3.85)'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}