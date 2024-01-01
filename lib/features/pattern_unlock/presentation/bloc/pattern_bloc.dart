// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:login_tester/features/pattern_unlock/data/pattern_firestore.dart';
import 'package:login_tester/features/pattern_unlock/data/pattern_hive.dart';

part 'pattern_event.dart';
part 'pattern_state.dart';

enum AuthView { login, register }

@injectable
class PatternBloc extends Bloc<PatternEvent, PatternState> {
  final PatternFirestore _patternFirestore;
  final PatternHive _patternHive;

  PatternBloc(this._patternFirestore, this._patternHive)
      : super(PatternInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
    on<AuthViewChanged>(_onAuthViewChanged);
    on<PatternUpdated>(_onPatternUpdated);
    on<DeleteUserPressed>(_onDeleteUserPressed);
  }

  AuthView _currentView = AuthView.register;
  List<int> _userPattern = [];

  AuthView get currentView => _currentView;

  List<int> get userPattern => _userPattern;

  void _onAuthViewChanged(
    AuthViewChanged event,
    Emitter<PatternState> emit,
  ) {
    _userPattern = [];
    _currentView = event.view;
    emit(PatternLoading());
    emit(PatternInitial());
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<PatternState> emit,
  ) async {
    if (_userPattern.length < 4) {
      _userPattern = [];
      emit(
          PatternError(errorMessage: 'Pattern should be at least 4 dots long'));
      emit(PatternInitial());
    } else {
      emit(PatternLoading());

      try {
        final userEmail = _patternHive.getUserEmail();
        final userPattern =
            await _patternFirestore.getUserPattern(email: userEmail);

        if (listEquals(userPattern, _userPattern)) {
          emit(PatternSuccess());
          emit(PatternInitial());
        } else {
          _userPattern = [];
          emit(PatternError(errorMessage: 'Pattern you entered is incorrect'));
          emit(PatternInitial());
        }
      } catch (error) {
        emit(PatternError(
            errorMessage: error.toString().replaceFirst('Exception: ', '')));
        emit(PatternInitial());
      }
    }
  }

  Future<void> _onRegisterButtonPressed(
    RegisterButtonPressed event,
    Emitter<PatternState> emit,
  ) async {
    if (event.email.trim().isEmpty) {
      emit(PatternError(errorMessage: 'Please fill in email field'));
      emit(PatternInitial());
    } else if (_userPattern.length < 4) {
      _userPattern = [];
      emit(
          PatternError(errorMessage: 'Pattern should be at least 4 dots long'));
      emit(PatternInitial());
    } else {
      emit(PatternLoading());
      try {
        await _patternHive.addUser(email: event.email);
        await _patternFirestore.addUser(
          email: event.email,
          pattern: _userPattern,
        );
        emit(PatternSuccess());
        emit(PatternInitial());
      } catch (error) {
        emit(PatternError(errorMessage: 'Registration failed'));
        emit(PatternInitial());
      }
    }
  }

  bool userExistsLocal() {
    return _patternHive.isUserSaved();
  }

  String getLocalUserEmail() {
    return _patternHive.getUserEmail();
  }

  void _onPatternUpdated(
    PatternUpdated event,
    Emitter<PatternState> emit,
  ) {
    _userPattern = event.pattern;
    emit(PatternLoading());
    emit(PatternInitial());
    if (_currentView == AuthView.login) {
      add(LoginButtonPressed());
    }
  }

  Future<void> _onDeleteUserPressed(
    DeleteUserPressed event,
    Emitter<PatternState> emit,
  ) async {
    await _patternFirestore.deteleFirestoreAccount(email: getLocalUserEmail());
    await _patternHive.deleteUser();
  }
}
