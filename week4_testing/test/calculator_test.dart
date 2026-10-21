import 'package:test/test.dart';
import 'package:week4_testing/calculator.dart';

void main() {
  group('Calculator Tests', () {
    test('Addition test', () {
      expect(add(2, 3), equals(5));
      expect(add(-1, 1), equals(0));
    });

    test('Subtraction test', () {
      expect(subtract(5, 3), equals(2));
    });

    test('Multiplication test', () {
      expect(multiply(4, 3), equals(12));
    });

    test('Division test', () {
      expect(divide(10, 2), equals(5.0));
      // Test exception for division by zero
      expect(() => divide(10, 0), throwsArgumentError);
    });

    test('IsEven test', () {
      expect(isEven(4), isTrue);
      expect(isEven(7), isFalse);
    });

    test('IsEven edge cases', () {
      expect(isEven(0), isTrue);
      expect(isEven(-2), isTrue);
      expect(isEven(-3), isFalse);
    });

    test('Max of Three test', () {
      expect(maxOfThree(5, 12, 9), equals(12));
    });

    test('Max of Three edge cases', () {
      expect(maxOfThree(5, 5, 5), equals(5));
      expect(maxOfThree(-1, -5, -3), equals(-1));
    });
  });
  group('Student Grade Calculator Tests', () {
      test('Test exact grade boundaries and levels', () {
        expect(calculateGrade(100), equals('A')); // Edge case max
        expect(calculateGrade(80), equals('A'));  // Boundary A
        expect(calculateGrade(79), equals('B'));  // Just below A
        expect(calculateGrade(70), equals('B'));  // Boundary B
        expect(calculateGrade(69), equals('C'));  // Just below B
        expect(calculateGrade(60), equals('C'));  // Boundary C
        expect(calculateGrade(59), equals('D'));  // Just below C
        expect(calculateGrade(50), equals('D'));  // Boundary D
        expect(calculateGrade(49), equals('F'));  // Just below D
        expect(calculateGrade(0), equals('F'));   // Edge case min
      });

      test('Test invalid score inputs throwing errors', () {
        expect(() => calculateGrade(-1), throwsArgumentError);   // Negative score
        expect(() => calculateGrade(101), throwsArgumentError);  // Score above 100
      });
    });
}
