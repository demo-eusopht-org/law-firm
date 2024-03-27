import 'package:case_management/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'services/local_storage_service.dart';
import 'services/locator.dart';
import 'utils/constants.dart';
import 'view/auth_screens/auth_bloc/auth_bloc.dart';
import 'view/cases/bloc/case_bloc.dart';
import 'view/cause/bloc/cause_bloc.dart';
import 'view/client/client_bloc/client_bloc.dart';
import 'view/history/bloc/history_bloc.dart';
import 'view/lawyer/lawyer_bloc/lawyer_bloc.dart';
import 'view/permission/permission_bloc/permission_bloc.dart';
import 'view/profile/profile_bloc/profile_bloc.dart';
import 'view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await initializeLocator();
  await locator<LocalStorageService>().initializeBox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.linear(1.0),
      ),
      child: MaterialApp(
        // localizationsDelegates: [
        //   // AppLocalization.delegate,
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        // supportedLocales: [
        //   Locale('en'), // English
        //   Locale('ur'), // urdu
        // ],
        navigatorKey: Constants.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Lawyer\'s Firm',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => AuthBloc(),
              ),
              BlocProvider(
                create: (_) => LawyerBloc(),
              ),
              BlocProvider(
                create: (_) => CaseBloc(),
              ),
              BlocProvider(
                create: (_) => HistoryBloc(),
              ),
              BlocProvider(
                create: (_) => ClientBloc(),
              ),
              BlocProvider(
                create: (_) => ProfileBloc(),
              ),
              BlocProvider(
                create: (_) => CauseBloc(),
              ),
              BlocProvider(
                create: (_) => PermissionBloc(),
              ),
            ],
            child: child!,
          );
        },
      ),
    );
  }
}
