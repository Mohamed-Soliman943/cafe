import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import 'auth_button.dart';

class SignUpForm extends StatefulWidget {
  final bool isLoading;
  final void Function(String email, String password) onSubmit;

  const SignUpForm({
    super.key,
    required this.isLoading,
    required this.onSubmit,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    widget.onSubmit(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // EMAIL
          const Text(
            'EMAIL ADDRESS',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.neutral,
              letterSpacing: 0.4,
            ),
          ),

          const SizedBox(height: 8),

          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofillHints: const [
              AutofillHints.email,
            ],
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Enter your email';
              }

              final email = value.trim();

              final emailRegex = RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              );

              if (!emailRegex.hasMatch(email)) {
                return 'Enter a valid email';
              }

              return null;
            },
            decoration: const InputDecoration(
              hintText: 'example@email.com',
              prefixIcon: Icon(
                Icons.mail_outline,
                size: 20,
              ),
            ),
          ),

          const SizedBox(height: 18),

          // PASSWORD
          const Text(
            'PASSWORD',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.neutral,
              letterSpacing: 0.4,
            ),
          ),

          const SizedBox(height: 8),

          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.done,
            autofillHints: const [
              AutofillHints.newPassword,
            ],
            onFieldSubmitted: (_) {
              if (!widget.isLoading) {
                _submit();
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter a password';
              }

              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }

              return null;
            },
            decoration: InputDecoration(
              hintText: 'Enter your password',
              prefixIcon: const Icon(
                Icons.lock_outline,
                size: 20,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
          ),

          const SizedBox(height: 24),

          buildAuthButton(
            label: 'Create Account',
            isLoading: widget.isLoading,
            onPressed: widget.isLoading ? null : _submit,
          ),
        ],
      ),
    );
  }
}