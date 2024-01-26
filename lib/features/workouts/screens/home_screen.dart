import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_application/core/common/error_text.dart';
import 'package:fitness_application/core/common/loader.dart';
import 'package:fitness_application/core/router.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("home"),
        centerTitle: true,
      ),
      body: MaterialButton(
        onPressed: (){
          logOut();
        },
        child: Text('logout'),
      )
    );
  }
}
