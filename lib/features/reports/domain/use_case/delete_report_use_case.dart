import 'package:dartz/dartz.dart';
import 'package:training_flutter_intro/core/error.dart';
import 'package:training_flutter_intro/core/use_case.dart';
import 'package:training_flutter_intro/features/reports/domain/entity/report.dart';
import 'package:training_flutter_intro/features/reports/domain/repository/reports_repository.dart';

class DeleteReportUseCase extends UseCase<void, DeleteReportUseCaseParams> {
  DeleteReportUseCase({
    required this.repository,
  });

  final ReportsRepository repository;

  @override
  Future<Either<Failure, void>> call(DeleteReportUseCaseParams params) {
    return repository.deleteReport(params.index);
  }
}

class DeleteReportUseCaseParams {
  final int index;

  const DeleteReportUseCaseParams({
    required this.index,
  });
}
