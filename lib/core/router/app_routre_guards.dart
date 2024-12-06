import 'dart:async';

import 'package:fb_taskmanager/screens/auth/cubit/auth_cubit.dart';
import 'package:fb_taskmanager/screens/auth/cubit/auth_cubit_state.dart';
import 'package:fb_taskmanager/screens/auth/pages/sign_in_screen.dart';
import 'package:fb_taskmanager/screens/task/pages/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRoutreGuards {
  static FutureOr<String?> notAuthorized(
    BuildContext context, GoRouterState state) {
      final authState = AuthCubit.i(context).state;

      if (authState is AuthCubitAuthorized) {
        return TaskScreen.path;
      }

      return null;
    }

  static FutureOr<String?> authrized(
    BuildContext context, GoRouterState state) {
      final authState = AuthCubit.i(context).state;

      if (authState is AuthCubitNotAuthorized) {
        return SignInScreen.path;
      }

      return null;
    }
}