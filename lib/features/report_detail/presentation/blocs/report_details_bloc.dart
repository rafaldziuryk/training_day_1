import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'report_details_event.dart';
part 'report_details_state.dart';

class ReportDetailsBloc extends Bloc<ReportDetailsEvent, ReportDetailsState> {
  ReportDetailsBloc() : super(ReportDetailsInitial()) {
    on<ReportDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
