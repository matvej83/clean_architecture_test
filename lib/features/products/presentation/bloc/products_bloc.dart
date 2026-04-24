import 'dart:async';

import 'package:clean_architecture_test/core/domain/entity/availability_filter_entity.dart';
import 'package:clean_architecture_test/core/usecases/usecase.dart';
import 'package:clean_architecture_test/features/products/data/models/category_model.dart';
import 'package:clean_architecture_test/features/products/domain/entity/product_entity.dart';
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
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/product_model.dart';
import '../../domain/usecases/delete_category_usecase.dart';
import '../../domain/usecases/fetch_product_usecase.dart';

@lazySingleton
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
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
    on<ProductsEvent>((event, emit) async {
      await event.map(
        productsFetched: (e) => _onProductsFetched(e, emit),
        nextProductsFetched: (e) => _onNextProductsFetched(e, emit),
        productsSearchStarted: (e) => _onProductsSearchStarted(e, emit),
        productsCategorySelected: (e) => _onProductsCategorySelected(e, emit),
        productFetched: (e) => _onProductFetched(e, emit),
        categoriesFetched: (e) => _onCategoriesFetched(e, emit),
        relatedByIdFetched: (e) => _onRelatedByIdFetched(e, emit),
        createdProductCategorySelected: (e) =>
            _onCreatedProductCategorySelected(e, emit),
        imagePicked: (e) => _onImagePicked(e, emit),
        imageRemoved: (e) => _onImageRemoved(e, emit),
        productCreated: (e) => _onProductCreated(e, emit),
        dataRemoved: (e) => _onDataRemoved(e, emit),
        productDeleted: (e) => _onProductDeleted(e, emit),
        categoryCreated: (e) => _onCategoryCreated(e, emit),
        categoryDeleted: (e) => _onCategoryDeleted(e, emit),
        filterAdded: (e) => _onFilterAdded(e, emit),
        filterRemoved: (e) => _onFilterRemoved(e, emit),
        filtersSaved: (e) => _onFiltersSaved(e, emit),
      );
    });
  }

  final FetchProductsUseCase fetchProductsUseCase;
  final FetchProductUseCase fetchProductUseCase;
  final FetchCategoriesUseCase fetchCategoriesUseCase;
  final FetchRelatedByIdUseCase fetchRelatedByIdUseCase;
  final UploadImageUseCase uploadImageUseCase;
  final CreateProductUseCase createProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  final CreateCategoryUseCase createCategoryUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;

  /// Products list
  Future<void> _onProductsFetched(
    ProductsFetched event,
    Emitter<ProductsState> emit,
  ) async {
    if (!event.loadSilent) {
      emit(state.copyWith(isLoading: true));
    }

    final (min, max) = ProductsUtils.getPriceFilters(state.filters);

    final result = await fetchProductsUseCase(
      FetchProductsParams(
        categoryId: state.selectedCategoryId.isNotEmpty
            ? state.selectedCategoryId
            : null,
        search: state.search,
        priceMin: min,
        priceMax: max,
        offset: state.products.isEmpty ? 0 : state.products.length - 10,
        limit: 10,
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

  /// Load more products
  Future<void> _onNextProductsFetched(
    NextProductsFetched event,
    Emitter<ProductsState> emit,
  ) async {
    if (state.hasReachedMaxProducts) return;
    emit(state.copyWith(isShowProductLoader: true));

    final (min, max) = ProductsUtils.getPriceFilters(state.filters);

    final result = await fetchProductsUseCase(
      FetchProductsParams(
        categoryId: state.selectedCategoryId.isNotEmpty
            ? state.selectedCategoryId
            : null,
        search: state.search,
        priceMin: min,
        priceMax: max,
        offset: state.products.length,
        limit: 10,
      ),
    );

    result.fold(
      (l) {
        String message = 'errors.serverError'.tr();
        if (l is InvalidCredentialsFailure) {
          message = 'errors.wrongEmailOrPassword'.tr();
        }
        emit(state.copyWith(error: message, isShowProductLoader: false));
      },
      (r) {
        if (r.isEmpty) {
          return emit(
            state.copyWith(
              isShowProductLoader: false,
              hasReachedMaxProducts: true,
            ),
          );
        }
        final products = <ProductEntity>[...state.products, ...r];
        emit(state.copyWith(products: products, isShowProductLoader: false));
      },
    );
  }

  /// Search products
  Future<void> _onProductsSearchStarted(
    ProductsSearchStarted event,
    Emitter<ProductsState> emit,
  ) async {
    emit(state.copyWith(search: event.search));
    add(const ProductsFetched());
  }

  /// Filter products by category
  Future<void> _onProductsCategorySelected(
    ProductsCategorySelected event,
    Emitter<ProductsState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedCategoryId: event.categoryId ?? '',
        hasReachedMaxProducts: false,
      ),
    );
    add(const ProductsFetched());
  }

  /// Single product
  Future<void> _onProductFetched(
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

  /// Categories
  Future<void> _onCategoriesFetched(
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

  /// Similar products
  Future<void> _onRelatedByIdFetched(
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

  /// Select category ID when the new product is creating
  Future<void> _onCreatedProductCategorySelected(
    CreatedProductCategorySelected event,
    Emitter<ProductsState> emit,
  ) async {
    emit(
      state.copyWith(
        createdProductCategoryId: event.categoryId,
        hasReachedMaxProducts: false,
      ),
    );
  }

  Future<void> _onImagePicked(
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

  /// Remove selected image from the memory
  Future<void> _onImageRemoved(
    ImageRemoved event,
    Emitter<ProductsState> emit,
  ) async {
    var images = [...?state.pickedImages];
    images.remove(event.image);

    emit(state.copyWith(pickedImages: images));
  }

  Future<void> _onProductCreated(
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
        emit(
          state.copyWith(createdSuccessful: true, isCreating: false, error: ''),
        );
      },
    );
  }

  /// Delete partial product
  Future<void> _onProductDeleted(
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
        add(const ProductsFetched());
      },
    );
  }

  /// Create category
  Future<void> _onCategoryCreated(
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
        emit(
          state.copyWith(createdSuccessful: true, isCreating: false, error: ''),
        );
      },
    );
  }

  /// Delete partial category
  Future<void> _onCategoryDeleted(
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
          add(const ProductsFetched());
        }
        add(const CategoriesFetched());
      },
    );
  }

  /// Clear data when the product is created
  Future<void> _onDataRemoved(
    DataRemoved event,
    Emitter<ProductsState> emit,
  ) async {
    emit(
      state.copyWith(
        isCreating: false,
        createdSuccessful: false,
        createdProductCategoryId: '',
        error: '',
        uploadedImages: [],
        pickedImages: [],
      ),
    );
  }

  /// Filters actions
  Future<void> _onFilterAdded(
    FilterAdded event,
    Emitter<ProductsState> emit,
  ) async {
    final filters = List<AvailabilityFilterEntity>.from(state.filters);
    filters.add(event.filter);
    emit(state.copyWith(filters: filters, hasReachedMaxProducts: false));
  }

  Future<void> _onFilterRemoved(
    FilterRemoved event,
    Emitter<ProductsState> emit,
  ) async {
    final filters = List<AvailabilityFilterEntity>.from(state.filters);
    filters.remove(event.filter);
    emit(state.copyWith(filters: filters, hasReachedMaxProducts: false));
    add(const ProductsFetched());
  }

  Future<void> _onFiltersSaved(
    FiltersSaved event,
    Emitter<ProductsState> emit,
  ) async {
    emit(state.copyWith(filters: event.filters, hasReachedMaxProducts: false));
    add(const ProductsFetched());
  }
}
