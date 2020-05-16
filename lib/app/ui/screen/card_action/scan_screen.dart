import 'package:devkit/app/resources/localization.dart';
import 'package:devkit/app/ui/widgets/text.dart';
import 'package:devkit/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Transl.of(context).screen_scan)),
      body: CenterText(text: Transl.of(context).how_to_scan),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: _scanAction,
      ),
    );
  }

  _scanAction() {
    TangemSdk.scanCard(Callback(
      (response) => setState(() {}),
      (error) => setState(() {}),
    ));
  }
}
