import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:training_flutter_intro/features/reports/data/data_source/local_reports_data_source.dart';
import 'package:training_flutter_intro/features/reports/data/repository/reports_repository_impl.dart';
import 'package:training_flutter_intro/features/reports/domain/repository/reports_repository.dart';
import 'package:training_flutter_intro/features/reports/presentation/blocs/reports_bloc.dart';

import '../features/reports/data/model/report_adapter.dart';
import '../features/reports/domain/entity/report.dart';
import '../features/reports/domain/use_case/fetch_reports_use_case.dart';

final di = GetIt.instance;

class DIContainer {
  static const boxIdentifier = 'ReportsBox';

  Future init() async {
    await Hive.initFlutter().then((value) async {
      if (!Hive.isAdapterRegistered(ReportAdapter().typeId)) {
        Hive.registerAdapter(ReportAdapter());
      }
    });
    final Box<Report> reportsBox = await Hive.openBox(boxIdentifier);
    di.registerSingleton(reportsBox, instanceName: boxIdentifier);
    di.registerSingleton(
      LocalReportsDataSource(
        reportsBox: di.get(instanceName: boxIdentifier),
      ),
    );
    di.registerSingleton<ReportsRepository>(
      ReportsRepositoryImpl(
        localReportsDataSource: di.get(),
      ),
    );
    di.registerSingleton(FetchReportsUseCase(repository: di.get()));
    di.registerFactory(() => ReportsBloc(di.get()));
  }
}
