import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import 'auth_button.dart';
class SignInForm extends StatefulWidget {
  final bool isLoading;
  final void Function(String email, String password) onSubmit;
  final VoidCallback? onForgotPassword;

  const SignInForm({
    super.key,
    required this.isLoading,
    required this.onSubmit,
    this.onForgotPassword,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
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
    widget.onSubmit(_emailController.text.trim(), _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'EMAIL ADDRESS OR USERNAME',
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
            validator: (value) =>
            (value == null || value.trim().isEmpty) ? 'Enter your email' : null,
            decoration: const InputDecoration(
              hintText: 'mohamedali94316@gmail.com',
              prefixIcon: Icon(Icons.mail_outline, size: 20),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'PASSWORD',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.neutral,
                  letterSpacing: 0.4,
                ),
              ),
              if (widget.onForgotPassword != null)
                InkWell(
                  onTap: widget.onForgotPassword,
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            validator: (value) =>
            (value == null || value.isEmpty) ? 'Enter your password' : null,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              prefixIcon: const Icon(Icons.lock_outline, size: 20),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  size: 20,
                ),
                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
          ),
          const SizedBox(height: 24),
          buildAuthButton(
            label: 'Sign In',
            isLoading: widget.isLoading,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}