import 'package:dartz/dartz.dart';
import 'package:training_flutter_intro/core/error.dart';
import 'package:training_flutter_intro/core/use_case.dart';
import 'package:training_flutter_intro/features/reports/domain/entity/report.dart';
import 'package:training_flutter_intro/features/reports/domain/repository/reports_repository.dart';

class DownloadReportsUseCase extends UseCase<void, NoParams> {
  DownloadReportsUseCase({
    required this.repository,
  });

  final ReportsRepository repository;

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.downloadReports();
  }
}
