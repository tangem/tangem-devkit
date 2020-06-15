import 'package:devkit/app/domain/actions_bloc/app_blocs.dart';
import 'package:devkit/app/resources/app_resources.dart';
import 'package:devkit/app/ui/screen/finders.dart';
import 'package:devkit/app/ui/screen/response/response_screen.dart';
import 'package:devkit/app/ui/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DepersonalizationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DepersonalizeBloc>(
      create: (context) => DepersonalizeBloc(),
      child: DepersonalizeFrame(),
    );
  }
}

class DepersonalizeFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Transl.of(context).screen_depersonalize),
        actions: [Menu.popupDescription()],
      ),
      body: DepersonalizeBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.nfc),
        onPressed: () => BlocFinder.depersonalize(context).add(EDepersonalize()),
      ),
    );
  }
}

class DepersonalizeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<DepersonalizeBloc, SDepersonalize>(
      listener: (context, state) {
        if (state is SCardDepersonalizeSuccess) {
          ResponseScreen.navigate(context, state.success);
        } else if (state is SCardDepersonalizeError) {
          showJsonSnackbar(context, state.error);
        }
      },
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: TextWidget.howTo(Transl.of(context).how_to_depersonalize),
        ),
      ),
    );
  }
}
