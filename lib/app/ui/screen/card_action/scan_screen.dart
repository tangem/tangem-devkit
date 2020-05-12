import 'package:devkit/app/resources/strings.dart';
import 'package:devkit/app/ui/widgets/text.dart';
import 'package:devkit/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:tangemsdk/tangemsdk.dart';

class ScanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ScanScreenInh(screenBlock: ScanScreenBlock(), child: ScanFrame());

  static navigate(context) {
    Navigator.of(context).pushNamed(Routes.SCAN);
  }
}

class ScanScreenInh extends InheritedWidget {
  final ScanScreenBlock screenBlock;

  ScanScreenInh({@required this.screenBlock, @required child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ScanScreenInh of(BuildContext context) => context.dependOnInheritedWidgetOfExactType();
}

class ScanScreenBlock {
  static ScanScreenBlock of(BuildContext context) => ScanScreenInh.of(context).screenBlock;
}

class ScanFrame extends StatefulWidget {
  @override
  _ScanFrameState createState() => _ScanFrameState();
}

class _ScanFrameState extends State<ScanFrame> {
  String _content = S.how_to_scan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.screen_scan)),
      body: ScanBody(content: _content),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: _scanAction,
      ),
    );
  }

  _scanAction() {
    TangemSdk.scanCard(Callback(
      (response) => setState(() {
        _content = response;
      }),
      (error) => setState(() {
        _content = error;
      }),
    ));
  }
}

class ScanBody extends StatelessWidget {
  final String content;

  const ScanBody({Key key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CenterText(text: content);
  }
}
