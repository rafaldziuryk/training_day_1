import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:training_flutter_intro/features/reports/data/model/report_adapter.dart';
import 'package:training_flutter_intro/features/reports/domain/entity/report.dart';

part 'reports_event.dart';

part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost:8080/'));

  ReportsBloc() : super(ReportsInitial()) {
    on<ReportsInit>((event, emit) async {
      final responseData = await dio.get('data/1');
      final dataList = (responseData.data as List).map((e) => Report.fromMap(e)).toList();

      await Hive.initFlutter().then((value) async {
        if (!Hive.isAdapterRegistered(ReportAdapter().typeId)) {
          Hive.registerAdapter(ReportAdapter());
        }
      });

      final box = await Hive.openBox('Reports');
      box.addAll(dataList);
      final data = box.values;

      final dataState = ReportsData(reports: List.unmodifiable(data));
      emit(dataState);
    });
    on<ReportsRemove>((event, emit) {
      // list.removeAt(event.index);
      // final dataState = ReportsData(reports: List.unmodifiable(list));
      // emit(dataState);
    });
  }
}
