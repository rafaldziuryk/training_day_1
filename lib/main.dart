import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:training_flutter_intro/features/init/presentation/bloc/init_bloc.dart';
import 'package:training_flutter_intro/features/init/presentation/pages/init_page.dart';

import 'core/dependency_injection.dart';
import 'features/reports/presentation/blocs/reports_bloc.dart';
import 'features/reports/presentation/pages/report_list_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InitBloc()..add(InitApp()),
      child: Builder(
        builder: (context) => BlocBuilder<InitBloc, InitState>(
          builder: (context, state) {
            if (state is InitInitial) {
              return MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData.light(),
                home: const InitPage(),
              );
            } else if (state is InitSuccess) {
              return MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData.light(),
                home: const ReportList(title: 'Flutter Demo Home Page'),
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
