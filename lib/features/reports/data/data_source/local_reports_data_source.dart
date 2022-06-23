import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entity/report.dart';

class LocalReportsDataSource {
  const LocalReportsDataSource({
    required this.reportsBox,
  });

  final Box<Report> reportsBox;

  Future<List<Report>> loadReportsFromLocalStorage() async {
    return reportsBox.values.toList();
  }

  Future saveReportsToLocalStorage(List<Report> reports) {
    return reportsBox.addAll(reports);
  }
}
