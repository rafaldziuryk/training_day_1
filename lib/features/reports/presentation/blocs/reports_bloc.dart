import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:training_flutter_intro/core/use_case.dart';
import 'package:training_flutter_intro/features/reports/data/model/report_adapter.dart';
import 'package:training_flutter_intro/features/reports/domain/entity/report.dart';

import '../../domain/use_case/fetch_reports_use_case.dart';

part 'reports_event.dart';

part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final dio = Dio(BaseOptions(baseUrl: 'https://trainingserver1.herokuapp.com/'));

  final FetchReportsUseCase fetchReportsUseCase;

  ReportsBloc(this.fetchReportsUseCase) : super(ReportsInitial()) {
    on<ReportsInit>((event, emit) async {
      // final responseData = await dio.get('data/1');
      // final dataList = (responseData.data as List).map((e) => Report.fromMap(e)).toList();

      final result = await fetchReportsUseCase.call(NoParams());
      result.fold((error) {}, (data) {
        final dataState = ReportsData(reports: List.unmodifiable(data));
        emit(dataState);
      });
    });

    on<ReportsRemove>((event, emit) {
      // list.removeAt(event.index);
      // final dataState = ReportsData(reports: List.unmodifiable(list));
      // emit(dataState);
    });
  }
}
