part of 'reports_bloc.dart';

abstract class ReportsEvent extends Equatable {
  const ReportsEvent();
}

class ReportsInit extends ReportsEvent {
  @override
  List<Object?> get props => [];
}
