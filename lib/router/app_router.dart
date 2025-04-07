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
      pageBuilder: (context, state) => _buildPageWithTransition(
        const HomePage(),
      ),
    ),
    GoRoute(
      path: ProvincesPage.router,
      pageBuilder: (context, state) => _buildPageWithTransition(
        const ProvincesPage(),
      ),
    ),
    GoRoute(
      path: CreateCompany.router,
      pageBuilder: (context, state) => _buildPageWithTransition(
        const CreateCompany(),
      ),
    ),
    GoRoute(
      path: CompaniesPage.router,
      name: CompaniesPage.router,
      pageBuilder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return _buildPageWithTransition(
          CompaniesPage(
            provinciaId: data['id'],
            provinciaName: data['name'],
          ),
        );
      },
    ),
  ],
);

CustomTransitionPage _buildPageWithTransition(Widget child) {
  return CustomTransitionPage(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Slide from right
      final tween = Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeInOut));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}
