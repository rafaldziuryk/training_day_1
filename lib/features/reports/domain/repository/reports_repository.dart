import 'package:dartz/dartz.dart';

import '../../../../core/error.dart';
import '../entity/report.dart';

abstract class ReportsRepository {
  Future<Either<Failure, List<Report>>> fetchReports();
  Future<Either<Failure, void>> downloadReports();
  Future<Either<Failure, void>> deleteReport(int index);
  Future<Either<Failure, void>> addReport(Report report);
}
