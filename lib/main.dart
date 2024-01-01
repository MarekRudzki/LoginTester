// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_tester/helpers/di.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:login_tester/auth_screen.dart';
import 'package:login_tester/features/anonymous/presentation/bloc/anonymous_bloc.dart';
import 'package:login_tester/features/email_password/presentation/bloc/email_password_bloc.dart';
import 'package:login_tester/features/fingerprint_recognition/bloc/fingerprint_bloc.dart';
import 'package:login_tester/features/login_selection/provider/login_provider.dart';
import 'package:login_tester/features/pattern_unlock/presentation/bloc/pattern_bloc.dart';
import 'package:login_tester/features/phone_number/presentation/bloc/phone_number_bloc.dart';
import 'package:login_tester/features/pin_authentication/presentation/bloc/pin_authentication_bloc.dart';
import 'package:login_tester/features/social_media_accounts/presentation/bloc/social_media_accounts_bloc.dart';
import 'package:login_tester/helpers/firebase_options.dart';

void main() async {
  await dotenv.load();

  await Hive.initFlutter();
  await Hive.openBox('pin_auth');
  await Hive.openBox('pattern_auth');

  configureDependencies();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then(
    (_) => runApp(
      ChangeNotifierProvider(
        create: (context) => LoginProvider(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<AnonymousBloc>()),
            BlocProvider(create: (context) => getIt<EmailPasswordBloc>()),
            BlocProvider(create: (context) => getIt<PhoneNumberBloc>()),
            BlocProvider(create: (context) => getIt<SocialMediaAccountsBloc>()),
            BlocProvider(create: (context) => getIt<PinAuthenticationBloc>()),
            BlocProvider(create: (context) => getIt<PatternBloc>()),
            BlocProvider(create: (context) => getIt<FingerprintBloc>()),
          ],
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: AuthScreen(),
          ),
        ),
      ),
    ),
  );
}
