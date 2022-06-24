// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    ReportListRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const ReportList());
    },
    ReportDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ReportDetailsRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: ReportDetails(key: args.key, id: args.id));
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig('/#redirect',
            path: '/', redirectTo: '/reports', fullMatch: true),
        RouteConfig(ReportListRoute.name, path: '/reports'),
        RouteConfig(ReportDetailsRoute.name, path: '/reports/:id')
      ];
}

/// generated route for
/// [ReportList]
class ReportListRoute extends PageRouteInfo<void> {
  const ReportListRoute() : super(ReportListRoute.name, path: '/reports');

  static const String name = 'ReportListRoute';
}

/// generated route for
/// [ReportDetails]
class ReportDetailsRoute extends PageRouteInfo<ReportDetailsRouteArgs> {
  ReportDetailsRoute({Key? key, required int id})
      : super(ReportDetailsRoute.name,
            path: '/reports/:id',
            args: ReportDetailsRouteArgs(key: key, id: id));

  static const String name = 'ReportDetailsRoute';
}

class ReportDetailsRouteArgs {
  const ReportDetailsRouteArgs({this.key, required this.id});

  final Key? key;

  final int id;

  @override
  String toString() {
    return 'ReportDetailsRouteArgs{key: $key, id: $id}';
  }
}
