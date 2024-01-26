import 'package:fitness_application/features/auth/screens/login_screen.dart';
import 'package:fitness_application/features/workouts/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoutes = RouteMap(routes: {
    '/' : (_)=> const MaterialPage(child: LoginScreen()),
});

final loggedInRoutes = RouteMap(routes: {
    '/' : (_) => const MaterialPage(child: HomeScreen()),
});