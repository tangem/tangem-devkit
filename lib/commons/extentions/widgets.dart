import 'package:flutter/material.dart';

extension Wrapper on Widget {
  visibility(Stream<bool> stream, [bool initialData = true]) {
    return StreamBuilder(
      stream: stream,
      initialData: initialData,
      builder: (context, snapshot) {
        return Visibility(
          visible: snapshot.data,
          child: this,
        );
      },
    );
  }
}
