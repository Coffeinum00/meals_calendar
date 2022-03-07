import 'package:copy/logic/inventory_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Inventory extends StatelessWidget {
  const Inventory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Center(
              child: ListView(
                padding: EdgeInsets.all(8.0),
                children: [
                  ...Provider.of<InventoryProvider>(context, listen: true)
                      .breakfast!
                      .map((e) => Text(e['Breakfast']))
                      .toList(),
                  ...Provider.of<InventoryProvider>(context, listen: true)
                      .dinner!
                      .map((e) => Text(e['Dinner']))
                      .toList(),
                  ...Provider.of<InventoryProvider>(context, listen: true)
                      .lunch!
                      .map((e) => Text(e['Lunch']))
                      .toList(),
                ],
                shrinkWrap: true,
              ),
            ),
            Row(
              children: [
                ElevatedButton(onPressed: () {}, child: Icon(Icons.add_circle)),
                ElevatedButton(
                    onPressed: () {}, child: Icon(Icons.remove_circle)),
              ],
            )
          ],
        ));
  }
}
