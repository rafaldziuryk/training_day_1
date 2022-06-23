import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entity/report.dart';
import '../model/report_adapter.dart';

class LocalReportsDataSource {
  static const boxIdentifier = 'ReportsBox';

  Box<Report>? reportsBox;

  Future<List<Report>> loadReportsFromLocalStorage() async {
    if (reportsBox == null) {
      await Hive.initFlutter().then((value) async {
        if (!Hive.isAdapterRegistered(ReportAdapter().typeId)) {
          Hive.registerAdapter(ReportAdapter());
        }
      });
      reportsBox = await Hive.openBox(boxIdentifier);
    }

    return reportsBox!.values.toList();
  }
}
