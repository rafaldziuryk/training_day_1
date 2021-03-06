import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:training_flutter_intro/core/use_case.dart';
import 'package:training_flutter_intro/features/reports/data/model/report_adapter.dart';
import 'package:training_flutter_intro/features/reports/domain/entity/report.dart';
import 'package:training_flutter_intro/features/reports/domain/use_case/delete_report_use_case.dart';
import 'package:training_flutter_intro/features/reports/domain/use_case/download_reports_use_case.dart';

import '../../domain/use_case/add_report_use_case.dart';
import '../../domain/use_case/fetch_reports_use_case.dart';

part 'reports_event.dart';

part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final FetchReportsUseCase fetchReportsUseCase;
  final DownloadReportsUseCase downloadReportsUseCase;
  final DeleteReportUseCase deleteReportUseCase;
  final AddReportUseCase addReportUseCase;

  ReportsBloc({
    required this.fetchReportsUseCase,
    required this.downloadReportsUseCase,
    required this.deleteReportUseCase,
    required this.addReportUseCase,
  }) : super(ReportsInitial()) {
    on<ReportsInit>((event, emit) async {
      await reloadData(emit);
      final downloadResult = await downloadReportsUseCase(NoParams());
      await downloadResult.fold((error) {}, (data) async {
        await reloadData(emit);
      });
    });

    on<ReportsRemove>((event, emit) async {
      final result = await deleteReportUseCase(DeleteReportUseCaseParams(index: event.index));
      await result.fold((error) {}, (data) async {
        await reloadData(emit);
      });
    });

    on<ReportsAdd>((event, emit) async {
      final result = await addReportUseCase(AddReportUseCaseParams(report: event.report));
      await result.fold((error) {}, (data) async {
        await reloadData(emit);
      });
    });
  }

  Future<void> reloadData(Emitter<ReportsState> emit) async {
    final result = await fetchReportsUseCase.call(NoParams());
    result.fold((error) {}, (data) {
      data.sort(
        (a, b) => b.date.compareTo(a.date),
      );
      final dataState = ReportsData(reports: List.unmodifiable(data));
      emit(dataState);
    });
  }
}
