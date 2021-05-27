import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:flutter/material.dart';

class SimpleFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final WidgetBuilder stubBuilder;
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

class StubStreamBuilder<T> extends StatelessWidget {
  final Stream<T> stream;
  final T? initialData;
  final WidgetBuilder? stubBuilder;
  final Widget Function(BuildContext context, T data) builder;

  const StubStreamBuilder(this.stream, this.builder, {this.initialData, this.stubBuilder, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      initialData: initialData,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          if (stubBuilder == null)
            return StubWidget();
          else
            return stubBuilder!.call(context);
        }
        return builder(context, snapshot.data!);
      },
    );
  }
}
