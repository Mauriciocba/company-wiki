import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_wiki/core/locator.dart';
import 'package:company_wiki/features/companies/ui/bloc/company_bloc.dart';
import 'package:company_wiki/features/companies/ui/bloc/company_event.dart';
import 'package:company_wiki/features/create_company/model/company_model.dart';
import 'package:company_wiki/features/companies/ui/bloc/company_state.dart';
import 'package:company_wiki/features/home_page/ui/home_page.dart';
import 'package:company_wiki/features/provinces/models/pronvinces_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class CreateCompany extends StatefulWidget {
  static const router = '/create-company';
  const CreateCompany({super.key});

  @override
  State<CreateCompany> createState() => _CreateCompanyState();
}

class _CreateCompanyState extends State<CreateCompany> {
  final _formKey = GlobalKey<FormState>();
  String? selectedProvinceId;
  List<ProvincesModel> provinces = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController linkedinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProvinces();
  }

  Future<void> _loadProvinces() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('provinces').get();
    setState(() {
      provinces =
          snapshot.docs
              .map((doc) => ProvincesModel(id: doc.id, name: doc['name']))
              .toList();
    });
  }

  void _submit() {
    if (_formKey.currentState!.validate() && selectedProvinceId != null) {
      final bloc = getIt<CompanyBloc>();

      bloc.add(
        AddCompany(
          CompanyModel(
            id: nameController.text,
            name: nameController.text,
            description: descriptionController.text,
            provinceId: selectedProvinceId!,
            linkedin: linkedinController.text,
            website: websiteController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<CompanyBloc>(),
      child: BlocListener<CompanyBloc, CompanyState>(
        listener: (context, state) {
          if (state is CreateCompanyLoading) {
            showDialog(
              context: context,
              builder:
                  (context) => const Center(child: CircularProgressIndicator()),
            );
          }
          if (state is CreateCompanyError) {
            toastification.show(
              context: context,
              title: const Text('Error al guardar'),
              description: Text(state.message),
              type: ToastificationType.error,
            );
          } else if (state is CreateCompanySuccess) {
            toastification.show(
              context: context,
              title: const Text('Empresa guardada'),
              type: ToastificationType.success,
            );

            context.go(HomePage.router);

            nameController.clear();
            descriptionController.clear();
            websiteController.clear();
            linkedinController.clear();
            selectedProvinceId = null;

            Navigator.pop(context);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Agregar empresa'),
            leading: IconButton(
              onPressed: () => context.go(HomePage.router),
              icon: Icon(Icons.arrow_back_ios_new_outlined),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  DropdownButtonFormField<String>(
                    value: selectedProvinceId,
                    decoration: const InputDecoration(labelText: 'Provincia'),
                    items:
                        provinces.map((prov) {
                          return DropdownMenuItem(
                            value: prov.id,
                            child: Text(prov.name),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedProvinceId = value;
                      });
                    },
                    validator:
                        (value) =>
                            value == null ? 'Selecciona una provincia' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Completa el nombre'
                                : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'Descripción'),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: websiteController,
                    decoration: const InputDecoration(labelText: 'Sitio web'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: linkedinController,
                    decoration: const InputDecoration(labelText: 'LinkedIn'),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Guardar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
