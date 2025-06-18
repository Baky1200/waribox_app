import 'package:flutter/material.dart';
import 'screens/navigation_root.dart';

import 'routes/app_routes.dart';



void main() {
  runApp(WariboxApp());
}

class WariboxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waribox',
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: NavigationRoot(),
    );
  }
}
