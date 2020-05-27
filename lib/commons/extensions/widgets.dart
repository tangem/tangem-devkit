import 'package:flutter/material.dart';

extension Wrapper on Widget {
  Widget bg(Color color) => Container(decoration: BoxDecoration(color: color), child: this);

  Widget padding(EdgeInsets edgeInsets) => Padding(padding: edgeInsets, child: this);

  Widget padding16() => this.padding(EdgeInsets.all(16));

  Widget paddingH16() => this.padding(EdgeInsets.symmetric(horizontal: 16));

  Widget paddingV16() => this.padding(EdgeInsets.symmetric(vertical: 16));
}
