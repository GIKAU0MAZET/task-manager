import 'package:flutter/material.dart';

abstract class AppRouterKey {
  static final rootKey = GlobalKey<NavigatorState>();
  static final signKey = GlobalKey<NavigatorState>();
  static final dashboardKey = GlobalKey<NavigatorState>();
}