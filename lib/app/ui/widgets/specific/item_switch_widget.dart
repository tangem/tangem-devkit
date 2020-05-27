import 'dart:async';

import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/extensions/export.dart';
import 'package:devkit/commons/utils/app_attributes.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SwitchWidget extends StatelessWidget {
  final String keyName;
  final String title;
  final String description;
  final BehaviorSubject<bool> bSubject;
  final bool initialData;

  const SwitchWidget(
    this.keyName,
    this.title,
    this.bSubject, {
    this.description,
    this.initialData = false,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: AppDimen.itemMinHeight),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ExSwitch(keyName, title, bSubject, initialData),
          DescriptionWidget(description),
        ],
      ),
    ).padding16();
  }
}

class ExSwitch extends StatefulWidget {
  final String keyName;
  final String title;
  final BehaviorSubject<bool> bSubject;
  final bool initialData;

  const ExSwitch(this.keyName, this.title, this.bSubject, this.initialData);

  @override
  _ExSwitchState createState() => _ExSwitchState();
}

class _ExSwitchState extends State<ExSwitch> {
  bool _isChecked;
  StreamSubscription<bool> subscription;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialData ?? false;
    subscription = widget.bSubject.listen((value) {
      if (this.mounted) setState(() => _isChecked = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onWidgetTap(!_isChecked),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(child: TextWidget(widget.title)),
            Expanded(flex: 1, child: Container()),
            Switch(value: _isChecked, onChanged: _onWidgetTap),
          ],
        ),
      ),
    );
  }

  _onWidgetTap(bool isChecked) {
    widget.bSubject.add(isChecked);
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }
}
