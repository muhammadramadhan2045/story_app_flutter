import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/utils/gradient_background.dart';

import '../common/app_constants.dart';
import '../common/app_theme.dart';
import '../provider/auth_provider.dart';
import '../widgets/app_text_form_field.dart';

class LoginPage extends StatefulWidget {
  final Function() onLogin;
  final Function() onRegister;

  const LoginPage({super.key, required this.onLogin, required this.onRegister});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    debugPrint(
      "apakah sudah: ${Provider.of<AuthProvider>(context, listen: false).token}",
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const GradientBackground(
            children: [
              Text(
                "Login",
                style: AppTheme.titleLarge,
              ),
              SizedBox(height: 6),
              Text("Share Your Story!", style: AppTheme.bodySmall),
            ],
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppTextFormField(
                    controller: emailController,
                    labelText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onChanged: (_) => formKey.currentState?.validate(),
                    validator: (value) {
                      return value!.isEmpty
                          ? "Email is required"
                          : AppConstants.emailRegex.hasMatch(value)
                              ? null
                              : "Invalid email format";
                    },
                  ),
                  AppTextFormField(
                    controller: passwordController,
                    labelText: "Password",
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    onChanged: (_) => formKey.currentState?.validate(),
                    validator: (value) {
                      return value!.isEmpty
                          ? "Password is required"
                          : AppConstants.passwordRegex.hasMatch(value)
                              ? null
                              : "Invalid password format";
                    },
                  ),
                  const SizedBox(height: 8),
                  context.watch<AuthProvider>().isLoadingLogin
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              final scaffoldMessenger =
                                  ScaffoldMessenger.of(context);
                              final authRead = context.read<AuthProvider>();
                              final result = await authRead.login(
                                emailController.text,
                                passwordController.text,
                              );
                              if (result.message == "success") {
                                widget.onLogin();
                              } else {
                                scaffoldMessenger.showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Your email or password is invalid"),
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text("LOGIN"),
                        ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () => widget.onRegister(),
                    child: const Text("REGISTER"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
