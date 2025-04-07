import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/companies/ui/companies_page.dart';
import '../features/create_company/ui/create_company.dart';
import '../features/home_page/ui/home_page.dart';
import '../features/provinces/ui/provinces.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: HomePage.router,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: ProvincesPage.router,
      builder: (context, state) => const ProvincesPage(),
    ),
    GoRoute(
      path: CreateCompany.router,
      builder: (context, state) => const CreateCompany(),
    ),
    GoRoute(
      path: CompaniesPage.router,
      name: CompaniesPage.router,
      pageBuilder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return MaterialPage(
          child: CompaniesPage(
            provinciaId: data['id'],
            provinciaName: data['name'],
          ),
        );
      },
    ),
  ],
);
