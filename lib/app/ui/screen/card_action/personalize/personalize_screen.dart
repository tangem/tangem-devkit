import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/app/ui/widgets/specific/item_block_widget.dart';
import 'package:devkit/app/ui/widgets/specific/item_spinner_wiget.dart';
import 'package:devkit/app/ui/widgets/specific/item_switch_widget.dart';
import 'package:devkit/commons/common_abstracts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class PersonalizeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => Repo(),
        )
      ],
      child: PersonalizeFrame(),
    );
  }
}

class Repo extends RepositoryProvider {}

class PersonalizeFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Transl.of(context).screen_personalize),
        actions: [Menu.popupPersonalization((MenuItem item) {})],
      ),
      body: PersonalizeBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: () {},
      ),
    );
  }
}

class PersonalizeBody extends StatefulWidget {
  @override
  _PersonalizeBodyState createState() => _PersonalizeBodyState();
}

class _PersonalizeBodyState extends State<PersonalizeBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        CommonBlock(),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class CommonBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    final stub = transl.stub;

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        BlockDelimiterWidget("Common", description: stub),
        HorizontalDelimiter(),
        InputWidget(ItemName.cid, TextEditingController()..text = "11111", hint: "Card Id (CID)", description: stub),
        HorizontalDelimiter(),
        SpinnerWidget(
          ItemName.cid,
          [Pair("1", "11"), Pair("2", "22"), Pair("3", "33")],
          BehaviorSubject(),
          "Some title for the spinner",
          transl.stub,
        ),
        HorizontalDelimiter(),
        SwitchWidget(ItemName.cid, "Title", BehaviorSubject(), initialData: false),
        HorizontalDelimiter(),
      ],
    );
  }
}
