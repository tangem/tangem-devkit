import 'package:devkit/app/domain/actions_bloc/sign/sign_bloc.dart';
import 'package:devkit/app/domain/actions_bloc/sign/sign_events.dart';
import 'package:devkit/app/domain/actions_bloc/sign/sign_state.dart';
import 'package:devkit/app/resources/keys.dart';
import 'package:devkit/app/resources/localization.dart';
import 'package:devkit/app/ui/menu/menu.dart';
import 'package:devkit/app/ui/widgets/specific/item_base_widget.dart';
import 'package:devkit/app/ui/widgets/specific/item_input.dart';
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
      appBar: AppBar(
        title: Text(Transl.of(context).screen_sign),
        actions: [Menu.popupDescription()],
      ),
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

  SignBloc _block;

  @override
  void initState() {
    super.initState();
    _block = BlocProvider.of<SignBloc>(context);
    _cidController.addListener(() => _block.add(CidChanged(_cidController.text)));
    _dataController.addListener(() => _block.add(DataChanged(_dataController.text)));
  }

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return BlocBuilder<SignBloc, SignState>(
      builder: (context, state) {
        _theseFromBloc(state);
        return Column(
          children: <Widget>[
            ItemWidget(
              item: InputCidWidget(FieldKey.cid, _cidController, () {}),
              description: DescriptionWidget(transl.desc_card_id),
            ),
            ItemWidget(
              item: InputWidget(FieldKey.dataForHashing, _dataController, TextInputType.text, transl.transaction_out_hash),
              description: DescriptionWidget(transl.desc_transaction_out_hash),
            ),
          ],
        );
      },
    );
  }

  _theseFromBloc(SignState state) {
    if (state.theseFromBloc) {
      _dataController.text = state.dataForHashing;
      _cidController.text = state.cid;
    }
  }

  @override
  void dispose() {
    _cidController.dispose();
    _dataController.dispose();
    super.dispose();
  }
}
