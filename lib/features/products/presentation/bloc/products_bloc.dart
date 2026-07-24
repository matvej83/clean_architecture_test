import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/core/domain/entity/availability_filter_entity.dart';
import 'package:store_app/core/usecases/usecase.dart';
import 'package:store_app/features/products/data/models/category_model.dart';
import 'package:store_app/features/products/domain/entity/product_entity.dart';
import 'package:store_app/features/products/domain/usecases/create_category_usecase.dart';
import 'package:store_app/features/products/domain/usecases/create_product_usecase.dart';
import 'package:store_app/features/products/domain/usecases/delete_product_usecase.dart';
import 'package:store_app/features/products/domain/usecases/fetch_categories_usecase.dart';
import 'package:store_app/features/products/domain/usecases/fetch_products_usecase.dart';
import 'package:store_app/features/products/domain/usecases/fetch_related_by_id_usecase.dart';
import 'package:store_app/features/products/domain/usecases/upload_image_usecase.dart';
import 'package:store_app/features/products/presentation/bloc/products_event.dart';
import 'package:store_app/features/products/presentation/bloc/products_state.dart';
import 'package:store_app/features/products/utils.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/product_model.dart';
import '../../domain/usecases/delete_category_usecase.dart';
import '../../domain/usecases/fetch_product_usecase.dart';

@lazySingleton
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc(
    this._fetchProductsUseCase,
    this._fetchCategoriesUseCase,
    this._fetchProductUseCase,
    this._fetchRelatedByIdUseCase,
    this._uploadImageUseCase,
    this._createProductUseCase,
    this._deleteProductUseCase,
    this._createCategoryUseCase,
    this._deleteCategoryUseCase,
  ) : super(const ProductsState()) {
    on<ProductsEvent>((event, emit) async {
      await event.map(
        dataInitialized: (e) => _onDataInitialized(e, emit),
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
        categorySearchStarted: (e) => _onCategorySearchStarted(e, emit),
        innerSearchDisabled: (e) => _onInnerSearchDisabled(e, emit),
        filterAdded: (e) => _onFilterAdded(e, emit),
        filterRemoved: (e) => _onFilterRemoved(e, emit),
        filtersSaved: (e) => _onFiltersSaved(e, emit),
      );
    });
  }

  final FetchProductsUseCase _fetchProductsUseCase;
  final FetchProductUseCase _fetchProductUseCase;
  final FetchCategoriesUseCase _fetchCategoriesUseCase;
  final FetchRelatedByIdUseCase _fetchRelatedByIdUseCase;
  final UploadImageUseCase _uploadImageUseCase;
  final CreateProductUseCase _createProductUseCase;
  final DeleteProductUseCase _deleteProductUseCase;
  final CreateCategoryUseCase _createCategoryUseCase;
  final DeleteCategoryUseCase _deleteCategoryUseCase;

  final int defaultLimit = 10;

  /// Initialize data
  Future<void> _onDataInitialized(
    DataInitialized event,
    Emitter<ProductsState> emit,
  ) async {
    add(const ProductsFetched(loadSilent: false));
    add(const CategoriesFetched(loadSilent: false));
  }

  /// Products list
  Future<void> _onProductsFetched(
    ProductsFetched event,
    Emitter<ProductsState> emit,
  ) async {
    if (!event.loadSilent) {
      emit(state.copyWith(isProductLoading: true));
    }

    final (min, max) = ProductsUtils.getPriceFilters(state.filters);

    final result = await _fetchProductsUseCase(
      FetchProductsParams(
        categoryId: state.selectedCategoryId.isNotEmpty
            ? state.selectedCategoryId
            : null,
        search: state.search,
        priceMin: min,
        priceMax: max,
        offset: 0,
        limit: defaultLimit,
      ),
    );

    result.fold(
      (l) {
        String message = 'errors.serverError'.tr();
        if (l is InvalidCredentialsFailure) {
          message = 'errors.wrongEmailOrPassword'.tr();
        }
        emit(state.copyWith(error: message, isProductLoading: false));
      },
      (r) {
        emit(
          state.copyWith(
            products: r,
            isProductLoading: false,
            hasReachedMaxProducts: r.length < defaultLimit,
          ),
        );
      },
    );
  }

  /// Load more products
  Future<void> _onNextProductsFetched(
    NextProductsFetched event,
    Emitter<ProductsState> emit,
  ) async {
    if (state.hasReachedMaxProducts || state.isShowProductLoader) return;
    emit(state.copyWith(isShowProductLoader: true));

    final (min, max) = ProductsUtils.getPriceFilters(state.filters);

    final result = await _fetchProductsUseCase(
      FetchProductsParams(
        categoryId: state.selectedCategoryId.isNotEmpty
            ? state.selectedCategoryId
            : null,
        search: state.search,
        priceMin: min,
        priceMax: max,
        offset: state.products.length,
        limit: defaultLimit,
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
        final isLastPage = r.length < defaultLimit;

        // remove duplicates
        final newProducts = r
            .where(
              (newProd) =>
                  !state.products.any((oldProd) => oldProd.id == newProd.id),
            )
            .toList();

        final products = <ProductEntity>[...state.products, ...newProducts];
        emit(
          state.copyWith(
            products: products,
            isShowProductLoader: false,
            hasReachedMaxProducts: isLastPage,
          ),
        );
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

    final result = await _fetchProductUseCase(FetchProductParams(id: event.id));

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
      emit(state.copyWith(isCategoriesLoading: true));
    }
    final result = await _fetchCategoriesUseCase(NoParams());

    result.fold(
      (l) {
        String message = 'errors.serverError'.tr();
        if (l is InvalidCredentialsFailure) {
          message = 'errors.wrongEmailOrPassword'.tr();
        }
        emit(state.copyWith(error: message, isCategoriesLoading: false));
      },
      (r) {
        emit(state.copyWith(categories: r, isCategoriesLoading: false));
      },
    );
  }

  /// Search category
  Future<void> _onCategorySearchStarted(
    CategorySearchStarted event,
    Emitter<ProductsState> emit,
  ) async {
    if (event.useForInnerSearch == true) {
      emit(state.copyWith(innerSearchCategory: event.search));
    } else {
      emit(state.copyWith(searchCategory: event.search));
    }
    final results = ProductsUtils.filterCategoriesBySearchTerm(
      state.categories,
      event.search,
    );
    if (event.useForInnerSearch == true) {
      emit(state.copyWith(innerCategorySearchResults: results));
    } else {
      emit(state.copyWith(categorySearchResults: results));
    }
  }

  /// Similar products
  Future<void> _onRelatedByIdFetched(
    RelatedByIdFetched event,
    Emitter<ProductsState> emit,
  ) async {
    final result = await _fetchRelatedByIdUseCase(
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
        final result = await _uploadImageUseCase(
          UploadImageParams(image: file),
        );

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

    final result = await _createProductUseCase(
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
    final result = await _deleteProductUseCase(
      DeleteProductParams(id: event.id),
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
      final result = await _uploadImageUseCase(
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

    final result = await _createCategoryUseCase(
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
    final result = await _deleteCategoryUseCase(
      DeleteCategoryParams(id: event.id),
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

  /// Disable inner search results
  Future<void> _onInnerSearchDisabled(
    InnerSearchDisabled event,
    Emitter<ProductsState> emit,
  ) async {
    emit(
      state.copyWith(innerCategorySearchResults: [], innerSearchCategory: ''),
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
