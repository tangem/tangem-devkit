import 'package:devkit/app/domain/actions_bloc/base_events.dart';
import 'package:devkit/app/domain/actions_bloc/sign/sign_bloc.dart';
import 'package:devkit/app/domain/actions_bloc/sign/sign_events.dart';
import 'package:devkit/app/domain/actions_bloc/sign/sign_state.dart';
import 'package:devkit/app/resources/keys.dart';
import 'package:devkit/app/resources/localization.dart';
import 'package:devkit/app/ui/menu/menu.dart';
import 'package:devkit/app/ui/screen/response/response_main.dart';
import 'package:devkit/app/ui/snackbar.dart';
import 'package:devkit/app/ui/widgets/specific/item_base_widget.dart';
import 'package:devkit/app/ui/widgets/specific/item_input.dart';
import 'package:devkit/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignBloc(),
      child: SignFrame(),
    );
  }

  static navigate(context) {
    Navigator.of(context).pushNamed(Routes.SIGN);
  }
}

SignBloc _signBloc(context) => BlocProvider.of<SignBloc>(context);

class SignFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Transl.of(context).screen_sign),
        actions: [Menu.popupDescription()],
      ),
      body: SignBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: () => _signBloc(context).add(ESign()),
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
    _cidController.addListener(() => _block.add(ECidChanged(_cidController.text)));
    _dataController.addListener(() => _block.add(EDataChanged(_dataController.text)));
    _block = _signBloc(context);
    _block.add(EInitSign());
  }

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return BlocListener<SignBloc, SSign>(
      listener: (context, state) {
        if (state is SSignError) {
          showError(context, state.error);
        } else if (state is SSignSuccess) {
          ResponseScreen.navigate(context, state.success);
        } else if (state.theseFromBloc) {
          _cidController.text = state.cid;
          _dataController.text = state.dataForHashing;
        }
      },
      child: BlocBuilder<SignBloc, SSign>(
        builder: (context, state) {
          return Column(
            children: <Widget>[
              ItemWidget(
                item: InputCidWidget(FieldKey.cid, _cidController, () {
                  _block.add(EReadCard());
                }),
                description: DescriptionWidget(transl.desc_card_id),
              ),
              ItemWidget(
                item: InputWidget(FieldKey.dataForHashing, _dataController, TextInputType.text, transl.transaction_out_hash),
                description: DescriptionWidget(transl.desc_transaction_out_hash),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _cidController.dispose();
    _dataController.dispose();
    super.dispose();
  }
}
