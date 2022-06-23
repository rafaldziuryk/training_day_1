import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/dependency_injection.dart';

part 'init_event.dart';

part 'init_state.dart';

class InitBloc extends Bloc<InitEvent, InitState> {
  InitBloc() : super(InitInitial()) {
    on<InitApp>((event, emit) async {
      await DIContainer().init();
      emit(InitSuccess());
    });
  }
}
