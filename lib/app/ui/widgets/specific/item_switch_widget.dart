import 'dart:async';

import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/extensions/app_extensions.dart';
import 'package:devkit/commons/utils/app_attributes.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SwitchWidget extends StatelessWidget {
  final String keyName;
  final String title;
  final String description;
  final BehaviorSubject<bool> bSubject;
  // the value of initialData doesn't trigger the bSubject
  final bool initialData;
  final double minHeight;

  const SwitchWidget(
    this.keyName,
    this.title,
    this.description,
    this.bSubject, {
    this.initialData = false,
    this.minHeight = AppDimen.itemMinHeight,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight),
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
  final bool? initialData;

  const ExSwitch(this.keyName, this.title, this.bSubject, this.initialData);

  @override
  _ExSwitchState createState() => _ExSwitchState();
}

class _ExSwitchState extends State<ExSwitch> {
  late bool _isChecked;
  late StreamSubscription<bool> subscription;

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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextWidget(widget.title, fontSize: AppDimen.itemTextSize, maxLines: 2),
              ),
            ),
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
    subscription.cancel();
    super.dispose();
  }
}
