import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class TextStreamController {
  final TextEditingController controller = TextEditingController();
  final List<RegExp> regExpList;

  Subject<String> _subject;
  StreamSubscription _subscription;
  String _currentValue = "";
  bool fromStream = false;
  bool fromController = false;

  TextStreamController(this._subject, [this.regExpList]) {
    initController();
    initSubscription();
  }

  initController() {
    controller.addListener(() {
      if (fromStream) {
        fromStream = false;
        return;
      }

      String value = controller.text;
      final regExpValue = _applyRegExp(value);
      if (regExpValue != value) {
        final selection = TextSelection.collapsed(offset: controller.selection.start - 1);
        controller.value = controller.value.copyWith(text: regExpValue, selection: selection);
        return;
      }
      if (regExpValue == _currentValue) return;

      _currentValue = value;
      fromController = true;
      _subject.add(_currentValue);
    });
  }

  initSubscription() {
    _subscription = _subject.listen((value) {
      if (fromController) {
        fromController = false;
        return;
      }

      final regExpValue = _applyRegExp(value);
      if (regExpValue == _currentValue) return;

      fromStream = true;
      _currentValue = regExpValue;
      controller.text = regExpValue;
    });
  }

  String _applyRegExp(String value) {
    String regExpValue = value;
    regExpList.forEach((regExp) {
      regExpValue = regExp.allMatches(regExpValue).map<String>((Match match) => match.group(0)).join();
    });
    return regExpValue;
  }

  dispose() {
    _subscription?.cancel();
    controller.dispose();
  }
}
