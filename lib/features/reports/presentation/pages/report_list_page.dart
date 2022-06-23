import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/dependency_injection.dart';
import '../blocs/reports_bloc.dart';
import '../widgets/add_report_dialog.dart';
import '../widgets/cardview.dart';

class ReportList extends StatefulWidget {
  const ReportList({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<ReportList> createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  @override
  Widget build(BuildContext context) {
    print('rebuild');
    return BlocProvider(
      create: (context) => di.get<ReportsBloc>()..add(ReportsInit()),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: BlocBuilder<ReportsBloc, ReportsState>(
              builder: (context, state) {
                if (state is ReportsInitial) {
                  return Text('Loading');
                } else if (state is ReportsData) {
                  return Text('Reports: ${state.reports.length}');
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
            backgroundColor: Colors.lime,
          ),
          body: BlocBuilder<ReportsBloc, ReportsState>(
            builder: (context, state) {
              if (state is ReportsInitial) {
                return Text('Brak danych');
              } else if (state is ReportsData) {
                final list = state.reports;
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final data = list[index];
                    return CardView(
                      key: ValueKey(data),
                      name: data.title,
                      description: data.description,
                      date: data.date,
                      server: data.server,
                      isOk: data.isOk,
                      onDismiss: () {
                        context.read<ReportsBloc>().add(ReportsRemove(index: index));
                      },
                    );
                  },
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              final result = await showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => AddReportDialog(),
              );
              if (result != null) {
                context.read<ReportsBloc>().add(ReportsAdd(report: result));
              }
            },
          ),
        ),
      ),
    );
  }
}
