import 'package:fb_taskmanager/screens/auth/cubit/auth_cubit.dart';
import 'package:fb_taskmanager/screens/auth/cubit/auth_cubit_state.dart';
import 'package:fb_taskmanager/screens/task/pages/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const String path = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go(TaskScreen.path),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text('Настройки'),
        centerTitle: true,
      ),
      body: BlocBuilder<AuthCubit, AuthCubitState>(
        builder: (context, state) {
          if (state is AuthCubitAuthorized) {
            return ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: const Text('Почта'),
                  subtitle: Text(state.user.email!),
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  onTap: AuthCubit.i(context).signOut,
                  title: const Text('Выйти из аккаунта'),
                )
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
