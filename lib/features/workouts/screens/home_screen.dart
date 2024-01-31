import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_application/core/common/error_text.dart';
import 'package:fitness_application/core/common/loader.dart';
import 'package:fitness_application/core/router.dart';
import 'package:fitness_application/core/widgets/steps_card.dart';
import 'package:fitness_application/features/workouts/controller/workout_controller.dart';
import 'package:fitness_application/features/workouts/repository/workout_backend_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitness_application/models/user_model.dart';
import 'package:routemaster/routemaster.dart';
import '../../auth/controller/auth_controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void logOut(){
    ref.read(authControllerProvider.notifier).logOut();
    setState(() {
      Routemaster.of(context).push('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final status = ref.watch(statusprovider);
    return Scaffold(
      appBar: AppBar(
        title: Text("home"),
        centerTitle: true,
      ),
      body: const StepsCard(),
    );
  }
}
