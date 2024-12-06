import 'package:fb_taskmanager/screens/auth/cubit/auth_cubit.dart';
import 'package:fb_taskmanager/screens/auth/pages/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String path = '/sign_up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

final emailController = TextEditingController();
final passwordController = TextEditingController();

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Регистрация'),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () => context.go(SignInScreen.path),
              child: const Text('Авторизация'),
            )
          ],
        ),
        body: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: emailController,
                  decoration:
                      const InputDecoration(label: Text('Введите вашу почту')),
                ),
                TextField(
                  controller: passwordController,
                  decoration:
                      const InputDecoration(label: Text('Введите ваш пароль')),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () { context.read<AuthCubit>().signUp(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                  },
                  child: const Text('Зарегистрироваться'),
                ),
              ],
            ),
          ),
        ));
  }
}
