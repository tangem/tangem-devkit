import 'dart:async';

import 'package:devkit/app/domain/actions_bloc/abstracts.dart';
import 'package:devkit/app/ui/screen/response/response_screen.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/app_test_assembler/domain/bloc/test_recorder_bloc.dart';
import 'package:devkit/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HiddenResponseHandlerWidget extends StatelessWidget {
  final ActionBloc _bloc;

  HiddenResponseHandlerWidget(this._bloc);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        StreamBuilder(
          stream: _bloc.successResponseStream,
          initialData: null,
          builder: (context, snapshot) {
            final widget = StubWidget();
            if (snapshot.data == null) return widget;

            Future.delayed(Duration(milliseconds: 100), () => ResponseScreen.navigate(context, snapshot.data));
            return widget;
          },
        ),
        StreamBuilder(
          stream: _bloc.errorResponseStream,
          initialData: null,
          builder: (context, snapshot) {
            final widget = StubWidget();
            if (snapshot.data == null) return widget;

            Future.delayed(Duration(milliseconds: 100), () => showJsonSnackbar(context, snapshot.data));
            return widget;
          },
        ),
      ],
    );
  }
}

class HiddenSnackbarHandlerWidget extends StatefulWidget {
  final List<Stream> messageStreams;

  const HiddenSnackbarHandlerWidget(this.messageStreams);

  @override
  _HiddenSnackbarHandlerWidgetState createState() => _HiddenSnackbarHandlerWidgetState();
}

class _HiddenSnackbarHandlerWidgetState extends State<HiddenSnackbarHandlerWidget> {
  List<StreamSubscription> _subscriptions = [];

  @override
  void initState() {
    super.initState();
    widget.messageStreams.forEach((element) => _subscriptions.add(element.listen(
          (event) => showJsonSnackbar(context, event),
        )));
  }

  @override
  Widget build(BuildContext context) => StubWidget();

  @override
  void dispose() {
    _subscriptions.forEach((element) => element.cancel());
    super.dispose();
  }
}

class HiddenTestRecorderWidget extends StatefulWidget {
  final ActionBloc _actionBloc;

  const HiddenTestRecorderWidget(this._actionBloc, {Key? key}) : super(key: key);

  @override
  _HiddenTestRecorderWidgetState createState() => _HiddenTestRecorderWidgetState();
}

class _HiddenTestRecorderWidgetState extends State<HiddenTestRecorderWidget> {
  final List<StreamSubscription> _subscriptions = [];
  late final TestRecorderBlock _recorder;

  @override
  void initState() {
    super.initState();
    _recorder = context.read<ApplicationContext>().testRecorderBloc;
    _subscriptions.add(widget._actionBloc.commandDataStream.listen(_recorder.handleCommand));
    _subscriptions.add(widget._actionBloc.successResponseStream.listen(_recorder.handleCommandResponse));
    _subscriptions.add(widget._actionBloc.errorResponseStream.listen(_recorder.handleCommandError));
  }

  @override
  Widget build(BuildContext context) => StubWidget();

  @override
  void dispose() {
    _subscriptions.forEach((element) => element.cancel());
    super.dispose();
  }
}
