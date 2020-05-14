import 'package:devkit/app/resources/ids.dart';
import 'package:devkit/app/resources/strings.dart';
import 'package:devkit/app/ui/widgets/semi.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MainScreenInh(screenBlock: MainScreenBlock(), child: MainFrame());
}

class MainScreenInh extends InheritedWidget {
  final MainScreenBlock screenBlock;

  MainScreenInh({@required this.screenBlock, @required child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static MainScreenInh of(BuildContext context) => context.dependOnInheritedWidgetOfExactType();
}

class MainScreenBlock {
  static MainScreenBlock of(BuildContext context) => MainScreenInh.of(context).screenBlock;
}

class MainFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.screen_main)),
      body: MainBody(),
    );
  }
}

class MainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final actionName = S.actionList[index];
        return ListTile(key: stringKey(actionName),
          title: Text(actionName),
          subtitle: DescriptionWidget(name: "Description of...",),
          onTap: () => Navigator.of(context).pushNamed("/${actionName.toLowerCase()}"),
        );
      },
      itemCount: S.actionList.length,
      separatorBuilder: (context, index) => HorizontalDelimiter(),
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  final String name;
  final String description;

  const DescriptionWidget({Key key, this.name, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        child: Align(alignment: Alignment.centerLeft, child: Text(name)),
      ),
    );
  }
}
