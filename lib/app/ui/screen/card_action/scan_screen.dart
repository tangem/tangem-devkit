import 'package:devkit/app/domain/actions_bloc/scan_card/scan_bloc.dart';
import 'package:devkit/app/resources/localization.dart';
import 'package:devkit/app/ui/menu/menu.dart';
import 'package:devkit/app/ui/screen/response/response_main.dart';
import 'package:devkit/app/ui/snackbar.dart';
import 'package:devkit/app/ui/widgets/basic/text_widget.dart';
import 'package:devkit/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ScanBloc(),
      child: ScanFrame(),
    );
  }

  static navigate(context) {
    Navigator.of(context).pushNamed(Routes.SCAN);
  }
}

ScanBloc _scanBloc(context) => BlocProvider.of<ScanBloc>(context);

class ScanFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Transl.of(context).screen_scan),
        actions: [Menu.popupDescription()],
      ),
      body: ScanBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: () {
          _scanBloc(context).add(EScan());
        },
      ),
    );
  }
}

class ScanBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ScanBloc, SScan>(
      listener: (context, state) {
        if (state is SScanSuccess) {
          ResponseScreen.navigate(context, state.success);
        } else if (state is SScanError) {
          showError(context, state.error);
        }
      },
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: TextWidget.center(Transl.of(context).how_to_scan),
        ),
      ),
    );
  }
}
