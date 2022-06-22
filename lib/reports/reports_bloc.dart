import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final list = List.generate(100, (index) => index);

  ReportsBloc() : super(ReportsInitial()) {
    on<ReportsInit>((event, emit) {
      final dataState = ReportsData(reports: List.unmodifiable(list));
      emit(dataState);
    });
  }
}
