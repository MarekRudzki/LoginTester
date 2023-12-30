import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_tester/auth_screen.dart';
import 'package:login_tester/features/anonymous/data/anonymous_firebase.dart';
import 'package:login_tester/features/anonymous/presentation/bloc/anonymous_bloc.dart';
import 'package:login_tester/features/email_password/data/email_password_firebase.dart';
import 'package:login_tester/features/email_password/presentation/bloc/email_password_bloc.dart';
import 'package:login_tester/features/login_selection/provider/login_provider.dart';
import 'package:login_tester/features/pattern_unlock/data/pattern_firestore.dart';
import 'package:login_tester/features/pattern_unlock/data/pattern_hive.dart';
import 'package:login_tester/features/pattern_unlock/presentation/bloc/pattern_bloc.dart';
import 'package:login_tester/features/phone_number/data/phone_number_firebase.dart';
import 'package:login_tester/features/phone_number/presentation/bloc/phone_number_bloc.dart';
import 'package:login_tester/features/pin_authentication/data/pin_authentication_firestore.dart';
import 'package:login_tester/features/pin_authentication/data/pin_authentication_hive.dart';
import 'package:login_tester/features/pin_authentication/presentation/bloc/pin_authentication_bloc.dart';
import 'package:login_tester/features/social_media_accounts/data/social_media_accounts_firebase.dart';
import 'package:login_tester/features/social_media_accounts/presentation/bloc/social_media_accounts_bloc.dart';
import 'package:login_tester/helpers/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load();
  await Hive.initFlutter();
  await Hive.openBox('pin_auth');
  await Hive.openBox('pattern_auth');

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AnonymousBloc(
              AnonymousFirebase(),
            ),
          ),
          BlocProvider(
            create: (context) => EmailPasswordBloc(
              EmailPasswordFirebase(),
            ),
          ),
          BlocProvider(
            create: (context) => PhoneNumberBloc(
              PhoneNumberFirebase(),
            ),
          ),
          BlocProvider(
            create: (context) => SocialMediaAccountsBloc(
              SocialMediaAccountsFirebase(),
            ),
          ),
          BlocProvider(
            create: (context) => PinAuthenticationBloc(
              PinAuthenticationFirestore(),
              PinAuthenticationHive(),
            ),
          ),
          BlocProvider(
            create: (context) => PatternBloc(
              PatternFirestore(),
              PatternHive(),
            ),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AuthScreen(),
        ),
      ),
    ),
  );
}
