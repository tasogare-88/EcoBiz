import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'input_company_name_view_model.dart';

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
                      : () {
                          // TODO: Unityの会社設置場所選択画面への遷移を実装
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
