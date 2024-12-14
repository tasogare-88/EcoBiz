import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../../../shared/constants/auth_styles.dart';
import '../../../shared/widgets/app_logo.dart';
import 'auth_view_model.dart';
import 'sign_up_screen.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('ログイン')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: AuthStyles.horizontalPadding,
              right: AuthStyles.horizontalPadding,
              top: 32.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const AppLogo(size: AuthStyles.logoSize),
                  const SizedBox(height: AuthStyles.verticalSpacing),
                  const Text(
                    AuthStyles.welcomeText,
                    style: TextStyle(
                      fontSize: AuthStyles.welcomeTextSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AuthStyles.verticalSpacing * 2),
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxWidth: AuthStyles.maxWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'メールアドレス',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'メールアドレスを入力してください';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AuthStyles.verticalSpacing),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'パスワード',
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'パスワードを入力してください';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                            height: AuthStyles.verticalSpacing * 1.5),
                        if (authState.maybeMap(
                          authenticated: (state) => state.isLoading,
                          unauthenticated: (state) => state.isLoading,
                          orElse: () => false,
                        ))
                          const Center(child: CircularProgressIndicator()),
                        if (!authState.maybeMap(
                          authenticated: (state) => state.isLoading,
                          unauthenticated: (state) => state.isLoading,
                          orElse: () => false,
                        ))
                          SizedBox(
                            height: AuthStyles.buttonHeight,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await ref
                                      .read(authViewModelProvider.notifier)
                                      .signIn(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AuthStyles.primaryButtonColor,
                                foregroundColor:
                                    AuthStyles.primaryButtonTextColor,
                              ),
                              child: const Text(
                                'ログイン',
                                style: TextStyle(
                                  fontSize: AuthStyles.buttonTextSize,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: AuthStyles.verticalSpacing),
                        const Center(
                          child: Text(
                            AuthStyles.orText,
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                        const SizedBox(height: AuthStyles.verticalSpacing),
                        SizedBox(
                          height: AuthStyles.googleButtonHeight,
                          child: SignInButton(
                            Buttons.google,
                            text: AuthStyles.continueWithGoogle,
                            onPressed: () async {
                              await ref
                                  .read(authViewModelProvider.notifier)
                                  .signInWithGoogle();
                            },
                          ),
                        ),
                        const SizedBox(
                            height: AuthStyles.verticalSpacing * 1.5),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: const Text('アカウントをお持ちでない方はこちら'),
                        ),
                      ],
                    ),
                  ),
                  if (authState.maybeMap(
                    authenticated: (state) => state.error != null,
                    unauthenticated: (state) => state.error != null,
                    orElse: () => false,
                  ))
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        authState.maybeMap(
                          authenticated: (state) => state.error!,
                          unauthenticated: (state) => state.error!,
                          orElse: () => '',
                        ),
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
