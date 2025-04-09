import 'package:company_wiki/features/create_company/ui/new_company.dart';
import 'package:company_wiki/features/provinces/ui/provinces.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  static const router = '/';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          buildImageHomePage(),
          Container(color: Colors.black.withAlpha((0.4 * 255).toInt())),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTitleText(),
              const SizedBox(height: 10),
              buildTextButtonStart(context),
              const SizedBox(height: 10),
              buildTextButtonCreateCompany(context),
            ],
          ),
        ],
      ),
    );
  }

  TextButton buildTextButtonStart(BuildContext context) {
    return TextButton(
      onPressed: () => context.push(ProvincesPage.router),
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      child: const Text('Comenzar', style: TextStyle(fontSize: 15)),
    );
  }

  TextButton buildTextButtonCreateCompany(BuildContext context) {
    return TextButton(
      onPressed: () => context.push(NewCompanyPage.router),
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      child: const Text('Cargar Empresa', style: TextStyle(fontSize: 15)),
    );
  }

  Center buildTitleText() {
    return const Center(
      child: Text(
        'Empresas de Software',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  Image buildImageHomePage() {
    return Image.asset('assets/images/blurred_city.png', fit: BoxFit.cover);
  }
}
