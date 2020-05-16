import 'package:devkit/app/domain/actions_bloc/sign/sign_bloc.dart';
import 'package:devkit/app/domain/actions_bloc/sign/sign_events.dart';
import 'package:devkit/app/domain/actions_bloc/sign/sign_state.dart';
import 'package:devkit/app/resources/keys.dart';
import 'package:devkit/app/resources/localization.dart';
import 'package:devkit/app/ui/widgets/item_widget.dart';
import 'package:devkit/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SignFrame();

  static navigate(context) {
    Navigator.of(context).pushNamed(Routes.SIGN);
  }
}

class SignFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Transl.of(context).screen_sign)),
      body: BlocProvider(
        create: (context) => SignBloc(),
        child: SignBody(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: () {},
      ),
    );
  }
}

class SignBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SignSegment(),
      ],
    );
  }
}

class SignSegment extends StatefulWidget {
  @override
  _SignSegmentState createState() => _SignSegmentState();
}

class _SignSegmentState extends State<SignSegment> {
  final TextEditingController _cidController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();

  SignBloc _signBloc;

  @override
  void initState() {
    super.initState();
    _signBloc = BlocProvider.of<SignBloc>(context);
    _cidController.addListener(() => _signBloc.add(CidChanged(_cidController.text)));
    _dataController.addListener(() => _signBloc.add(DataChanged(_dataController.text)));
  }

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return BlocBuilder<SignBloc, SignState>(
      builder: (context, state) {
        return Column(
          children: <Widget>[
            ItemWidget.input(
              FieldKey.cid,
              _cidController,
              TextInputType.text,
              transl.card_id,
              transl.desc_card_id,
            ),
            ItemWidget.input(
              FieldKey.dataForHashing,
              _dataController,
              TextInputType.text,
              transl.data_for_hashing,
              transl.desc_data_for_hashing,
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _cidController.dispose();
    _dataController.dispose();
    super.dispose();
  }
}
