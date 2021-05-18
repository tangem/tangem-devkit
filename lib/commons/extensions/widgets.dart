import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/utils/exp_utils.dart';
import 'package:flutter/material.dart';

import '../common_abstracts.dart';

extension Wrapper on Widget {
  Widget bg(Color color) => Container(decoration: BoxDecoration(color: color), child: this);

  Widget padding(EdgeInsets edgeInsets) => Padding(padding: edgeInsets, child: this);

  Widget padding16() => this.padding(EdgeInsets.all(16));

  Widget paddingH16() => this.padding(EdgeInsets.symmetric(horizontal: 16));

  Widget paddingV16() => this.padding(EdgeInsets.symmetric(vertical: 16));

  Widget gone({bool isGone = true}) {
    return Visibility(
      visible: !isGone,
      maintainState: true,
      maintainAnimation: true,
//      maintainSemantics: true,
      child: this,
    );
  }

  Widget visibility(bool isVisible) {
    return Visibility(
      visible: isVisible,
      maintainState: true,
      maintainAnimation: true,
      maintainSize: true,
      child: this,
    );
  }

  Widget underline() => Column(children: <Widget>[this, HorizontalDelimiter()]);

  Widget withUnderline([bool withUnderline = true]) => withUnderline ? underline() : this;

  Widget visibilityHandler(StatedBehaviorSubject<bool> bSubject) {
    return StreamBuilder<bool>(
      initialData: bSubject.state,
      stream: bSubject.stream,
      builder: (context, snapshot) {
        logD(this, "state: ${snapshot.data}");
        return snapshot.data ?? false ? this : this.gone();
      },
    );
  }
}
