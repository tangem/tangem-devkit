import 'package:devkit/app/domain/actions_bloc/personalize/personalization_bloc.dart';
import 'package:devkit/app/ui/screen/card_action/helpers.dart';
import 'package:devkit/app/ui/screen/card_action/personalization/presets/preset_list_screen.dart';
import 'package:devkit/app_test_assembler/ui/widgets/widgets.dart';
import 'package:devkit/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PresetMainScreen extends StatefulWidget {
  @override
  _PresetMainScreenState createState() => _PresetMainScreenState();

  static navigate(BuildContext context, PersonalizationBloc bloc) {
    Navigator.pushNamed(context, Routes.PERSONALIZE_PRESETS, arguments: createArguments("_bloc", bloc));
  }
}

class _PresetMainScreenState extends State<PresetMainScreen> {

  @override
  Widget build(BuildContext context) {
    final PersonalizationBloc bloc = context.readArgument<PersonalizationBloc>("_bloc");

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => bloc),
      ],
      child: PresetMainFrame(),
    );
  }
}

class PresetMainFrame extends StatefulWidget {
  const PresetMainFrame({Key? key}) : super(key: key);

  @override
  _PresetMainFrameState createState() => _PresetMainFrameState();
}

class _PresetMainFrameState extends State<PresetMainFrame> with SingleTickerProviderStateMixin {
  final int _tabLength = 2;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    context.read<PersonalizationBloc>().fetchPersonalConfigNames();
    context.read<PersonalizationBloc>().fetchDefaultConfigNames();
    _tabController = TabController(length: _tabLength, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabLength,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Select preset"),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              TabTextIconWidget(Icon(Icons.dashboard_customize), Text("Personal")),
              TabTextIconWidget(Icon(Icons.folder_shared), Text("Shared")),
            ],
          ),
        ),
        body: Stack(
          children: [
            HiddenSnackBarHandlerWidget([]),
            TabBarView(
              controller: _tabController,
              children: [
                PersonalPresetListFrame(),
                DefaultPresetListFrame(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
