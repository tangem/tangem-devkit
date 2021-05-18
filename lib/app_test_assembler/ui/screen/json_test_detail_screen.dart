import 'package:devkit/app_test_assembler/domain/bloc/json_test_detail_bloc.dart';
import 'package:devkit/app_test_assembler/ui/widgets/widgets.dart';
import 'package:devkit/application.dart';
import 'package:devkit/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangem_sdk/extensions.dart';

class JsonTestDetailScreen extends StatefulWidget {
  @override
  _JsonTestDetailScreenState createState() => _JsonTestDetailScreenState();

  static navigate(BuildContext context, String data) {
    Navigator.pushNamed(context, Routes.JSON_TEST_DETAIL, arguments: data);
  }
}

class _JsonTestDetailScreenState extends State<JsonTestDetailScreen> {
  late JsonTestDetailBloc _bloc;

  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context)!.settings.arguments as String;
    final testStorageRepository = context.read<ApplicationContext>().testStoreRepository;
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => JsonTestDetailBloc(testStorageRepository, name).apply((it) => _bloc = it),
        )
      ],
      child: JsonTestDetailFrame(),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class JsonTestDetailFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<JsonTestDetailBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(bloc.testName),
      ),
      body: JsonTestDetailBody(),
    );
  }
}

class JsonTestDetailBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<JsonTestDetailBloc>();
    return SimpleFutureBuilder<String>(
      bloc.readFile(),
      (context) => CenterLoadingText(),
      (context, data) => SingleChildScrollView(
        child: Text(data),
      ),
    );
  }
}
