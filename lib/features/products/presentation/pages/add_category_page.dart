import 'package:clean_architecture_test/core/presentation/widgets/app_message.dart';
import 'package:clean_architecture_test/features/products/data/models/product_model.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_bloc.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_event.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/widgets/app_text_form_field.dart';
import '../widgets/images_list.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  late ProductsBloc bloc;
  late TextTheme textTheme;
  late ProductModel product;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  void handleCreateCategory(ProductsState state) {
    if (_formKey.currentState!.validate()) {
      if (state.pickedImages?.isNotEmpty == true) {
        bloc.add(CategoryCreated(name: _nameController.text));
      } else {
        AppMessage.error(
          context,
          message: '${'addCategoryScreen.addImage'.tr()}!',
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
    bloc.add(const DataRemoved());
    super.deactivate();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('addCategoryScreen.screenName'.tr()),
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
            AppMessage.success(
              context,
              message: '${'addCategoryScreen.createdSuccess'.tr()}!',
            );
            bloc.add(const DataRemoved());
            _nameController.text = '';
            bloc.add(const CategoriesFetched());
          }
          if (state.error?.isNotEmpty == true) {
            AppMessage.error(context, message: state.error!);
          }
        },
        builder: (context, state) {
          final isLoading = state.isCreating;
          return Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                spacing: 16.0,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${'addCategoryScreen.addImage'.tr()}:',
                    style: textTheme.bodyLarge,
                  ),
                  ImagesList(
                    maxLength: 1,
                    images: state.pickedImages ?? [],
                    onTap: () {
                      if (!isLoading) {
                        bloc.add(const ImagePicked());
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
                            controller: _nameController,
                            enabled: !isLoading,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'addCategoryScreen.fieldName'.tr(),
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
                                    handleCreateCategory(state);
                                  },
                            child: isLoading
                                ? const SizedBox(
                                    width: 20.0,
                                    height: 20.0,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                    ),
                                  )
                                : Text('addCategoryScreen.createBtn'.tr()),
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
