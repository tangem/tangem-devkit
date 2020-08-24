import 'package:devkit/app/domain/actions_bloc/app_blocs.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/screen/card_action/helpers.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:devkit/commons/text_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangem_sdk/model/sdk.dart';

import '../finders.dart';

class SetPinScreen extends StatefulWidget {
  final PinType pinType;

  const SetPinScreen(this.pinType);

  @override
  _SetPinScreenState createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  SetPinBlock _bloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) {
          _bloc = SetPinBlock(widget.pinType);
          return _bloc;
        })
      ],
      child: SetPinFrame(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class SetPinFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = RepoFinder.setPinBloc(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_getScreenTitle(Transl.of(context), bloc.pinType)),
        actions: [Menu.popupDescription()],
      ),
      body: SetPinBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: bloc.invokeAction,
      ),
    );
  }

  String _getScreenTitle(Transl transl, PinType pinType) {
    switch (pinType) {
      case PinType.PIN1:
        return transl.screen_set_pin1;
      case PinType.PIN2:
        return transl.screen_set_pin2;
      default:
        throw Exception("Unsupported PinType");
    }
  }
}

class SetPinBody extends StatefulWidget {
  @override
  _SetPinBodyState createState() => _SetPinBodyState();
}

class _SetPinBodyState extends State<SetPinBody> {
  SetPinBlock _bloc;
  TextStreamController _cidController;
  TextStreamController _pinCodeController;

  @override
  void initState() {
    super.initState();

    _bloc = RepoFinder.setPinBloc(context);
    _cidController = TextStreamController(_bloc.bsCid);
    _pinCodeController = TextStreamController(_bloc.bsPinCode);
  }

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return Column(
      children: <Widget>[
        HiddenResponseHandlerWidget(_bloc),
        HiddenSnackbarHandlerWidget([_bloc.snackbarMessageStream]),
        SizedBox(height: 8),
        InputCidWidget(
          ItemName.cid,
          _cidController.controller,
          _bloc.scanCard,
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
        InputWidget(
          ItemName.pinCode,
          _pinCodeController.controller,
          hint: _bloc.pinType == PinType.PIN1 ? transl.pin1 : transl.pin2,
          description: _bloc.pinType == PinType.PIN1 ? transl.desc_pin1 : transl.desc_pin2,
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _cidController.dispose();
    super.dispose();
  }
}
