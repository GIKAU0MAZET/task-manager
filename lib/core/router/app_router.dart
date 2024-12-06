import 'package:fb_taskmanager/core/config/app_configuration.dart';
import 'package:fb_taskmanager/core/router/app_router_key.dart';
import 'package:fb_taskmanager/core/router/app_routre_guards.dart';
import 'package:fb_taskmanager/screens/auth/pages/sign_in_screen.dart';
import 'package:fb_taskmanager/screens/auth/pages/sign_up_screen.dart';
import 'package:fb_taskmanager/screens/settings/settings_screen.dart';
import 'package:fb_taskmanager/screens/task/cubit/task_cubit.dart';
import 'package:fb_taskmanager/screens/task/pages/new_task_screen.dart';
import 'package:fb_taskmanager/screens/task/pages/task_screen.dart';
import 'package:fb_taskmanager/screens/task/repository/task_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: AppRouterKey.rootKey,
    initialLocation: SignInScreen.path,
    redirect: (context, state) => null,
    routes: [
      ShellRoute(
        navigatorKey: AppRouterKey.dashboardKey,
        redirect: AppRoutreGuards.authrized,
        builder: (context, state, child) => BlocProvider(
          create: (context) {
            final appConfiguration = AppConfiguration.i(context).state;
            final firestore = appConfiguration.firestoreInstance;
            final user = appConfiguration.authInstance.currentUser!;
            final taskRepository =
                TaskRepository(firestore: firestore, user: user);

            return TaskCubit(taskRepository);
          },
          child: child,
        ),
        routes: [
          GoRoute(
            path: TaskScreen.path,
            builder: (context, state) => const TaskScreen(),
          ),
          GoRoute(
            path: NewTaskScreen.path,
            builder: (context, state) => const NewTaskScreen(),
          ),
          GoRoute(
            path: SettingsScreen.path,
            builder: (context, state) => const SettingsScreen(),
          )
        ],
      ),
      ShellRoute(
        navigatorKey: AppRouterKey.signKey,
        redirect: AppRoutreGuards.notAuthorized,
        builder: (context, state, child) => child,
        routes: [
          GoRoute(
            path: SignInScreen.path,
            builder: (context, state) => const SignInScreen(),
          ),
          GoRoute(
            path: SignUpScreen.path,
            builder: (context, state) => const SignUpScreen(),
          )
        ],
      ),
    ],
  );
}
