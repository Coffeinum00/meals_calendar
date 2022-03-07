// import 'dart:math';
import 'package:copy/logic/inventory_provider.dart';
import 'package:copy/screen/home.dart';
import 'package:provider/provider.dart';

import 'package:copy/logic/screens_provider.dart';
import 'package:copy/screen/calendar.dart';
import 'package:copy/screen/inventory.dart';
import 'package:copy/screen/shopping.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScreensProvider()),
        ChangeNotifierProvider(create: (_) => InventoryProvider()),
      ],
      child: MaterialApp(
        title: 'Calendar AppBar Example App',
        home: Home(),
      ),
    );
  }
}
