import 'package:flutter/material.dart';

@immutable
class RouteLocation{
  const RouteLocation._();
  static String get onboardingscreen => '/onboardingscreen';
  static String get splashscreen => '/splashscreen';
  static String get home => '/home';
  static String get createtask => '/createtask';
}