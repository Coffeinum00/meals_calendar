import 'package:flutter/foundation.dart';

class InventoryProvider extends ChangeNotifier {
  void _init() {
    _breakfast = [
      {'Breakfast': 'eggs'},
      {'Breakfast': 'scrambled eggs'}
    ];

    _lunch = [
      {'Lunch': 'greek salad'},
      {'Lunch': 'egg salad'},
      {'Lunch': 'blt sandwich'},
    ];

    _dinner = [
      {'Dinner': 'chicken roast'},
      {'Dinner': 'carbonara'},
      {'Dinner': 'chinese noodles'},
    ];

    _meals = [..._lunch!, ..._dinner!, ..._breakfast!];
  }

  InventoryProvider() {
    _init();
  }

  List? _breakfast;
  List? get breakfast => _breakfast;
  set breakfast(List? newBreakfast) {
    _breakfast = newBreakfast;
    notifyListeners();
  }

  List? _lunch;
  List? get lunch => _lunch;
  set lunch(List? newLunch) {
    _lunch = newLunch;
    notifyListeners();
  }

  List? _dinner;
  List? get dinner => _dinner;
  set dinner(List? newDinner) {
    _dinner = newDinner;
    notifyListeners();
  }

  List? _meals;
  List? get meals => _meals;
  set meals(List? newMeals) {
    _meals = newMeals;
    notifyListeners();
  }
}
