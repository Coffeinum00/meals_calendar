import 'dart:io';

import 'package:animations/animations.dart';
import 'package:copy/logic/inventory_provider.dart';
import 'package:copy/screen/event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;

  final TextEditingController _eventController = TextEditingController();

  Map<DateTime, List<Event>>? selectedEvents;

  @override
  void initState() {
    selectedEvents = {_selectedDay: []};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents?[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2022, 02, 01),
            lastDay: DateTime.utc(2022, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            //           eventLoader: (day) {

            //  return  [
            //       Event(
            //         title: 'Sniadanie',
            //       ),
            //       Event(
            //         title: 'Sniadanie',
            //       ),
            //       Event(
            //         title: 'Sniadanie',
            //       )
            //     ];

            //           },
            eventLoader: _getEventsfromDay,
            calendarStyle: CalendarStyle(
              markerDecoration: const BoxDecoration(
                color: Colors.yellow,
                shape: BoxShape.circle,
              ),
            ),
          ),
          ...[
            staticContent('Breakfast'),
            staticContent('Lunch'),
            staticContent('Dinner')
          ],
          ..._getEventsfromDay(_selectedDay).map(
            (Event event) => Padding(
              padding: const EdgeInsets.all(3.0),
              child: ListTile(
                onTap: () {},
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2, color: Colors.teal),
                    borderRadius: BorderRadius.circular(20.0)),
                title: Text(event.title!),
                trailing: OpenContainer(
                  closedBuilder:
                      (BuildContext context, void Function() action) {
                    return Container(
                      height: 50,
                      child: Text('eloszka'),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.teal, width: 4.0)),
                    );
                  },
                  openBuilder: (BuildContext context,
                      void Function({Object? returnValue}) action) {
                    return Container(
                      height: 50,
                      width: 50,
                      color: Colors.cyan,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Add meal'),
            content: TextFormField(
              controller: _eventController,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (_eventController.text.isEmpty) {
                  } else {
                    if (selectedEvents![_selectedDay] != null) {
                      selectedEvents![_selectedDay]!.add(
                        Event(title: _eventController.text),
                      );
                    } else {
                      selectedEvents![_selectedDay] = [
                        Event(title: _eventController.text)
                      ];
                    }
                  }
                  Navigator.pop(context);
                  _eventController.clear();
                  setState(() {});
                  return;
                },
                child: const Text('ok'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('cancel'),
              ),
            ],
          ),
        ),
        label: const Text('Add meal'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget staticContent(String text) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ListTile(
        onTap: () {},
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 2, color: Colors.teal),
            borderRadius: BorderRadius.circular(20.0)),
        title: Text(text),
        trailing: OpenContainer(
          closedBuilder: (BuildContext context, void Function() action) {
            return Container(
              height: 50,
              child: Text('eloszka'),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.teal, width: 4.0)),
            );
          },
          openBuilder: (BuildContext context,
              void Function({Object? returnValue}) action) {
            return Container(
                height: 50,
                width: 50,
                color: Colors.cyan,
                child: ListView(
                  children: [
                    ...Provider.of<InventoryProvider>(context, listen: false)
                        .meals!
                        .where((element) => element.containsKey(text))
                        .toList()
                        .map(
                          (e) => ListTile(
                            tileColor: Colors.green,
                            title: Text(e[text]),
                            onTap: () {
                              print('love you');
                            },
                          ),
                        ),
                  ],
                ));
          },
        ),
      ),
    );
  }
}
