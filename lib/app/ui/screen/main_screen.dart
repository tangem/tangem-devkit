import 'package:devkit/app/resources/keys.dart';
import 'package:devkit/app/resources/localization.dart';
import 'package:devkit/app/ui/widgets/specific/item_base_widget.dart';
import 'package:devkit/app/ui/widgets/basic/semi_widget.dart';
import 'package:devkit/app/ui/widgets/basic/text_widget.dart';
import 'package:devkit/commons/common_abstracts.dart';
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
      appBar: AppBar(title: Text(Transl.of(context).app_name)),
      body: MainBody(),
    );
  }
}

class MainBody extends StatelessWidget {
  //Used for get translation and navigation routes
  final _transKeys = [
    Pair("action_scan", "scan"),
    Pair("action_sign", "sign"),
    Pair("action_personalize", "implement screen and routing"),
    Pair("action_depersonalize", "implement screen and routing"),
    Pair("action_wallet_create", "implement screen and routing"),
    Pair("action_wallet_purge", "implement screen and routing"),
    Pair("action_issuer_read_data", "implement screen and routing"),
    Pair("action_issuer_write_data", "implement screen and routing"),
    Pair("action_issuer_read_ex_data", "implement screen and routing"),
    Pair("action_issuer_write_ex_data", "implement screen and routing"),
    Pair("action_user_read_data", "implement screen and routing"),
    Pair("action_user_write_data", "implement screen and routing"),
    Pair("action_user_write_protected_data", "implement screen and routing"),
  ];

  @override
  Widget build(BuildContext context) {
    final trans = Transl.of(context);

    return ListView.separated(
      itemBuilder: (context, index) {
        final pair = _transKeys[index];

        return ListItemWidget(
          key: stringKey(pair.b),
          item: TextWidget(trans.get(pair.a), fontSize: 18),
          description: DescriptionWidget(trans.getDesc(pair.a)),
          onTap: () => Navigator.of(context).pushNamed("/${pair.b.toLowerCase()}"),
        );
      },
      itemCount: _transKeys.length,
      separatorBuilder: (context, index) => HorizontalDelimiter(),
    );
  }
}

class ListItemWidget extends StatelessWidget {
  final Widget item;
  final Widget description;
  final Function onTap;

  const ListItemWidget({Key key, @required this.item, @required this.description, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 50),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Align(alignment: Alignment.centerLeft, child: item),
              description,
            ],
          ),
        ),
      ),
    );
  }
}
