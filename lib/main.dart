import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_tester/auth_screen.dart';
import 'package:login_tester/features/email_password/data/auth_firebase.dart';
import 'package:login_tester/features/email_password/presentation/bloc/email_password_bloc.dart';
import 'package:login_tester/features/login_selection/provider/login_provider.dart';
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
      child: BlocProvider(
        create: (context) => EmailPasswordBloc(
          AuthFirebase(),
        ),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AuthScreen(),
        ),
      ),
    ),
  );
}
