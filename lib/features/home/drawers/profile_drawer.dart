import 'dart:ui';
import 'package:fitness_application/core/pallet/pallet.dart';
import 'package:fitness_application/features/auth/controller/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

  void toggleTheme(WidgetRef ref) {
    ref.read(themeNotifierProvider.notifier).toggleTheme();
  }

  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logOut();
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.profilePic),
                radius: 70,
              ),
              const SizedBox(height: 10),
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.sunny),
                    Switch.adaptive(value: ref.watch(themeNotifierProvider.notifier).mode == ThemeMode.light ? false : true, onChanged: (value)=> toggleTheme(ref)),
                    const Icon(Icons.nightlight_round_rounded)
                  ],
                ),
              ),
              ListTile(
                  title: const Text('Log out'),
                  leading: Icon(Icons.exit_to_app, color: Pallet.redColor,),
                  onTap: () => logOut(ref)
              )
            ],
          ),
        ),
      ),
    );
  }
}
