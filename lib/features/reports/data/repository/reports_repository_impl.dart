import 'package:dartz/dartz.dart';
import 'package:training_flutter_intro/core/error.dart';
import 'package:training_flutter_intro/features/reports/data/data_source/local_reports_data_source.dart';
import 'package:training_flutter_intro/features/reports/domain/entity/report.dart';
import 'package:training_flutter_intro/features/reports/domain/repository/reports_repository.dart';

import '../data_source/remote_reports_data_source.dart';

class ReportsRepositoryImpl implements ReportsRepository {
  const ReportsRepositoryImpl({
    required this.localReportsDataSource,
    required this.remoteReportsDataSource,
  });

  final LocalReportsDataSource localReportsDataSource;
  final RemoteReportsDataSource remoteReportsDataSource;

  @override
  Future<Either<Failure, List<Report>>> fetchReports() async {
    try {
      final data = await localReportsDataSource.loadReportsFromLocalStorage();
      return Right(data);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> downloadReports() async {
    try {
      final reports = await remoteReportsDataSource.downloadNewReports();
      await localReportsDataSource.saveReportsToLocalStorage(reports);
      return Right(null);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteReport(int index) async {
    try {
      localReportsDataSource.deleteReport(index);
      return Right(null);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addReport(Report report) async {
    try {
      localReportsDataSource.addReport(report);
      return Right(null);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
