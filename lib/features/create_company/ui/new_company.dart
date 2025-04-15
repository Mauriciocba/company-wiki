import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_wiki/core/locator.dart';
import 'package:company_wiki/features/companies/ui/bloc/company_bloc.dart';
import 'package:company_wiki/features/companies/ui/bloc/company_event.dart';
import 'package:company_wiki/features/companies/ui/bloc/company_state.dart';
import 'package:company_wiki/features/create_company/model/company_model.dart';
import 'package:company_wiki/features/home_page/ui/home_page.dart';
import 'package:company_wiki/features/provinces/models/pronvinces_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

class NewCompanyPage extends StatefulWidget {
  static const router = '/create-company';
  const NewCompanyPage({super.key});

  @override
  State<NewCompanyPage> createState() => _NewCompanyPageState();
}

class _NewCompanyPageState extends State<NewCompanyPage> {
  File? _logoImage;
  final _formKey = GlobalKey<FormState>();
  String? selectedProvinceId;
  final bloc = getIt<CompanyBloc>();
  List<ProvincesModel> provinces = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController linkedinController = TextEditingController();
  final TextEditingController employeesController = TextEditingController();
  final TextEditingController logoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProvinces();
  }

  Future<void> _pickLogoImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _logoImage = File(pickedFile.path);
      });
    } else {
      Exception('No se seleccionó ninguna imagen');
    }
  }

  Future<String?> _uploadLogoToFirebase(
    String provinceId,
    String companyId,
  ) async {
    if (_logoImage == null) {
      Exception('No hay imagen seleccionada para subir.');
      return null;
    }

    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();

      final ref = FirebaseStorage.instance.ref().child(
        'provinces/$provinceId/companies/$companyId/logo/$fileName.jpg',
      );

      await ref.putFile(_logoImage!);
      final downloadUrl = await ref.getDownloadURL();

      return downloadUrl;
    } on FirebaseException catch (e) {
      Exception('Error al subir la imagen: ${e.message}');
      return null;
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar empresa'),
        leading: IconButton(
          onPressed: () => context.go(HomePage.router),
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: BlocProvider.value(
        value: bloc,
        child: BlocListener<CompanyBloc, CompanyState>(
          listener: (context, state) {
            if (state is CreateCompanyLoading) {
              showDialog(
                context: context,
                builder:
                    (context) =>
                        const Center(child: CircularProgressIndicator()),
              );
            }
            if (state is CreateCompanyError) {
              toastification.show(
                context: context,
                autoCloseDuration: Duration(seconds: 2),
                title: const Text('Error al guardar'),
                description: Text(state.message),
                type: ToastificationType.error,
              );
            }
            if (state is CreateCompanySuccess) {
              toastification.show(
                context: context,
                autoCloseDuration: Duration(seconds: 2),
                title: const Text('Empresa guardada'),
                type: ToastificationType.success,
              );
              context.go(HomePage.router);
            }
          },
          child: Padding(
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
                    maxLength: 50,
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
                    maxLength: 450
                  ),
                  TextFormField(
                    controller: employeesController,
                    decoration: const InputDecoration(
                      labelText: 'Número de Empleados',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa un número';
                      }
                      return null;
                    },
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
                  SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: _pickLogoImage,
                        icon: Icon(Icons.image),
                        label: Text('Seleccionar logo'),
                      ),
                      const SizedBox(width: 8),
                      if (_logoImage != null) Text('Logo seleccionado'),
                    ],
                  ),

                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate() &&
                          selectedProvinceId != null) {
                        final companyId =
                            FirebaseFirestore.instance
                                .collection('companies')
                                .doc()
                                .id;
                        final logoUrl = await _uploadLogoToFirebase(
                          selectedProvinceId!,
                          companyId,
                        );
                        bloc.add(
                          AddCompany(
                            CompanyModel(
                              id: companyId,
                              name: nameController.text,
                              description: descriptionController.text,
                              provinceId: selectedProvinceId!,
                              linkedin: linkedinController.text,
                              website: websiteController.text,
                              logoUrl:
                                  logoUrl ??
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRl3KRLQ-4_EdCiWdQ5WVmZBhS4HCHiTxV71A&s',
                              employees: int.tryParse(employeesController.text),
                            ),
                          ),
                        );
                      }
                      //context.go(HomePage.router);
                    },
                    child: const Text('Guardar'),
                  ),
                ],
              ),
            ),
          ), // Use the NewCompanyForm widget
        ),
      ),
    );
  }
}
