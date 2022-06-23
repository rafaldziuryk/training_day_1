import 'package:dartz/dartz.dart';
import 'package:training_flutter_intro/core/error.dart';
import 'package:training_flutter_intro/core/use_case.dart';
import 'package:training_flutter_intro/features/reports/domain/entity/report.dart';
import 'package:training_flutter_intro/features/reports/domain/repository/reports_repository.dart';

class AddReportUseCase extends UseCase<void, AddReportUseCaseParams> {
  AddReportUseCase({
    required this.repository,
  });

  final ReportsRepository repository;

  @override
  Future<Either<Failure, void>> call(AddReportUseCaseParams params) {
    return repository.addReport(params.report);
  }
}

class AddReportUseCaseParams {
  final Report report;

  const AddReportUseCaseParams({
    required this.report,
  });
}
