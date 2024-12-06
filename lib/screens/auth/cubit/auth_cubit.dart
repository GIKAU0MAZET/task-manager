import 'dart:async';

import 'package:fb_taskmanager/screens/auth/cubit/auth_cubit_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  final FirebaseAuth _firebaseAuth;
  late StreamSubscription<User?> _streamSubscription;

  static AuthCubit i(BuildContext context) => context.read<AuthCubit>();

  AuthCubit({
    required FirebaseAuth firebaseAuth,
  })  : _firebaseAuth = firebaseAuth,
        super(AuthCubitLoading()) {
    _streamSubscription =
        _firebaseAuth.authStateChanges().listen(_onAuthStateChange);
  }

  void _onAuthStateChange(User? user) {
    if (user != null) {
      emit(AuthCubitAuthorized(user: user));
    } else {
      emit(AuthCubitNotAuthorized());
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(AuthCubitLoading());
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthCubitAuthorized(user: result.user!));
    } catch (e) {
      emit(AuthCubitNotAuthorized(error: e));
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    emit(AuthCubitLoading());
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthCubitAuthorized(user: result.user!));
    } catch (e) {
      emit(AuthCubitNotAuthorized(error: e));
    }
  }

  Future<void> signOut() async {
    try {
      _firebaseAuth.signOut();
    } finally {
      emit(AuthCubitNotAuthorized());
    }
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
