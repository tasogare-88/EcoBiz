import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_view_model.dart';
import 'sign_in_screen.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('アカウント登録')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'パスワード',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'パスワードを入力してください';
                  }
                  if (value.length < 6) {
                    return 'パスワードは6文字以上で入力してください';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'パスワード（確認）',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'パスワードを入力してください';
                  }
                  if (value != _passwordController.text) {
                    return 'パスワードが一致しません';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              if (authState.maybeMap(
                authenticated: (state) => state.isLoading,
                unauthenticated: (state) => state.isLoading,
                orElse: () => false,
              ))
                const CircularProgressIndicator(),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await ref.read(authViewModelProvider.notifier).signUp(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                      }
                    },
                    child: const Text('登録'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    },
                    child: const Text('すでにアカウントをお持ちの方はこちら'),
                  ),
                ],
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
    );
  }
}
