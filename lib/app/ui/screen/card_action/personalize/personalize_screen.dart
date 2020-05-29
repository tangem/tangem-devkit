import 'package:devkit/app/domain/actions_bloc/personalize/personalization_bloc.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/card_number_segment_widget.dart';
import 'widgets/common_segment_widget.dart';

class PersonalizeScreen extends StatefulWidget {
  @override
  _PersonalizeScreenState createState() => _PersonalizeScreenState();
}

class _PersonalizeScreenState extends State<PersonalizeScreen> {
  PersonalizationBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (context) {
        _bloc = PersonalizationBloc();
        return _bloc;
      })],
      child: PersonalizeFrame(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

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

class PersonalizeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        CardNumberSegmentWidget(),
        CommonSegmentWidget(),
      ],
    );
  }
}

