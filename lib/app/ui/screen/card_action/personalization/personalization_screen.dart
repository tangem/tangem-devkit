import 'package:devkit/app/domain/actions_bloc/personalize/personalization_bloc.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'segment_widgets/card_number_segment_widget.dart';
import 'segment_widgets/common_segment_widget.dart';
import 'segment_widgets/pins_segment_widget.dart';
import 'segment_widgets/product_mask_segment_widget.dart';
import 'segment_widgets/settings_mask_protocol_encryption_segment_widget.dart';
import 'segment_widgets/signing_method_segment_widget.dart';

class PersonalizationScreen extends StatefulWidget {
  @override
  _PersonalizationScreenState createState() => _PersonalizationScreenState();
}

class _PersonalizationScreenState extends State<PersonalizationScreen> {
  PersonalizationBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) {
          _bloc = PersonalizationBloc();
          return _bloc;
        })
      ],
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
        SigningMethodSegmentWidget(),
        ProductMaskSegmentWidget(),
        SettingMaskProtocolEncryptionSegmentWidget(),
        PinsSegmentWidget(),
      ],
    );
  }
}
