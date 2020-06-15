import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:flutter/material.dart';

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

  Widget goneByStream(Stream<bool> isVisibleStream, [bool isGone = false]) {
    return StreamBuilder<bool>(
      stream: isVisibleStream,
      initialData: isGone,
      builder: (context, snapshot) => snapshot.data ? this : this.gone(isGone: true),
    );
  }

  Widget underline() => Column(children: <Widget>[this, HorizontalDelimiter()]);

  Widget withUnderline([bool withUnderline = true]) => withUnderline ? underline() : this;
}
