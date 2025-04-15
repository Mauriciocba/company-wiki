import 'package:company_wiki/core/locator.dart';
import 'package:company_wiki/features/companies/ui/bloc/company_bloc.dart';
import 'package:company_wiki/features/companies/ui/bloc/company_event.dart';

import 'package:company_wiki/features/companies/ui/bloc/company_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_button/flutter_social_button.dart';

import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

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

  bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.isAbsolute &&
          (uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https'));
    } catch (e) {
      return false;
    }
  }

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
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  data['logo'] != null
                                      ? NetworkImage(data['logo'])
                                      : const AssetImage(
                                            'assets/images/logo.png',
                                          )
                                          as ImageProvider,
                              radius: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                data['name'] ?? 'Sin nombre',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          data['description'] ?? 'Sin descripción',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 12),
                        Divider(),
                        const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: FaIcon(
                                    FontAwesomeIcons.linkedin,
                                    size: 20,
                                    color:
                                        data['linkedin'] != null &&
                                                data['linkedin']
                                                    .toString()
                                                    .isNotEmpty
                                            ? Colors.blueGrey
                                            : Colors.grey.shade400,
                                  ),
                                  onPressed:
                                      () => handleLinkedInTap(
                                        data['linkedin']?.toString(),
                                        context,
                                      ),
                                ),
                                GestureDetector(
                                  onTap:
                                      () => handleLinkedInTap(
                                        data['linkedin']?.toString(),
                                        context,
                                      ),
                                  child: Text(
                                    'Ir a LinkedIn',
                                    style: TextStyle(
                                      color:
                                          data['linkedin'] != null &&
                                                  data['linkedin']
                                                      .toString()
                                                      .isNotEmpty
                                              ? Colors.blue.shade900
                                              : Colors.grey.shade400,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                IconButton(
                                  icon: FaIcon(
                                    FontAwesomeIcons.globe,
                                    size: 20,
                                    color:
                                        data['website'] != null &&
                                                data['website']
                                                    .toString()
                                                    .isNotEmpty
                                            ? Colors.blueGrey
                                            : Colors.grey.shade400,
                                  ),
                                  onPressed:
                                      () => handleWebsiteTap(
                                        data['website']?.toString(),
                                        context,
                                      ),
                                ),
                                GestureDetector(
                                  onTap:
                                      () => handleWebsiteTap(
                                        data['website']?.toString(),
                                        context,
                                      ),
                                  child: Text(
                                    'Ir al sitio web',
                                    style: TextStyle(
                                      color:
                                          data['website'] != null &&
                                                  data['website']
                                                      .toString()
                                                      .isNotEmpty
                                              ? Colors.blue.shade900
                                              : Colors.grey.shade400,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.person_add_alt_1),
                            const SizedBox(width: 8),
                            Text(
                              '${data['employees'] != null ? NumberFormat.decimalPattern('es_AR').format(int.parse(data['employees'])) : 'Sin'} Empleados',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
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

  void handleLinkedInTap(String? linkedinUrl, BuildContext context) {
    if (linkedinUrl != null && linkedinUrl.isNotEmpty) {
      if (isValidUrl(linkedinUrl)) {
        launchUrl(Uri.parse(linkedinUrl));
      } else {
        toastification.show(
          context: context,
          title: Text('URL inválida'),
          description: Text('El enlace de LinkedIn no es válido.'),
          type: ToastificationType.error,
          alignment: Alignment.topCenter,
          autoCloseDuration: Duration(seconds: 3),
        );
      }
    }
  }

  void handleWebsiteTap(String? website, BuildContext context) {
    if (website != null && website.isNotEmpty) {
      if (isValidUrl(website)) {
        launchUrl(Uri.parse(website));
      } else {
        toastification.show(
          context: context,
          title: Text('URL inválida'),
          description: Text('El enlace ingresado no es válido.'),
          type: ToastificationType.error,
          alignment: Alignment.topCenter,
          autoCloseDuration: Duration(seconds: 3),
        );
      }
    }
  }
}
