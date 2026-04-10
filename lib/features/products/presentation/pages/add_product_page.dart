import 'package:clean_architecture_test/features/products/data/models/product_model.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_bloc.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_event.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/widgets/app_text_form_field.dart';
import '../widgets/categories_list.dart';
import '../widgets/images_list.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  late ProductsBloc bloc;
  late TextTheme textTheme;
  late ProductModel product;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  void handleCreateProduct(ProductsState state) {
    if (_formKey.currentState!.validate()) {
      if (state.createdProductCategoryId.isNotEmpty == true &&
          state.pickedImages?.isNotEmpty == true) {
        bloc.add(
          ProductCreated(
            title: _titleController.text,
            description: _descriptionController.text,
            price: int.tryParse(_priceController.text) ?? 0,
          ),
        );
      } else {
        final message = (state.pickedImages ?? []).isEmpty
            ? 'addImages'
            : 'selectCategory';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${'addProductScreen.$message'.tr()}!'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = context.read<ProductsBloc>();
    textTheme = Theme.of(context).textTheme;
  }

  @override
  void deactivate() {
    bloc.add(DataRemoved());
    super.deactivate();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('addProductScreen.screenName'.tr()),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
        ),
      ),
      body: BlocConsumer<ProductsBloc, ProductsState>(
        listenWhen: (previous, current) {
          if (previous.createdSuccessful != current.createdSuccessful &&
              current.createdSuccessful) {
            return true;
          }
          if (previous.error != current.error &&
              current.error?.isNotEmpty == true) {
            return true;
          }
          return previous != current;
        },
        listener: (context, state) {
          if (state.createdSuccessful) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${'addProductScreen.createdSuccess'.tr()}!'),
                backgroundColor: Colors.green,
              ),
            );
            bloc.add(DataRemoved());
            _titleController.text = '';
            _descriptionController.text = '';
            _priceController.text = '';
          }
          if (state.error?.isNotEmpty == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state.isCreating;
          return Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0),
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                spacing: 16.0,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${'addProductScreen.selectCategory'.tr()}:',
                    style: textTheme.titleMedium,
                  ),
                  CategoriesList(
                    categories: state.categories,
                    selectedCategoryId: state.createdProductCategoryId,
                    onTap: (category) {
                      if (!isLoading) {
                        bloc.add(
                          CreatedProductCategorySelected(
                            categoryId: category.id,
                          ),
                        );
                      }
                    },
                  ),
                  Text(
                    '${'addProductScreen.addImages'.tr()}:',
                    style: textTheme.bodyLarge,
                  ),
                  ImagesList(
                    images: state.pickedImages ?? [],
                    onTap: () {
                      if (!isLoading) {
                        bloc.add(ImagePicked());
                      }
                    },
                    onRemove: (image) {
                      if (!isLoading) {
                        bloc.add(ImageRemoved(image: image));
                      }
                    },
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 16.0,
                        children: [
                          AppTextFormField(
                            controller: _titleController,
                            enabled: !isLoading,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'addProductScreen.fieldTitle'.tr(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'fieldValidation.notEmpty'.tr();
                              }
                              return null;
                            },
                          ),
                          AppTextFormField(
                            controller: _priceController,
                            enabled: !isLoading,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'addProductScreen.fieldPrice'.tr(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'fieldValidation.notEmpty'.tr();
                              }
                              return null;
                            },
                          ),
                          AppTextFormField(
                            controller: _descriptionController,
                            enabled: !isLoading,
                            decoration: InputDecoration(
                              labelText: 'addProductScreen.fieldDescription'
                                  .tr(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'fieldValidation.notEmpty'.tr();
                              }
                              return null;
                            },
                          ),
                          ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    handleCreateProduct(state);
                                  },
                            child: isLoading
                                ? SizedBox(
                                    width: 20.0,
                                    height: 20.0,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                    ),
                                  )
                                : Text('addProductScreen.createBtn'.tr()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
