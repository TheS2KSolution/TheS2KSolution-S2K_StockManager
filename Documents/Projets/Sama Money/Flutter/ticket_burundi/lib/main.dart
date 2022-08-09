import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ticket_burundi/services/validation_service.dart';
import 'package:ticket_burundi/splash/splash_screen.dart';
import 'package:ticket_burundi/utilities/routes.dart';
import 'package:ticket_burundi/utilities/themes.dart';

final serviceLocator = GetIt.instance; // GetIt.I is also valid
void setUp() {
  serviceLocator
      .registerLazySingleton<ValidationService>(() => ValidationService());
  // register more instances
}

void main() {
  setUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ticket Burundi',
      theme: ThemeData(
        inputDecorationTheme: inputDecorationTheme(),
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      initialRoute: SplashScreen.routeName,
    );
  }
}
