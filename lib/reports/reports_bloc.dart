import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final list = [];
  final dio = Dio(BaseOptions(baseUrl: 'https://trainingserver1.herokuapp.com/'));

  ReportsBloc() : super(ReportsInitial()) {
    on<ReportsInit>((event, emit) async {
      final responseData = await dio.get('data/1');
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
