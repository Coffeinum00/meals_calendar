import 'package:flutter/foundation.dart';

class ScreensProvider extends ChangeNotifier {
  void _init() {
    _currentIndex = 0;
  }

  ScreensProvider() {
    _init();
  }

  int? _currentIndex;
  int? get currentIndex => _currentIndex;

  set currentIndex(int? newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}
