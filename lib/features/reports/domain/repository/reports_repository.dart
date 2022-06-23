import 'package:dartz/dartz.dart';

import '../../../../core/error.dart';
import '../entity/report.dart';

abstract class ReportsRepository {
  Future<Either<Failure, List<Report>>> fetchReports();
}
