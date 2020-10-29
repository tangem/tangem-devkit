import 'dart:convert';

import 'package:devkit/app/domain/actions_bloc/test_bloc.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/text_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tangem_sdk/sdk_plugin.dart';

import '../finders.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  TestBlock _bloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) {
          _bloc = TestBlock();
          return _bloc;
        })
      ],
      child: TestFrame(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class TestFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = RepoFinder.createTestBloc(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Auto Testing"),
        // actions: [Menu.popupDescription()],
      ),
      body: TestBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: bloc.invokeAction,
      ),
    );
  }
}

class TestBody extends StatefulWidget {
  @override
  _TestBodyState createState() => _TestBodyState();
}

class _TestBodyState extends State<TestBody> {
  TestBlock _bloc;
  TextStreamController _inputCommandController;

  @override
  void initState() {
    super.initState();

    _bloc = RepoFinder.createTestBloc(context);
    _inputCommandController = TextStreamController(_bloc.inputCommandSubject);
    // _inputCommandController.controller.text = TestJson.writeIssuerExData;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextWidget.center("Input command"),
        HorizontalDelimiter(),
        Expanded(
          flex: 5,
          child: TextField(
            key: ItemId.from(ItemName.responseErrorJson),
            controller: _inputCommandController.controller,
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
        ),
        HorizontalDelimiter(),
        Container(
          decoration: BoxDecoration(color: Colors.lightGreen, border: Border.all(color: Colors.green)),
          child: TextWidget.center("Success Response"),
        ),
        HorizontalDelimiter(),
        StreamBuilder(
          stream: _bloc.successResponseStream,
          initialData: null,
          builder: (context, snapshot) {
            if (snapshot.data == null) return Expanded(flex: 1, child: StubWidget());

            final jsonData = json.encode(snapshot.data);
            return Expanded(
              flex: 10,
              child: SingleChildScrollView(
                child: TextWidget(jsonData, keyName: ItemName.responseSuccessJson),
              ),
            );
          },
        ),
        HorizontalDelimiter(),
        Container(
          decoration: BoxDecoration(color: Colors.redAccent, border: Border.all(color: Colors.red)),
          child: TextWidget.center("Error Response"),
        ),
        HorizontalDelimiter(),
        StreamBuilder(
          stream: _bloc.errorResponseStream,
          initialData: null,
          builder: (context, snapshot) {
            final data = snapshot.data;
            final stub = Expanded(flex: 1, child: SingleChildScrollView(child: StubWidget()));
            if (data == null) return stub;

            if (data is TangemSdkError) {
              Fluttertoast.showToast(msg: data.message, toastLength: Toast.LENGTH_LONG);
              return stub;
            } else {
              return Expanded(
                flex: 10,
                child: TextWidget(snapshot.data.message, keyName: ItemName.responseErrorJson),
              );
            }
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _inputCommandController.dispose();
    super.dispose();
  }
}
