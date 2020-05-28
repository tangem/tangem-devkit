import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class TextStreamController {
  final TextEditingController controller = TextEditingController();

  Subject<String> _subject;
  StreamSubscription _subscription;
  String _currentValue = "";

  TextStreamController(this._subject) {
    initController();
    initSubscription();
  }

  initController() {
    controller.addListener(() {
      final value = controller.text;
      if (value == _currentValue) return;

      _currentValue = value;
      _subject.add(_currentValue);
    });
  }

  initSubscription() {
    _subscription = _subject.listen((value) {
      if (value == _currentValue) return;

      controller.text = value;
    });
  }

  dispose() {
    _subscription?.cancel();
    controller.dispose();
  }
}
