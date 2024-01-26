import 'package:fitness_application/core/common/loader.dart';
import 'package:fitness_application/core/constants/constants.dart';
import 'package:fitness_application/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});
  void signInWithGoogle(BuildContext context, WidgetRef ref){
    ref.read(authControllerProvider.notifier).signInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: isLoading ? const Loader() : Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.network(Constants.logo, height: 300, width: 300,)),
          const SizedBox(height: 150,),
          SignInButton(Buttons.googleDark, onPressed: (){
            signInWithGoogle(context, ref);
          }),
        ],
      ),
    );
  }
}