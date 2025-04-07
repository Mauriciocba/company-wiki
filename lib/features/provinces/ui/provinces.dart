import 'package:company_wiki/core/locator.dart';
import 'package:company_wiki/features/companies/ui/companies_page.dart';
import 'package:company_wiki/features/home_page/ui/home_page.dart';
import 'package:company_wiki/features/provinces/ui/bloc/province_bloc.dart';
import 'package:company_wiki/features/provinces/ui/bloc/province_event.dart';

import 'package:company_wiki/features/provinces/ui/bloc/province_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProvincesPage extends StatelessWidget {
  static const String router = '/provinces';

  const ProvincesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProvinceBloc>()..add(LoadProvinces()),
      child: const ProvincesView(),
    );
  }
}

class ProvincesView extends StatelessWidget {
  const ProvincesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provincias'),
        leading: IconButton(
          onPressed: () => context.go(HomePage.router),
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: BlocBuilder<ProvinceBloc, ProvinceState>(
        builder: (context, state) {
          if (state is ProvinceLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProvinceSuccess) {
            final provinces = state.provinces;

            return ListView.builder(
              itemCount: provinces.length,
              itemBuilder: (context, index) {
                final prov = provinces[index];
                return ListTile(
                  title: Text(prov['name']),
                  onTap: () {
                    context.push(
                      CompaniesPage.router,
                      extra: {'id': prov['id'], 'name': prov['name']},
                    );
                  },
                );
              },
            );
          } else if (state is ProvinceError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox(); // Estado inicial
        },
      ),
    );
  }
}
