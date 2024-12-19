import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/presentation/auth_view_model.dart';
import 'input_company_name_view_model.dart';
import 'unity_company_place_screen.dart';

class InputCompanyNameScreen extends ConsumerWidget {
  final String selectedGenre;

  const InputCompanyNameScreen({
    super.key,
    required this.selectedGenre,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(inputCompanyNameViewModelProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF6EC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '会社名を\n入力してください',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                onChanged: (value) {
                  ref
                      .read(inputCompanyNameViewModelProvider.notifier)
                      .updateCompanyName(value);
                },
                decoration: InputDecoration(
                  hintText: '会社名を入力',
                  errorText: state.error,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state.companyName.isEmpty
                      ? null
                      : () async {
                          final userId =
                              ref.read(authViewModelProvider).maybeMap(
                                    authenticated: (state) => state.user.id,
                                    orElse: () => null,
                                  );

                          if (userId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('ユーザー情報の取得に失敗しました')),
                            );
                            return;
                          }

                          await ref
                              .read(inputCompanyNameViewModelProvider.notifier)
                              .createCompany(
                                userId: userId,
                                genre: selectedGenre,
                              );

                          if (!context.mounted) return;

                          if (state.error != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.error!)),
                            );
                            return;
                          }

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => UnityCompanyPlaceScreen(
                                userId: userId,
                                companyName: state.companyName,
                                genre: selectedGenre,
                              ),
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE1511B),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    '決定',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
