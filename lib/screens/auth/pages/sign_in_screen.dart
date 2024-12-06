import 'package:fb_taskmanager/screens/auth/cubit/auth_cubit.dart';
import 'package:fb_taskmanager/screens/auth/cubit/auth_cubit_state.dart';
import 'package:fb_taskmanager/screens/auth/pages/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String path = '/sign_in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

final emailController = TextEditingController();
final passwordController = TextEditingController();

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Авторизация'),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () => context.go(SignUpScreen.path),
              child: const Text('Регистрация'),
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
                  onPressed: () => context.read<AuthCubit>().signIn(
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                  child: BlocBuilder<AuthCubit, AuthCubitState>(
                    builder: (context, state) {
                      if (state is AuthCubitLoading) {
                        return const SizedBox.square(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return const Text('Войти');
                    }
                  )
                )
              ],
            ),
          ),
        ));
  }
}
