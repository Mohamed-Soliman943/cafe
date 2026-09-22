import 'package:cafe/features/auth/presentaion/screens/auth_screen.dart';
import 'package:cafe/features/navigation/presentation/screens/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentaion/cubit/auth_cubit.dart';


class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {

        if (state is AuthInitial || state is AuthLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is Authenticated) {
          return NavigationScreen();
        }

        return AuthScreen();
      },
    );
  }
}