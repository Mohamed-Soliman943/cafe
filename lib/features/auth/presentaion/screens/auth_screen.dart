import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';

import '../../services/firebase_auth_service.dart';
import '../../../navigation/presentation/screens/navigation_screen.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/auth_toggle.dart';
import '../widgets/sign_in_form.dart';
import '../widgets/sign_up_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final AuthCubit _authCubit;
  bool _isSignIn = true;

  @override
  void initState() {
    super.initState();
    _authCubit = AuthCubit(FirebaseAuthService());
  }

  @override
  void dispose() {
    _authCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _authCubit,
      child: Scaffold(
        backgroundColor: AppColors.trinary,
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is LoginSuccess || state is RegisterSuccess) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const NavigationScreen()),
                    (route) => false,
              );
            }
          },
          builder: (context, state) {
            final bool isLoading = state is AuthLoading;

            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // --- brand header ---
                    Center(
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: const BoxDecoration(
                          color: AppColors.trinary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.coffee, color: AppColors.primary, size: 30),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'ROASTERY & CRAFT CAFE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _isSignIn ? 'Welcome Back' : 'Craft an Account',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isSignIn
                          ? 'Smells like good coffee. Ready for your freshly poured brew?'
                          : 'Join our neighborhood table for seasonal single-origin beans and rewards.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 13, color: AppColors.neutral, height: 1.4),
                    ),
                    const SizedBox(height: 28),

                    // --- toggle ---
                    buildAuthToggle(
                      isSignIn: _isSignIn,
                      onSignInTap: () => setState(() => _isSignIn = true),
                      onCreateAccountTap: () => setState(() => _isSignIn = false),
                    ),
                    const SizedBox(height: 24),

                    // --- form ---
                    _isSignIn
                        ? SignInForm(
                      isLoading: isLoading,
                      onSubmit: (email, password) => _authCubit.login(
                        email: email,
                        password: password,
                      ),
                      onForgotPassword: () {
                        // TODO: forgot-password flow
                      },
                    )
                        : SignUpForm(
                      isLoading: isLoading,
                      onSubmit: (email, password) {
                        _authCubit.register(
                          email: email,
                          password: password,
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    // --- terms ---
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(fontSize: 11, color: AppColors.neutral, height: 1.5),
                        children: [
                          TextSpan(text: 'By continuing, you savor our '),
                          TextSpan(
                            text: 'Terms of Roast',
                            style: TextStyle(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Tasting Privacy',
                            style: TextStyle(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
