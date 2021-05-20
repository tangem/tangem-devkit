import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/application.dart';
import 'package:devkit/commons/utils/app_attributes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String? hint;
  final double minHeight;

  const TestInputWidget(
    this.controller, {
    this.hint,
    this.inputType = TextInputType.text,
    this.minHeight = 58,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight),
        child: TextField(
          controller: controller,
          keyboardType: inputType,
          decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 5), labelText: hint, isDense: true),
          style: TextStyle(fontSize: AppDimen.itemTextSize),
        ),
      ),
    );
  }
}

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

class StateRecordingWidget extends StatelessWidget {
  final Widget recordActiveWidget;
  final Widget recordInActiveWidget;

  StateRecordingWidget(this.recordActiveWidget, [Widget? recordInActiveWidget, Key? key])
      : this.recordInActiveWidget = recordInActiveWidget ?? StubWidget(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final recorder = context.read<ApplicationContext>().testRecorderBloc;
    return StreamBuilder<bool>(
      stream: recorder.bsRecordingState.stream,
      builder: (context, snapshot) {
        if (snapshot.data == null || !snapshot.data!) return recordInActiveWidget;

        return recordActiveWidget;
      },
    );
  }
}
