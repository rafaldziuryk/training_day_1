import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:training_flutter_intro/features/reports/domain/entity/report.dart';

part 'reports_event.dart';

part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final list = <Report>[];
  final dio = Dio(BaseOptions(baseUrl: 'https://trainingserver1.herokuapp.com/'));

  ReportsBloc() : super(ReportsInitial()) {
    on<ReportsInit>((event, emit) async {
      final responseData = await dio.get('data/1');
      final dataList = jsonDecode(responseData.data) as List;
      dataList.forEach((element) {
        final report = Report(
          title: element['title'],
          description: element['description'],
          server: element['server'],
          date: DateTime.parse(element['date']),
          isOk: element['isOk'],
        );
        list.add(report);
      });
      final dataState = ReportsData(reports: List.unmodifiable(list));
      emit(dataState);
    });
    on<ReportsRemove>((event, emit) {
      list.removeAt(event.index);
      final dataState = ReportsData(reports: List.unmodifiable(list));
      emit(dataState);
    });
  }
}
