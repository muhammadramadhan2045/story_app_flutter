import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/app_constants.dart';
import '../common/app_theme.dart';
import '../provider/auth_provider.dart';
import '../utils/gradient_background.dart';
import '../widgets/app_text_form_field.dart';

class RegisterPage extends StatefulWidget {
  final Function() onRegister;
  final Function() onLogin;

  const RegisterPage(
      {super.key, required this.onRegister, required this.onLogin});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

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
                "Register",
                style: AppTheme.titleLarge,
              ),
              SizedBox(height: 6),
              Text("Create Your Account!", style: AppTheme.bodySmall),
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
                    controller: nameController,
                    labelText: "Name",
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onChanged: (_) => formKey.currentState?.validate(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
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
                  const SizedBox(height: 8),
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
                  context.watch<AuthProvider>().isLoadingRegister
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              final scaffoldMessenger =
                                  ScaffoldMessenger.of(context);
                              final authRead = context.read<AuthProvider>();
                              final result = await authRead.register(
                                nameController.text,
                                emailController.text,
                                passwordController.text,
                              );
                              debugPrint("result register: ${result.message}");
                              if (result.message == "User created") {
                                scaffoldMessenger.showSnackBar(
                                  const SnackBar(
                                    content: Text("Register success"),
                                  ),
                                );
                                widget.onRegister();
                              } else {
                                scaffoldMessenger.showSnackBar(
                                  SnackBar(
                                    content: Text(authRead.message),
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text("REGISTER"),
                        ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () => widget.onLogin(),
                    child: const Text("LOGIN"),
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
