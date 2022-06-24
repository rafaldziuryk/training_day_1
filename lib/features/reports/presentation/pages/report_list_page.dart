import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/dependency_injection.dart';
import '../blocs/reports_bloc.dart';
import '../widgets/add_report_dialog.dart';
import '../widgets/cardview.dart';

class ReportList extends StatelessWidget {
  const ReportList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      name: data.title,
                      description: data.description,
                      date: data.date,
                      server: data.server,
                      isOk: data.isOk,
                      id: data.id,
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
