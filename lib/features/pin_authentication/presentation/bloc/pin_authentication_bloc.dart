import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_tester/features/pin_authentication/data/pin_authentication_firestore.dart';
import 'package:login_tester/features/pin_authentication/data/pin_authentication_hive.dart';
import 'package:login_tester/features/pin_authentication/data/user_model.dart';

part 'pin_authentication_event.dart';
part 'pin_authentication_state.dart';

enum AuthView { login, register }

class PinAuthenticationBloc
    extends Bloc<PinAuthenticationEvent, PinAuthenticationState> {
  final PinAuthenticationFirestore _pinFirestore;
  final PinAuthenticationHive _pinHive;

  PinAuthenticationBloc(this._pinFirestore, this._pinHive)
      : super(PinAuthenticationInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
    on<AuthViewChanged>(_onAuthViewChanged);
    on<PinCodeDeleting>(_onPinCodeDeleting);
    on<PinCodeUpdated>(_onPinCodeUpdated);
  }

  AuthView _currentView = AuthView.login;
  String _userPinCode = '';

  AuthView get currentView => _currentView;

  String get userPinCode => _userPinCode;

  void _onAuthViewChanged(
    AuthViewChanged event,
    Emitter<PinAuthenticationState> emit,
  ) {
    _currentView = event.view;
    emit(PinAuthenticationLoading());
    emit(PinAuthenticationInitial());
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<PinAuthenticationState> emit,
  ) async {
    if (_userPinCode.length != 4) {
      _userPinCode = '';
      emit(PinAuthenticationError(
          errorMessage: 'PIN code should be 4 characters long'));
      emit(PinAuthenticationInitial());
    } else {
      emit(PinAuthenticationLoading());

      try {
        final userEmail = _pinHive.getUserEmail();
        final userPinCode =
            await _pinFirestore.getUserPinCode(email: userEmail);
        if (userPinCode == _userPinCode) {
          emit(PinAuthenticationSuccess());
          emit(PinAuthenticationInitial());
        } else {
          _userPinCode = '';
          emit(PinAuthenticationError(
              errorMessage: 'The PIN you entered is incorrect'));
          emit(PinAuthenticationInitial());
        }
      } catch (error) {
        emit(PinAuthenticationError(
            errorMessage: error.toString().replaceFirst('Exception: ', '')));
        emit(PinAuthenticationInitial());
      }
    }
  }

  Future<void> _onRegisterButtonPressed(
    RegisterButtonPressed event,
    Emitter<PinAuthenticationState> emit,
  ) async {
    if (event.email.trim().isEmpty) {
      emit(PinAuthenticationError(errorMessage: 'Please fill in email field'));
      emit(PinAuthenticationInitial());
    } else if (_userPinCode.length != 4) {
      _userPinCode = '';
      emit(PinAuthenticationError(
          errorMessage: 'PIN code should be 4 characters long'));
      emit(PinAuthenticationInitial());
    } else {
      emit(PinAuthenticationLoading());
      try {
        await _pinHive.addUser(email: event.email);
        await _pinFirestore.addUser(
          userModel: UserModel(
            email: event.email,
            pinCode: _userPinCode,
          ),
        );
        emit(PinAuthenticationSuccess());
        emit(PinAuthenticationInitial());
      } catch (error) {
        emit(PinAuthenticationError(errorMessage: 'Registration failed'));
        emit(PinAuthenticationInitial());
      }
    }
  }

  bool userExistsLocal() {
    return _pinHive.isUserSaved();
  }

  String getLocalUserEmail() {
    return _pinHive.getUserEmail();
  }

  void _onPinCodeDeleting(
    PinCodeDeleting event,
    Emitter<PinAuthenticationState> emit,
  ) {
    if (event.operationType == 'remove' && _userPinCode.isNotEmpty) {
      _userPinCode = _userPinCode.substring(0, _userPinCode.length - 1);
    } else if (event.operationType == 'clear') {
      _userPinCode = '';
    }
    emit(PinAuthenticationLoading());
    emit(PinAuthenticationInitial());
  }

  void _onPinCodeUpdated(
    PinCodeUpdated event,
    Emitter<PinAuthenticationState> emit,
  ) {
    _userPinCode += event.text;
    emit(PinAuthenticationLoading());
    emit(PinAuthenticationInitial());
  }
}
