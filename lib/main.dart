import 'package:fb_taskmanager/core/config/app_configuration.dart';
import 'package:fb_taskmanager/core/router/app_router.dart';
import 'package:fb_taskmanager/firebase_options.dart';
import 'package:fb_taskmanager/screens/auth/cubit/auth_cubit.dart';
import 'package:fb_taskmanager/screens/auth/cubit/auth_cubit_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppConfiguration()),
        BlocProvider(
          create: (context) => AuthCubit(
            firebaseAuth: AppConfiguration.i(context).state.authInstance,
          ),
        ),
      ],
      child: BlocListener<AuthCubit, AuthCubitState>(
        listener: (context, state) {
          AppRouter.router.refresh(); 
        },
        child: MaterialApp.router(
          title: 'Task Manager',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
          ),
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
