import 'package:dartz/dartz.dart';
import 'package:training_flutter_intro/core/error.dart';
import 'package:training_flutter_intro/features/reports/data/data_source/local_reports_data_source.dart';
import 'package:training_flutter_intro/features/reports/domain/entity/report.dart';
import 'package:training_flutter_intro/features/reports/domain/repository/reports_repository.dart';

class ReportsRepositoryImpl implements ReportsRepository {
  const ReportsRepositoryImpl({
    required this.localReportsDataSource,
  });

  final LocalReportsDataSource localReportsDataSource;

  @override
  Future<Either<Failure, List<Report>>> fetchReports() async {
    try {
      final data = await localReportsDataSource.loadReportsFromLocalStorage();
      return Right(data);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
