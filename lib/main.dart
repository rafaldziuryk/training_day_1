import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_flutter_intro/features/init/presentation/bloc/init_bloc.dart';
import 'package:training_flutter_intro/features/init/presentation/pages/init_page.dart';
import 'package:training_flutter_intro/router.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final router = AppRouter();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InitBloc()..add(InitApp()),
      child: Builder(
        builder: (context) => BlocBuilder<InitBloc, InitState>(
          builder: (context, state) {
            if (state is InitInitial) {
              return MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData.light(),
                home: const InitPage(),
              );
            } else if (state is InitSuccess) {
              return MaterialApp.router(
                title: 'Flutter Demo',
                theme: ThemeData.light(),
                routerDelegate: router.delegate(),
                routeInformationParser: router.defaultRouteParser(),
                routeInformationProvider: router.routeInfoProvider(),
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
