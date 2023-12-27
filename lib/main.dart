import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_tester/auth_screen.dart';
import 'package:login_tester/features/email_password/data/email_password_firebase.dart';
import 'package:login_tester/features/email_password/presentation/bloc/email_password_bloc.dart';
import 'package:login_tester/features/login_selection/provider/login_provider.dart';
import 'package:login_tester/features/phone_number/data/phone_number_firebase.dart';
import 'package:login_tester/features/phone_number/presentation/bloc/phone_number_bloc.dart';
import 'package:login_tester/helpers/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
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
            create: (context) => EmailPasswordBloc(
              EmailPasswordFirebase(),
            ),
          ),
          BlocProvider(
            create: (context) => PhoneNumberBloc(
              PhoneNumberFirebase(),
            ),
          )
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AuthScreen(),
        ),
      ),
    ),
  );
}
