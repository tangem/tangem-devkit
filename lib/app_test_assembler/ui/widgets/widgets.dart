import 'package:flutter/material.dart';

class SimpleFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(BuildContext context) stubBuilder;
  final Widget Function(BuildContext context, T data) builder;
  final T? initialData;

  const SimpleFutureBuilder(this.future, this.stubBuilder, this.builder, {Key? key, this.initialData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
        future: future,
        initialData: initialData,
        builder: (context, snapshot) => (snapshot.connectionState != ConnectionState.done && !snapshot.hasData)
            ? stubBuilder(context)
            : builder(context, snapshot.data!));
  }
}

class CenterLoadingText extends StatelessWidget {
  @override
  Widget build(BuildContext context) => CenterText("Loading...");
}

class CenterText extends StatelessWidget {
  final String text;

  const CenterText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(child: Text(text));
}

class TabTextIconWidget extends StatelessWidget {
  final Icon icon;
  final Text text;

  const TabTextIconWidget(this.icon, this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [icon, SizedBox(width: 8), text],
      ),
    );
  }
}
