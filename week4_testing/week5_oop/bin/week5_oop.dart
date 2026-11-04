// Week 5 Lab: Complete Object-Oriented Programming (OOP) in Dart
// Author: Jonathan Narwotey Nartey

// 1. Mixin: Provides reusable logging functionality without strict inheritance
mixin Logger {
  void log(String message) {
    print("[SYSTEM LOG - ${DateTime.now().hour}:${DateTime.now().minute}]: $message");
  }
}

// 2. Abstract Class: Cannot be instantiated directly, acts as a blueprint
abstract class Report {
  String title;

  Report(this.title);

  // Abstract method (must be implemented by subclasses)
  void generate();
}

// 3. Superclass (Parent Class)
class Student {
  String name;
  String studentId;
  double gpa;

  Student({
    required this.name,
    required this.studentId,
    required this.gpa,
  });

  void displayProfile() {
    print("Name: $name | ID: $studentId | GPA: $gpa");
  }
}

// 4. Subclass extending Student, implementing Report, and mixing in Logger
class UndergraduateStudent extends Student with Logger implements Report {
  int yearLevel;
  bool hasCompletedAttachment;
  @override
  String title;

  UndergraduateStudent({
    required String name,
    required String studentId,
    required double gpa,
    required this.yearLevel,
    required this.hasCompletedAttachment,
    required this.title,
  }) : super(name: name, studentId: studentId, gpa: gpa);

  // Overriding parent profile method
  @override
  void displayProfile() {
    log("Fetching profile details for $name...");
    super.displayProfile();
    print("Year Level: Level $yearLevel | Internship Completed: $hasCompletedAttachment");
  }

  // Implementing abstract method from Report
  @override
  void generate() {
    log("Generating official academic report...");
    print("=== $title ===");
    displayProfile();
    print("Standing: ${gpa >= 3.5 ? 'First Class Honors 🎓' : 'Regular Standing'}\n");
  }
}

void main() {
  print("=========================================");
  print("INFT 425: Week 5 OOP Lab Execution");
  print("=========================================\n");

  // Creating an instance of UndergraduateStudent
  UndergraduateStudent studentReport = UndergraduateStudent(
    name: "Jonathan Narwotey Nartey",
    studentId: "224IT01001233",
    gpa: 3.85,
    yearLevel: 400,
    hasCompletedAttachment: true,
    title: "Semester Academic Performance Audit",
  );

  // Executing methods
  studentReport.generate();
}