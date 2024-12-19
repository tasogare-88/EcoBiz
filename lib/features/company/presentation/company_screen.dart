import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/presentation/auth_view_model.dart';
import 'company_view_model.dart';
import 'select_company_screen.dart';
import 'unity_company_place_screen.dart';

class CompanyScreen extends ConsumerStatefulWidget {
  const CompanyScreen({super.key});

  @override
  ConsumerState<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends ConsumerState<CompanyScreen> {
  bool? hasCompany;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _checkCompanyData());
  }

  Future<void> _checkCompanyData() async {
    final userId = ref.read(authViewModelProvider).maybeMap(
          authenticated: (state) => state.user.id,
          orElse: () => null,
        );

    if (userId == null) {
      setState(() => hasCompany = false);
      return;
    }

    final result = await ref
        .read(companyViewModelProvider.notifier)
        .hasCompanyData(userId);
    setState(() => hasCompany = result);
  }

  @override
  Widget build(BuildContext context) {
    if (hasCompany == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: hasCompany == true
          ? Consumer(
              builder: (context, ref, _) {
                final company = ref.watch(companyViewModelProvider).company;
                if (company == null) return const CircularProgressIndicator();

                return UnityCompanyPlaceScreen(
                  userId: company.id,
                  companyName: company.name,
                  genre: company.genre.name,
                  locationIndex: company.locationIndex,
                );
              },
            )
          : const SelectCompanyScreen(),
    );
  }
}
