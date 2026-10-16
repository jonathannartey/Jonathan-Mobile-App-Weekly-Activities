# INFT 425 - Lab 1: Flutter Multi-Screen Navigation & Form Validation App

## Student Information
- **Name:** Jonathan Narwotey Nartey
- **Course Code:** INFT 425
- **Institution:** Valley View University (VVU)

---

## App Overview
This mobile application is built with Flutter and demonstrates core mobile development principles, including:
1. **Multi-Screen Navigation:** Seamless routing between multiple screens using Flutter's `Navigator` stack (`push`, `pop`, and `popUntil`).
2. **Form Validation:** Input validation ensuring required fields are populated before allowing users to proceed.
3. **Data Passing:** Dynamic passing of state and text data between screens (Home $\rightarrow$ Form $\rightarrow$ Success Screen).

---

## Screen Architecture
- **Screen 1 (Home Screen):** Welcomes the user and provides navigation to the registration form.
- **Screen 2 (Form Screen):** Features a validated text field for user input.
- **Screen 3 (Success Screen):** Displays a success confirmation message along with the user's submitted name.

---

## How to Run the App
1. Ensure Flutter is installed and configured (`flutter doctor`).
2. Connect an Android emulator or launch Chrome.
3. Run the following command in your terminal:
   ```bash
   flutter run