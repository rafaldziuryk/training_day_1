import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:training_flutter_intro/features/report_detail/presentation/pages/report_details.dart';
import 'package:training_flutter_intro/features/reports/presentation/pages/report_list_page.dart';

part 'router.gr.dart';

@CustomAutoRouter(
  transitionsBuilder: TransitionsBuilders.fadeIn,
  routes: <AutoRoute>[
    AutoRoute(page: ReportList, path: '/reports', initial: true),
    AutoRoute(
      page: ReportDetails,
      path: '/reports/:id',
    ),
  ],
)
class AppRouter extends _$AppRouter {
  AppRouter() : super();
}
