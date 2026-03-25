import 'dart:async';

import 'package:clean_architecture_test/core/usecases/usecase.dart';
import 'package:clean_architecture_test/features/products/domain/usecases/fetch_products_usecase.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_event.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';

@lazySingleton
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final FetchProductsUseCase fetchProductsUseCase;

  ProductsBloc({required this.fetchProductsUseCase})
    : super(const ProductsState()) {
    on<ProductsFetched>(_onProductsFetched);
  }

  FutureOr<void> _onProductsFetched(
    ProductsFetched event,
    Emitter<ProductsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await fetchProductsUseCase(NoParams());

    result.fold(
      (l) {
        String message = 'Server error';
        if (l is InvalidCredentialsFailure) {
          message = 'Wrong email or password';
        }
        emit(state.copyWith(error: message, isLoading: false));
      },
      (r) {
        emit(state.copyWith(products: r, isLoading: false));
      },
    );
  }
}
