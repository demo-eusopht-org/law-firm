import 'dart:developer';

import 'package:case_management/utils/constants.dart';
import 'package:case_management/view/permission/permission_bloc/permission_state.dart';
import 'package:case_management/widgets/loader.dart';
import 'package:case_management/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/permission/app_config_response.dart';
import '../services/local_storage_service.dart';
import '../services/locator.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/text_widget.dart';
import 'auth_screens/login_screen.dart';
import 'permission/permission_bloc/permission_bloc.dart';
import 'permission/permission_bloc/permission_events.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        String? token = locator<LocalStorageService>().getData('token');
        log('TOKEN: ${token != null}');
        if (token != null) {
          BlocProvider.of<PermissionBloc>(context).add(
            GetConfigPermissionEvent(),
          );
        } else {
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        }
      },
    );
  }

  void _updateAppConfigNotifier(List<AppConfig> configs) {
    final permissions = configs.where((config) {
      return config.isAllowed;
    }).toList();
    configNotifier.value = permissions.map((permission) {
      return permission.permissionName;
    }).toList();
    return;
  }

  void _listener(BuildContext context, PermissionState state) {
    if (state is SuccessAppConfigState) {
      log('DATA: ${state.data.length}');
      _updateAppConfigNotifier(state.data);
      Navigator.pushReplacement(
        this.context,
        CupertinoPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
    } else if (state is ErrorPermissionState) {
      CustomToast.show(state.message);
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<PermissionBloc>(context),
      listener: _listener,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            textWidget(
              text: 'Welcome',
              fSize: 30.0,
              color: Colors.green,
              fWeight: FontWeight.w700,
            ),
            const SizedBox(
              height: 20,
            ),
            const Loader(),
          ],
        ),
        // body: Stack(
        //   alignment: Alignment.center,
        //   children: [
        //     Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         CircleAvatar(
        //           radius: 60,
        //         ),
        //         textWidget(
        //           text: 'Welcome',
        //           fSize: 30.0,
        //           color: Colors.black,
        //           fWeight: FontWeight.w700,
        //         ),
        //       ],
        //     ),
        //     Align(
        //       alignment: Alignment.bottomCenter,
        //       child: Image.asset(
        //         'assets/images/vector.png',
        //         height: Get.height * 0.7,
        //         width: Get.width,
        //         fit: BoxFit.cover,
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
