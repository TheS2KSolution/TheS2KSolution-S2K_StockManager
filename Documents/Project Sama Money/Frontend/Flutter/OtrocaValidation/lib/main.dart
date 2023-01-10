import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sama/screen/choose.dart';
import 'package:sama/screen/myHomePage.dart';
import 'package:sama/service/ride_service/ride_data.dart';
import 'package:sama/service/vehicle_service/vehicle_data.dart';

import 'service/address_service/address_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AddressData(),
        ),
        ChangeNotifierProvider(
          create: (context) => RideData(),
        ),
        ChangeNotifierProvider(
          create: (context) => VehicleData(),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: Center(
            child: ChooseSceen(),
          ),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
