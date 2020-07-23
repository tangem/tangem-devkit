import 'package:devkit/app/domain/sdk/sdk_card_filter_switcher.dart';
import 'package:devkit/app/resources/keys.dart';
import 'package:devkit/app/resources/localization.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/app/ui/widgets/specific/tap_encounter_widget.dart';
import 'package:devkit/commons/common_abstracts.dart';
import 'package:flutter/material.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MainFrame();
}

class MainFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TapEncounterWidget(
          maxTapCount: 7,
          child: Text(Transl.of(context).app_name),
          onSuccess: () {
            final switcher = TangemSdkCardFilterSwitcher()..toggle();
            final isAllowedOnlyDebug = switcher.isAllowedOnlyDebugCards();
            TangemSdk.allowsOnlyDebugCards(isAllowedOnlyDebug);
            _showDialog(context, isAllowedOnlyDebug ? "Allowed only debug cards" : "Allowed all cards");
          },
        ),
        actions: [Menu.popupDescription()],
      ),
      body: MainBody(),
    );
  }

  Future<void> _showDialog(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Card filter"),
          content: SingleChildScrollView(child: ListBody(children: <Widget>[TextWidget(message)])),
          actions: <Widget>[
            FlatButton(child: Text("Ok"), onPressed: () => Navigator.of(context).pop()),
          ],
        );
      },
    );
  }
}

class ToolbarTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MainBody extends StatelessWidget {
  //Used for get translation and navigation routes
  final _transKeys = [
    Pair("action_scan", "scan"),
    Pair("action_sign", "sign"),
    Pair("action_personalize", "personalize"),
    Pair("action_depersonalize", "depersonalize"),
    Pair("action_create_wallet", "create_wallet"),
    Pair("action_purge_wallet", "purge_wallet"),
    Pair("action_issuer_read_data", "issuer_read_data"),
    Pair("action_issuer_write_data", "issuer_write_data"),
    Pair("action_issuer_read_ex_data", "issuer_read_ex_data"),
    Pair("action_issuer_write_ex_data", "issuer_write_ex_data"),
    Pair("action_user_read_data", "user_read_data"),
    Pair("action_user_write_data", "user_write_data"),
    Pair("action_user_write_protected_data", "user_write_protected_data"),
    Pair("action_set_pin1", "set_pin_1"),
    Pair("action_set_pin2", "set_pin_2"),
  ];

  @override
  Widget build(BuildContext context) {
    final trans = Transl.of(context);

    return ListView.separated(
      itemBuilder: (context, index) {
        final pair = _transKeys[index];

        return ListItemWidget(
          key: ItemId.from(pair.b),
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
