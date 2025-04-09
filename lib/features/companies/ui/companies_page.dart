import 'dart:ui';

import 'package:company_wiki/core/locator.dart';
import 'package:company_wiki/features/companies/ui/bloc/company_bloc.dart';
import 'package:company_wiki/features/companies/ui/bloc/company_event.dart';

import 'package:company_wiki/features/companies/ui/bloc/company_state.dart';
import 'package:company_wiki/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_button/flutter_social_button.dart';

import 'package:go_router/go_router.dart';

import 'package:url_launcher/url_launcher.dart';

class CompaniesPage extends StatelessWidget {
  static const String router = '/companies';
  final String provinciaId;
  final String provinciaName;

  const CompaniesPage({
    super.key,
    required this.provinciaId,
    required this.provinciaName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CompanyBloc>()..add(LoadCompanies(provinciaId)),
      child: CompaniesView(
        provincia: provinciaId,
        provinciaName: provinciaName,
      ),
    );
  }
}

class CompaniesView extends StatelessWidget {
  final String provincia;
  final String provinciaName;

  const CompaniesView({
    super.key,
    required this.provincia,
    required this.provinciaName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Empresas en $provinciaName'),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: BlocBuilder<CompanyBloc, CompanyState>(
        builder: (context, state) {
          if (state is CompanyLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CompanySuccess) {
            if (state.companies.isEmpty) {
              return const Center(
                child: Text('No hay empresas en esta provincia'),
              );
            }

            return ListView.builder(
              itemCount: state.companies.length,
              itemBuilder: (context, index) {
                final data = state.companies[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(0, 8),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 90, sigmaY: 50),
                        child: Material(
                          color: AppColors.skySecondary.withAlpha(
                            (0.9 * 255).toInt(),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['name'] ?? 'Sin nombre',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  data['description'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (data['linkedin'] != null &&
                                        data['linkedin'].toString().isNotEmpty)
                                      IconButton(
                                        icon: const FaIcon(
                                          FontAwesomeIcons.linkedin,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          launchUrl(
                                            Uri.parse(data['linkedin']),
                                          );
                                        },
                                      ),
                                    if (data['website'] != null &&
                                        data['website'].toString().isNotEmpty)
                                      IconButton(
                                        icon: const FaIcon(
                                          FontAwesomeIcons.globe,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          launchUrl(Uri.parse(data['website']));
                                        },
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is CompanyError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
