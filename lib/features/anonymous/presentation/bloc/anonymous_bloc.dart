// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:login_tester/features/anonymous/data/anonymous_firebase.dart';

part 'anonymous_event.dart';
part 'anonymous_state.dart';

@injectable
class AnonymousBloc extends Bloc<AnonymousEvent, AnonymousState> {
  final AnonymousFirebase _anonymousFirebase;

  AnonymousBloc(this._anonymousFirebase) : super(AnonymousInitial()) {
    on<LoginAnonomyouslyPressed>(_onLoginAnonomyouslyPressed);
    on<LogoutPressed>(_onLogoutPressed);
    on<DeleteAccountPressed>(_onDeleteAccountPressed);
  }

  Future<void> _onLoginAnonomyouslyPressed(
    LoginAnonomyouslyPressed event,
    Emitter<AnonymousState> emit,
  ) async {
    emit(AnonymousLoading());
    try {
      await _anonymousFirebase.signInAnonymously();
      emit(AnonymousSuccess());
      emit(AnonymousInitial());
    } catch (e) {
      emit(AnonymousError(errorMessage: 'Error occurred, try again soon'));
      emit(AnonymousInitial());
    }
  }

  Future<void> _onLogoutPressed(
    LogoutPressed event,
    Emitter<AnonymousState> emit,
  ) async {
    await _anonymousFirebase.signOut();
  }

  Future<void> _onDeleteAccountPressed(
    DeleteAccountPressed event,
    Emitter<AnonymousState> emit,
  ) async {
    await _anonymousFirebase.deleteAccount();
  }
}
