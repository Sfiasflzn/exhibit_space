// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/services/firebase_service.dart';
import 'blocs/auth/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ExhibitSpaceApp());
}

class ExhibitSpaceApp extends StatelessWidget {
  const ExhibitSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseService = FirebaseService();
    final authBloc = AuthBloc(firebaseService)..add(AuthCheckRequested());

    return BlocProvider(
      create: (_) => authBloc,
      child: MaterialApp.router(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        routerConfig: AppRouter.router(authBloc),
      ),
    );
  }
}
