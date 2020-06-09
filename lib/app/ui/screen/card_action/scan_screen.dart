import 'package:devkit/app/domain/actions_bloc/app_blocs.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/screen/finders.dart';
import 'package:devkit/app/ui/screen/response/response_screen.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScanBloc(),
      child: ScanFrame(),
    );
  }
}

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
        onPressed: () => BlocFinder.scan(context).add(EScanCard()),
      ),
    );
  }
}

class ScanBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ScanBloc, SScan>(
      listener: (context, state) {
        if (state is SCardScanSuccess) {
          ResponseScreen.navigate(context, state.success);
        } else if (state is SCardScanError) {
          showJsonSnackbar(context, state.error);
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
