import 'dart:async';

import 'package:devkit/app/domain/actions_bloc/abstracts.dart';
import 'package:devkit/app/ui/screen/response/response_screen.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:flutter/material.dart';

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
    widget.messageStreams.forEach((element) => _subscriptions.add(element.listen((event) => showJsonSnackbar(context, event))));
  }

  @override
  Widget build(BuildContext context) => StubWidget();

  @override
  void dispose() {
    super.dispose();
    _subscriptions.forEach((element) => element.cancel());
  }
}
