import 'package:flutter/material.dart';

class StubWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(width: 1, height: 1);
}

class HorizontalDelimiter extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(height: 1, decoration: BoxDecoration(color: Colors.grey[400]));
}
