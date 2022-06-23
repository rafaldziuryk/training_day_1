import 'package:dio/dio.dart';

import '../../domain/entity/report.dart';

class RemoteReportsDataSource {
  RemoteReportsDataSource(this.dio);

  final Dio dio;

  Future<List<Report>> downloadNewReports() async {
    final responseData = await dio.get('data/1');
    return (responseData.data as List).map((e) => Report.fromMap(e)).toList();
  }
}
