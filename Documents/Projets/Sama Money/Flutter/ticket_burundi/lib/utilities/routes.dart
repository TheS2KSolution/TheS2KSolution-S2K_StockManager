import 'package:flutter/material.dart';
import 'package:ticket_burundi/home/home_screen.dart';
import 'package:ticket_burundi/register/register_screen.dart';
import 'package:ticket_burundi/saisi-code/saisi_code_screen.dart';
import 'package:ticket_burundi/splash/splash_screen.dart';
import 'package:ticket_burundi/state-page/state_page_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  SaisiCodeScreen.routeName: (context) => const SaisiCodeScreen(),
  RegisterScreen.routeName: (context) => const RegisterScreen(),
  StatePAgeScreen.routeName: (context) => const StatePAgeScreen()
};
