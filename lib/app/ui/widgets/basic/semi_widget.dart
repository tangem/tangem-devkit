import 'package:devkit/commons/utils/app_attributes.dart';
import 'package:flutter/material.dart';

class StubWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(width: 0, height: 0);
}

class HorizontalDelimiter extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(height: 1, decoration: BoxDecoration(color: AppColor.listDelimiter));
}
