import 'package:case_management/permission/permission_bloc/permission_bloc.dart';
import 'package:case_management/services/local_storage_service.dart';
import 'package:case_management/services/locator.dart';
import 'package:case_management/view/auth_screens/auth_bloc/auth_bloc.dart';
import 'package:case_management/view/cases/bloc/case_bloc.dart';
import 'package:case_management/view/customer/client_bloc/client_bloc.dart';
import 'package:case_management/view/history/bloc/history_bloc.dart';
import 'package:case_management/view/profile/profile_bloc/profile_bloc.dart';
import 'package:case_management/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'utils/constants.dart';
import 'view/lawyer/lawyer_bloc/lawyer_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        navigatorKey: Constants.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen(),
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
