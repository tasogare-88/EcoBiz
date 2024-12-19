import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/constants/company_constants.dart';
import 'input_company_name_screen.dart';
import 'select_company_view_model.dart';

class SelectCompanyScreen extends ConsumerWidget {
  const SelectCompanyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(selectCompanyViewModelProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF6EC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'あなたはどの業界の\n会社をつくりますか？',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 2,
                  ),
                  itemCount: CompanyConstants.genres.length,
                  itemBuilder: (context, index) {
                    final genre =
                        CompanyConstants.genres.entries.elementAt(index);
                    return _GenreButton(
                      genre: genre.value,
                      isSelected: state.selectedGenre == genre.key,
                      onTap: () {
                        ref
                            .read(selectCompanyViewModelProvider.notifier)
                            .selectGenre(genre.key);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: state.selectedGenre.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => InputCompanyNameScreen(
                      selectedGenre: state.selectedGenre,
                    ),
                  ),
                );
              },
              backgroundColor: const Color(0xFFE1511B),
              label: const Text(
                '次へ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}

class _GenreButton extends StatelessWidget {
  final String genre;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenreButton({
    required this.genre,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? const Color(0xFFE1511B)
            : const Color(0xFFE1511B).withOpacity(0.7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        genre,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.9),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
