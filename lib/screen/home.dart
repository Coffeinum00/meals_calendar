import 'package:copy/logic/screens_provider.dart';
import 'package:copy/screen/calendar.dart';
import 'package:copy/screen/inventory.dart';
import 'package:copy/screen/shopping.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final List<Widget> screens = [
    Calendar(),
    Inventory(),
    Shopping(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          Provider.of<ScreensProvider>(context, listen: false).currentIndex =
              index;
        },
        currentIndex: Provider.of<ScreensProvider>(context).currentIndex!,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.today), label: 'Calendar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted), label: 'Inventory'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket), label: 'Shopping list'),
        ],
      ),
      body: screens[Provider.of<ScreensProvider>(context).currentIndex!],
    );
  }
}
