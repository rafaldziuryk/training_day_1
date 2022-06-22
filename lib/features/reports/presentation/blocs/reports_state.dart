part of 'reports_bloc.dart';

abstract class ReportsState extends Equatable {
  const ReportsState();
}

class ReportsInitial extends ReportsState {
  @override
  List<Object> get props => [];
}

class ReportsData extends ReportsState {
  final List<Report> reports;

  const ReportsData({
    required this.reports,
  });

  @override
  List<Object?> get props => [reports];
}
