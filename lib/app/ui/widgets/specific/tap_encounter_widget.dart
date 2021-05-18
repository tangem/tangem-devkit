import 'dart:async';

import 'package:flutter/material.dart';

class TapEncounterWidget extends StatefulWidget {
  final Function? onSuccess;
  final int maxTapCount;
  final Widget child;

  const TapEncounterWidget(this.maxTapCount, this.child, {this.onSuccess});

  @override
  _TapEncounterWidgetState createState() => _TapEncounterWidgetState();
}

class _TapEncounterWidgetState extends State<TapEncounterWidget> {
  Timer? _debounce;
  int tapCount = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: widget.child,
      onTap: _launch,
    );
  }

  _launch() {
    if (tapCount == widget.maxTapCount) {
      _debounce?.cancel();
      _resetCount();
      widget.onSuccess?.call();
      return;
    }

    if (_debounce?.isActive ?? false) {
      _incrementCount();
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 500), _resetCount);
  }

  _resetCount() {
    tapCount = 0;
  }

  _incrementCount() {
    tapCount += 1;
  }
}
