import 'package:company_wiki/core/locator.dart';
import 'package:company_wiki/features/companies/ui/bloc/company_bloc.dart';
import 'package:company_wiki/features/companies/ui/bloc/company_event.dart';

import 'package:company_wiki/features/companies/ui/bloc/company_state.dart';
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
                  child: Card(
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
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            data['description'] ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              if (data['linkedin'] != null &&
                                  data['linkedin'].toString().isNotEmpty)
                                FlutterSocialButton(
                                  iconSize: 30,
                                  onTap: () {
                                    launchUrl(Uri.parse(data['linkedin']));
                                  },
                                  mini: true,
                                  buttonType: ButtonType.linkedin,
                                  title: 'LinkedIn',
                                ),
                              if (data['web'] != null &&
                                  data['web'].toString().isNotEmpty)
                                RawMaterialButton(
                                  onPressed: () {
                                    launchUrl(Uri.parse(data['web']));
                                  },
                                  elevation: 2.0,
                                  fillColor: Colors.teal,
                                  padding: const EdgeInsets.all(12.0),
                                  shape: const CircleBorder(),
                                  child: const Icon(
                                    Icons.public,
                                    size: 30.0,
                                    color: Colors.white,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is CompanyError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox(); // Estado inicial
        },
      ),
    );
  }
}
