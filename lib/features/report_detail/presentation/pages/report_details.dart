import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_flutter_intro/features/report_detail/presentation/blocs/report_details_bloc.dart';

class ReportDetails extends StatelessWidget {
  const ReportDetails({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => ReportDetailsBloc(), child: Scaffold());
  }
}
