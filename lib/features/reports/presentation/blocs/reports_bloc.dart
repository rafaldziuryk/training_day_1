import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:training_flutter_intro/core/use_case.dart';
import 'package:training_flutter_intro/features/reports/data/model/report_adapter.dart';
import 'package:training_flutter_intro/features/reports/domain/entity/report.dart';
import 'package:training_flutter_intro/features/reports/domain/use_case/download_reports_use_case.dart';

import '../../domain/use_case/fetch_reports_use_case.dart';

part 'reports_event.dart';

part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final FetchReportsUseCase fetchReportsUseCase;
  final DownloadReportsUseCase downloadReportsUseCase;

  ReportsBloc({
    required this.fetchReportsUseCase,
    required this.downloadReportsUseCase,
  }) : super(ReportsInitial()) {
    on<ReportsInit>((event, emit) async {
      await reloadData(emit);
      final downloadResult = await downloadReportsUseCase(NoParams());
      await reloadData(emit);

      // downloadResult.fold((error) {}, (data) async {
      //   await reloadData(emit);
      // });
    });

    on<ReportsRemove>((event, emit) {
      // list.removeAt(event.index);
      // final dataState = ReportsData(reports: List.unmodifiable(list));
      // emit(dataState);
    });
  }

  Future<void> reloadData(Emitter<ReportsState> emit) async {
    final result = await fetchReportsUseCase.call(NoParams());
    result.fold((error) {}, (data) {
      final dataState = ReportsData(reports: List.unmodifiable(data));
      emit(dataState);
    });
  }
}
