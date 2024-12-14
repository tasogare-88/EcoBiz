import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'パスワードを入力してください';
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
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await ref.read(authViewModelProvider.notifier).signIn(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                      }
                    },
                    child: const Text('ログイン'),
                  ),
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
                          style: TextStyle(color: Colors.red),
                        ))
                ],
              ),
            )));
  }
}
