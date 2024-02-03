import 'dart:isolate';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_application/core/common/error_text.dart';
import 'package:fitness_application/core/common/loader.dart';
import 'package:fitness_application/core/pallet/pallet.dart';
import 'package:fitness_application/core/router.dart';
import 'package:fitness_application/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'firebase_options.dart';
import 'models/user_model.dart';

void printHello() {
  final DateTime now = DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  print("[$now] Hello, world! isolate=$isolateId function='$printHello'");

}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AndroidAlarmManager.initialize();
  print("hi");
  runApp(const ProviderScope(child: MyApp()));
  //TODO: link the firebase saving function here
  await AndroidAlarmManager.periodic(const Duration(days: 1), 0, printHello);
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;
  void getData(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
      data: (data) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Fitness app',
        theme: ref.watch(themeNotifierProvider),
        routerDelegate: RoutemasterDelegate(
            routesBuilder: (context){
              if (data != null){
                getData(ref, data);
              }
              if (userModel != null){
                return loggedInRoutes;
              }
              return loggedOutRoutes;
            },
        ),
        routeInformationParser: const RoutemasterParser(),
      ),
      error: (error, stacktrace)=> ErrorText(error: error.toString(),),
      loading: ()=> const Loader(),
    );
  }
}


