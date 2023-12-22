import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_tester/auth_screen.dart';
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
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthScreen(),
      ),
    ),
  );
}
