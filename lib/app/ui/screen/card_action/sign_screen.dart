import 'package:devkit/app/domain/actions_bloc/app_blocs.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/screen/response/response_main.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc_finder.dart';

class SignScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignBloc>(create: (context) => SignBloc()),
        BlocProvider<ScanBloc>(create: (context) => ScanBloc()),
      ],
      child: SignFrame(),
    );
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
      body: SignBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: () => BlocFinder.sign(context).add(ESign()),
      ),
    );
  }
}

class SignBody extends StatefulWidget {
  @override
  _SignBodyState createState() => _SignBodyState();
}

class _SignBodyState extends State<SignBody> {
  final TextEditingController _cidController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();

  SignBloc _block;

  @override
  void initState() {
    super.initState();
    _cidController.addListener(() => _block.add(ECidChanged(_cidController.text)));
    _dataController.addListener(() => _block.add(EDataChanged(_dataController.text)));
    _block = BlocFinder.sign(context);
    _block.add(EInitSign());
  }

  @override
  Widget build(BuildContext context) {
    final transl = Transl.of(context);
    return BlocListener<SignBloc, SSign>(
      listener: (context, state) {
        if (state is SCardSignError) {
          showError(context, state.error);
        } else if (state is SCardSignSuccess) {
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
                item: InputCidWidget(FieldKey.cid, _cidController, () => BlocFinder.scan(context).scanCardWith(_block)),
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
