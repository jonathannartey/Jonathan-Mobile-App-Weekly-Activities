import 'package:flutter/material.dart';

/// Standard typography roles used across the app.
/// Import this and use the helper to build Text widgets.
class AppText {
  static Text display(BuildContext c, String s) =>
      Text(s, style: Theme.of(c).textTheme.displaySmall);
      
  static Text headline(BuildContext c, String s) =>
      Text(s, style: Theme.of(c).textTheme.headlineSmall);
      
  static Text title(BuildContext c, String s) =>
      Text(s, style: Theme.of(c).textTheme.titleLarge);
      
  static Text subtitle(BuildContext c, String s) =>
      Text(s, style: Theme.of(c).textTheme.titleMedium);
      
  static Text body(BuildContext c, String s) =>
      Text(s, style: Theme.of(c).textTheme.bodyLarge);
      
  static Text caption(BuildContext c, String s) =>
      Text(s, style: Theme.of(c).textTheme.bodySmall);
}