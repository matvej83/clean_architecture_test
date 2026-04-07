import 'dart:async';

import 'package:clean_architecture_test/core/constants/app_strings.dart';
import 'package:clean_architecture_test/core/domain/entity/avaliability_filter_entity.dart';
import 'package:clean_architecture_test/core/usecases/usecase.dart';
import 'package:clean_architecture_test/features/products/data/models/category_model.dart';
import 'package:clean_architecture_test/features/products/domain/usecases/create_category_usecase.dart';
import 'package:clean_architecture_test/features/products/domain/usecases/create_product_usecase.dart';
import 'package:clean_architecture_test/features/products/domain/usecases/delete_product_usecase.dart';
import 'package:clean_architecture_test/features/products/domain/usecases/fetch_categories_usecase.dart';
import 'package:clean_architecture_test/features/products/domain/usecases/fetch_products_usecase.dart';
import 'package:clean_architecture_test/features/products/domain/usecases/fetch_related_by_id_usecase.dart';
import 'package:clean_architecture_test/features/products/domain/usecases/upload_image_usecase.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_event.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_state.dart';
import 'package:clean_architecture_test/features/products/utils.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/product_model.dart';
import '../../domain/usecases/delete_category_usecase.dart';
import '../../domain/usecases/fetch_product_usecase.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final FetchProductsUseCase fetchProductsUseCase;
  final FetchProductUseCase fetchProductUseCase;
  final FetchCategoriesUseCase fetchCategoriesUseCase;
  final FetchRelatedByIdUseCase fetchRelatedByIdUseCase;
  final UploadImageUseCase uploadImageUseCase;
  final CreateProductUseCase createProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  final CreateCategoryUseCase createCategoryUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;

  ProductsBloc({
    required this.fetchProductsUseCase,
    required this.fetchCategoriesUseCase,
    required this.fetchProductUseCase,
    required this.fetchRelatedByIdUseCase,
    required this.uploadImageUseCase,
    required this.createProductUseCase,
    required this.deleteProductUseCase,
    required this.createCategoryUseCase,
    required this.deleteCategoryUseCase,
  }) : super(const ProductsState()) {
    on<ProductsFetched>(_onProductsFetched);
    on<ProductFetched>(_onProductFetched);
    on<CategoriesFetched>(_onCategoriesFetched);
    on<RelatedByIdFetched>(_onRelatedByIdFetched);
    on<CreatedProductCategorySelected>(_onCreatedProductCategorySelected);
    on<ImagePicked>(_onImagePicked);
    on<ImageRemoved>(_onImageRemoved);
    on<ImageUploaded>(_onImageUploaded);
    on<ProductCreated>(_onProductCreated);
    on<DataRemoved>(_onDataRemoved);
    on<ProductDeleted>(_onProductDeleted);
    on<CategoryCreated>(_onCategoryCreated);
    on<CategoryDeleted>(_onCategoryDeleted);
    on<FilterAdded>(_onFilterAdded);
    on<FilterRemoved>(_onFilterRemoved);
    on<FiltersSaved>(_onFiltersSaved);
  }

  FutureOr<void> _onProductsFetched(
    ProductsFetched event,
    Emitter<ProductsState> emit,
  ) async {
    if (!event.loadSilent) {
      emit(state.copyWith(isLoading: true));
    }
    if (event.categoryId != null) {
      emit(state.copyWith(selectedCategoryId: event.categoryId));
    }
    int? priceMin;
    int? priceMax;

    if (state.filters.isNotEmpty == true) {
      priceMin = state.filters
          .firstWhereOrNull((e) => e.identifier == AppStrings.amountMin)
          ?.apiValue;
      priceMax = state.filters
          .firstWhereOrNull((e) => e.identifier == AppStrings.amountMax)
          ?.apiValue;
    }

    final result = await fetchProductsUseCase(
      FetchProductsParams(
        categoryId: state.selectedCategoryId.isNotEmpty
            ? state.selectedCategoryId
            : null,
        search: event.search,
        priceMin: priceMin,
        priceMax: priceMax,
      ),
    );

    result.fold(
      (l) {
        String message = 'errors.serverError'.tr();
        if (l is InvalidCredentialsFailure) {
          message = 'errors.wrongEmailOrPassword'.tr();
        }
        emit(state.copyWith(error: message, isLoading: false));
      },
      (r) {
        emit(state.copyWith(products: r, isLoading: false));
      },
    );
  }

  FutureOr<void> _onProductFetched(
    ProductFetched event,
    Emitter<ProductsState> emit,
  ) async {
    emit(state.copyWith(isProductLoading: true));

    final result = await fetchProductUseCase(FetchProductParams(id: event.id));

    result.fold(
      (l) {
        String message = 'errors.serverError'.tr();
        if (l is InvalidCredentialsFailure) {
          message = 'errors.wrongEmailOrPassword'.tr();
        }
        emit(state.copyWith(error: message, isProductLoading: false));
      },
      (r) {
        emit(state.copyWith(product: r, isProductLoading: false));
      },
    );
  }

  FutureOr<void> _onCategoriesFetched(
    CategoriesFetched event,
    Emitter<ProductsState> emit,
  ) async {
    if (!event.loadSilent) {
      emit(state.copyWith(isLoading: true));
    }
    final result = await fetchCategoriesUseCase(NoParams());

    result.fold(
      (l) {
        String message = 'errors.serverError'.tr();
        if (l is InvalidCredentialsFailure) {
          message = 'errors.wrongEmailOrPassword'.tr();
        }
        emit(state.copyWith(error: message, isLoading: false));
      },
      (r) {
        emit(state.copyWith(categories: r, isLoading: false));
      },
    );
  }

  FutureOr<void> _onRelatedByIdFetched(
    RelatedByIdFetched event,
    Emitter<ProductsState> emit,
  ) async {
    final result = await fetchRelatedByIdUseCase(
      FetchRelatedByIdParams(id: event.id),
    );

    result.fold(
      (l) {
        String message = 'errors.serverError'.tr();
        if (l is InvalidCredentialsFailure) {
          message = 'errors.wrongEmailOrPassword'.tr();
        }
        emit(state.copyWith(error: message));
      },
      (r) {
        emit(state.copyWith(relatedById: r));
      },
    );
  }

  FutureOr<void> _onCreatedProductCategorySelected(
    CreatedProductCategorySelected event,
    Emitter<ProductsState> emit,
  ) async {
    emit(state.copyWith(createdProductCategoryId: event.categoryId));
  }

  FutureOr<void> _onImagePicked(
    ImagePicked event,
    Emitter<ProductsState> emit,
  ) async {
    final image = await ProductsUtils.getImageFromGallery();
    if (image != null) {
      var images = [...?state.pickedImages];
      images.add(image);
      emit(state.copyWith(pickedImages: images));
    }
  }

  FutureOr<void> _onImageRemoved(
    ImageRemoved event,
    Emitter<ProductsState> emit,
  ) async {
    var images = [...?state.pickedImages];
    images.remove(event.file);
    await ProductsUtils.removeImage(event.file);

    emit(state.copyWith(pickedImages: images));
  }

  FutureOr<void> _onImageUploaded(
    ImageUploaded event,
    Emitter<ProductsState> emit,
  ) async {
    final result = await uploadImageUseCase(
      UploadImageParams(image: event.image),
    );

    result.fold(
      (l) {
        String message = 'errors.serverError'.tr();
        if (l is InvalidCredentialsFailure) {
          message = 'errors.wrongEmailOrPassword'.tr();
        }
        emit(state.copyWith(error: message));
      },
      (r) {
        var list = [...?state.uploadedImages];
        list.add(r.location);
        emit(state.copyWith(uploadedImages: list));
      },
    );
  }

  FutureOr<void> _onProductCreated(
    ProductCreated event,
    Emitter<ProductsState> emit,
  ) async {
    emit(state.copyWith(isCreating: true));

    List<String> uploadedImages = [];

    if (state.pickedImages?.isNotEmpty == true) {
      for (final file in state.pickedImages!) {
        final result = await uploadImageUseCase(UploadImageParams(image: file));

        result.fold(
          (l) {
            emit(
              state.copyWith(
                error: 'errors.serverError'.tr(),
                isCreating: false,
              ),
            );
            return;
          },
          (r) {
            uploadedImages.add(r.location);
          },
        );
      }
    }

    final result = await createProductUseCase(
      CreateProductParams(
        product: ProductModel(
          title: event.title,
          price: event.price,
          description: event.description,
          categoryId: int.tryParse(state.createdProductCategoryId),
          images: uploadedImages,
        ),
      ),
    );

    result.fold(
      (l) {
        String? message;
        if (l is ServerFailure) {
          message = l.message;
        }
        emit(
          state.copyWith(
            error: message ?? 'errors.serverError'.tr(),
            isCreating: false,
          ),
        );
      },
      (r) {
        emit(state.copyWith(createdSuccessful: true, isCreating: false));
      },
    );
  }

  FutureOr<void> _onProductDeleted(
    ProductDeleted event,
    Emitter<ProductsState> emit,
  ) async {
    final result = await deleteProductUseCase.repository.deleteProduct(
      id: event.id,
    );
    result.fold(
      (l) {
        emit(
          state.copyWith(error: 'errors.serverError'.tr(), isCreating: false),
        );
      },
      (r) {
        add(ProductsFetched());
      },
    );
  }

  FutureOr<void> _onCategoryCreated(
    CategoryCreated event,
    Emitter<ProductsState> emit,
  ) async {
    emit(state.copyWith(isCreating: true));

    List<String> uploadedImages = [];

    if (state.pickedImages?.isNotEmpty == true) {
      final result = await uploadImageUseCase(
        UploadImageParams(image: state.pickedImages!.first),
      );

      result.fold(
        (l) {
          emit(
            state.copyWith(error: 'errors.serverError'.tr(), isCreating: false),
          );
          return;
        },
        (r) {
          uploadedImages.add(r.location);
        },
      );
    }

    final result = await createCategoryUseCase(
      CreateCategoryParams(
        category: CategoryModel(image: uploadedImages.first, name: event.name),
      ),
    );

    result.fold(
      (l) {
        emit(
          state.copyWith(error: 'errors.serverError'.tr(), isCreating: false),
        );
      },
      (r) {
        emit(state.copyWith(createdSuccessful: true, isCreating: false));
      },
    );
  }

  FutureOr<void> _onCategoryDeleted(
    CategoryDeleted event,
    Emitter<ProductsState> emit,
  ) async {
    final result = await deleteCategoryUseCase.repository.deleteCategory(
      id: event.id,
    );
    result.fold(
      (l) {
        emit(
          state.copyWith(error: 'errors.serverError'.tr(), isCreating: false),
        );
      },
      (r) {
        if (state.selectedCategoryId == event.id.toString()) {
          emit(state.copyWith(selectedCategoryId: ''));
          add(ProductsFetched());
        }
        add(CategoriesFetched());
      },
    );
  }

  FutureOr<void> _onDataRemoved(
    DataRemoved event,
    Emitter<ProductsState> emit,
  ) async {
    if (state.pickedImages?.isNotEmpty == true) {
      for (final file in state.pickedImages!) {
        await ProductsUtils.removeImage(file);
      }
    }
    emit(
      state.copyWith(
        isCreating: false,
        createdSuccessful: false,
        createdProductCategoryId: '',
        uploadedImages: [],
        pickedImages: [],
      ),
    );
  }

  FutureOr<void> _onFilterAdded(
    FilterAdded event,
    Emitter<ProductsState> emit,
  ) async {
    final filters = List<AvailabilityFilterEntity>.from(state.filters);
    filters.add(event.filter);
    emit(state.copyWith(filters: filters));
  }

  FutureOr<void> _onFilterRemoved(
    FilterRemoved event,
    Emitter<ProductsState> emit,
  ) async {
    final filters = List<AvailabilityFilterEntity>.from(state.filters);
    filters.remove(event.filter);
    emit(state.copyWith(filters: filters));
    add(ProductsFetched());
  }

  FutureOr<void> _onFiltersSaved(
    FiltersSaved event,
    Emitter<ProductsState> emit,
  ) async {
    emit(state.copyWith(filters: event.filters));
    add(ProductsFetched());
  }
}
