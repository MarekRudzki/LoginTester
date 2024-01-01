// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../features/anonymous/data/anonymous_firebase.dart' as _i3;
import '../features/anonymous/presentation/bloc/anonymous_bloc.dart' as _i12;
import '../features/email_password/data/email_password_firebase.dart' as _i4;
import '../features/email_password/presentation/bloc/email_password_bloc.dart'
    as _i13;
import '../features/fingerprint_recognition/bloc/fingerprint_bloc.dart' as _i5;
import '../features/pattern_unlock/data/pattern_firestore.dart' as _i6;
import '../features/pattern_unlock/data/pattern_hive.dart' as _i7;
import '../features/pattern_unlock/presentation/bloc/pattern_bloc.dart' as _i14;
import '../features/phone_number/data/phone_number_firebase.dart' as _i8;
import '../features/phone_number/presentation/bloc/phone_number_bloc.dart'
    as _i15;
import '../features/pin_authentication/data/pin_authentication_firestore.dart'
    as _i9;
import '../features/pin_authentication/data/pin_authentication_hive.dart'
    as _i10;
import '../features/pin_authentication/presentation/bloc/pin_authentication_bloc.dart'
    as _i16;
import '../features/social_media_accounts/data/social_media_accounts_firebase.dart'
    as _i11;
import '../features/social_media_accounts/presentation/bloc/social_media_accounts_bloc.dart'
    as _i17;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.AnonymousFirebase>(() => _i3.AnonymousFirebase());
    gh.lazySingleton<_i4.EmailPasswordFirebase>(
        () => _i4.EmailPasswordFirebase());
    gh.factory<_i5.FingerprintBloc>(() => _i5.FingerprintBloc());
    gh.lazySingleton<_i6.PatternFirestore>(() => _i6.PatternFirestore());
    gh.lazySingleton<_i7.PatternHive>(() => _i7.PatternHive());
    gh.lazySingleton<_i8.PhoneNumberFirebase>(() => _i8.PhoneNumberFirebase());
    gh.lazySingleton<_i9.PinAuthenticationFirestore>(
        () => _i9.PinAuthenticationFirestore());
    gh.lazySingleton<_i10.PinAuthenticationHive>(
        () => _i10.PinAuthenticationHive());
    gh.lazySingleton<_i11.SocialMediaAccountsFirebase>(
        () => _i11.SocialMediaAccountsFirebase());
    gh.factory<_i12.AnonymousBloc>(
        () => _i12.AnonymousBloc(gh<_i3.AnonymousFirebase>()));
    gh.factory<_i13.EmailPasswordBloc>(
        () => _i13.EmailPasswordBloc(gh<_i4.EmailPasswordFirebase>()));
    gh.factory<_i14.PatternBloc>(() => _i14.PatternBloc(
          gh<_i6.PatternFirestore>(),
          gh<_i7.PatternHive>(),
        ));
    gh.factory<_i15.PhoneNumberBloc>(
        () => _i15.PhoneNumberBloc(gh<_i8.PhoneNumberFirebase>()));
    gh.factory<_i16.PinAuthenticationBloc>(() => _i16.PinAuthenticationBloc(
          gh<_i9.PinAuthenticationFirestore>(),
          gh<_i10.PinAuthenticationHive>(),
        ));
    gh.factory<_i17.SocialMediaAccountsBloc>(() =>
        _i17.SocialMediaAccountsBloc(gh<_i11.SocialMediaAccountsFirebase>()));
    return this;
  }
}
