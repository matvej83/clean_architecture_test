// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'products_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductsState {

 bool get isLoading; bool get isProductLoading; bool get createdSuccessful; bool get isCreating; String? get error; List<ProductEntity> get products; List<ProductEntity> get relatedById; ProductEntity? get product; List<CategoryEntity> get categories; String get selectedCategoryId; String get createdProductCategoryId; List<AppImageEntity>? get pickedImages; List<String>? get uploadedImages; List<AvailabilityFilterEntity> get filters;
/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductsStateCopyWith<ProductsState> get copyWith => _$ProductsStateCopyWithImpl<ProductsState>(this as ProductsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isProductLoading, isProductLoading) || other.isProductLoading == isProductLoading)&&(identical(other.createdSuccessful, createdSuccessful) || other.createdSuccessful == createdSuccessful)&&(identical(other.isCreating, isCreating) || other.isCreating == isCreating)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.products, products)&&const DeepCollectionEquality().equals(other.relatedById, relatedById)&&(identical(other.product, product) || other.product == product)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.selectedCategoryId, selectedCategoryId) || other.selectedCategoryId == selectedCategoryId)&&(identical(other.createdProductCategoryId, createdProductCategoryId) || other.createdProductCategoryId == createdProductCategoryId)&&const DeepCollectionEquality().equals(other.pickedImages, pickedImages)&&const DeepCollectionEquality().equals(other.uploadedImages, uploadedImages)&&const DeepCollectionEquality().equals(other.filters, filters));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isProductLoading,createdSuccessful,isCreating,error,const DeepCollectionEquality().hash(products),const DeepCollectionEquality().hash(relatedById),product,const DeepCollectionEquality().hash(categories),selectedCategoryId,createdProductCategoryId,const DeepCollectionEquality().hash(pickedImages),const DeepCollectionEquality().hash(uploadedImages),const DeepCollectionEquality().hash(filters));

@override
String toString() {
  return 'ProductsState(isLoading: $isLoading, isProductLoading: $isProductLoading, createdSuccessful: $createdSuccessful, isCreating: $isCreating, error: $error, products: $products, relatedById: $relatedById, product: $product, categories: $categories, selectedCategoryId: $selectedCategoryId, createdProductCategoryId: $createdProductCategoryId, pickedImages: $pickedImages, uploadedImages: $uploadedImages, filters: $filters)';
}


}

/// @nodoc
abstract mixin class $ProductsStateCopyWith<$Res>  {
  factory $ProductsStateCopyWith(ProductsState value, $Res Function(ProductsState) _then) = _$ProductsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isProductLoading, bool createdSuccessful, bool isCreating, String? error, List<ProductEntity> products, List<ProductEntity> relatedById, ProductEntity? product, List<CategoryEntity> categories, String selectedCategoryId, String createdProductCategoryId, List<AppImageEntity>? pickedImages, List<String>? uploadedImages, List<AvailabilityFilterEntity> filters
});




}
/// @nodoc
class _$ProductsStateCopyWithImpl<$Res>
    implements $ProductsStateCopyWith<$Res> {
  _$ProductsStateCopyWithImpl(this._self, this._then);

  final ProductsState _self;
  final $Res Function(ProductsState) _then;

/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isProductLoading = null,Object? createdSuccessful = null,Object? isCreating = null,Object? error = freezed,Object? products = null,Object? relatedById = null,Object? product = freezed,Object? categories = null,Object? selectedCategoryId = null,Object? createdProductCategoryId = null,Object? pickedImages = freezed,Object? uploadedImages = freezed,Object? filters = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isProductLoading: null == isProductLoading ? _self.isProductLoading : isProductLoading // ignore: cast_nullable_to_non_nullable
as bool,createdSuccessful: null == createdSuccessful ? _self.createdSuccessful : createdSuccessful // ignore: cast_nullable_to_non_nullable
as bool,isCreating: null == isCreating ? _self.isCreating : isCreating // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<ProductEntity>,relatedById: null == relatedById ? _self.relatedById : relatedById // ignore: cast_nullable_to_non_nullable
as List<ProductEntity>,product: freezed == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as ProductEntity?,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryEntity>,selectedCategoryId: null == selectedCategoryId ? _self.selectedCategoryId : selectedCategoryId // ignore: cast_nullable_to_non_nullable
as String,createdProductCategoryId: null == createdProductCategoryId ? _self.createdProductCategoryId : createdProductCategoryId // ignore: cast_nullable_to_non_nullable
as String,pickedImages: freezed == pickedImages ? _self.pickedImages : pickedImages // ignore: cast_nullable_to_non_nullable
as List<AppImageEntity>?,uploadedImages: freezed == uploadedImages ? _self.uploadedImages : uploadedImages // ignore: cast_nullable_to_non_nullable
as List<String>?,filters: null == filters ? _self.filters : filters // ignore: cast_nullable_to_non_nullable
as List<AvailabilityFilterEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductsState].
extension ProductsStatePatterns on ProductsState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductsState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductsState value)  $default,){
final _that = this;
switch (_that) {
case _ProductsState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductsState value)?  $default,){
final _that = this;
switch (_that) {
case _ProductsState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isProductLoading,  bool createdSuccessful,  bool isCreating,  String? error,  List<ProductEntity> products,  List<ProductEntity> relatedById,  ProductEntity? product,  List<CategoryEntity> categories,  String selectedCategoryId,  String createdProductCategoryId,  List<AppImageEntity>? pickedImages,  List<String>? uploadedImages,  List<AvailabilityFilterEntity> filters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductsState() when $default != null:
return $default(_that.isLoading,_that.isProductLoading,_that.createdSuccessful,_that.isCreating,_that.error,_that.products,_that.relatedById,_that.product,_that.categories,_that.selectedCategoryId,_that.createdProductCategoryId,_that.pickedImages,_that.uploadedImages,_that.filters);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isProductLoading,  bool createdSuccessful,  bool isCreating,  String? error,  List<ProductEntity> products,  List<ProductEntity> relatedById,  ProductEntity? product,  List<CategoryEntity> categories,  String selectedCategoryId,  String createdProductCategoryId,  List<AppImageEntity>? pickedImages,  List<String>? uploadedImages,  List<AvailabilityFilterEntity> filters)  $default,) {final _that = this;
switch (_that) {
case _ProductsState():
return $default(_that.isLoading,_that.isProductLoading,_that.createdSuccessful,_that.isCreating,_that.error,_that.products,_that.relatedById,_that.product,_that.categories,_that.selectedCategoryId,_that.createdProductCategoryId,_that.pickedImages,_that.uploadedImages,_that.filters);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isProductLoading,  bool createdSuccessful,  bool isCreating,  String? error,  List<ProductEntity> products,  List<ProductEntity> relatedById,  ProductEntity? product,  List<CategoryEntity> categories,  String selectedCategoryId,  String createdProductCategoryId,  List<AppImageEntity>? pickedImages,  List<String>? uploadedImages,  List<AvailabilityFilterEntity> filters)?  $default,) {final _that = this;
switch (_that) {
case _ProductsState() when $default != null:
return $default(_that.isLoading,_that.isProductLoading,_that.createdSuccessful,_that.isCreating,_that.error,_that.products,_that.relatedById,_that.product,_that.categories,_that.selectedCategoryId,_that.createdProductCategoryId,_that.pickedImages,_that.uploadedImages,_that.filters);case _:
  return null;

}
}

}

/// @nodoc


class _ProductsState implements ProductsState {
  const _ProductsState({this.isLoading = false, this.isProductLoading = false, this.createdSuccessful = false, this.isCreating = false, this.error, final  List<ProductEntity> products = const [], final  List<ProductEntity> relatedById = const [], this.product, final  List<CategoryEntity> categories = const [], this.selectedCategoryId = '', this.createdProductCategoryId = '', final  List<AppImageEntity>? pickedImages, final  List<String>? uploadedImages, final  List<AvailabilityFilterEntity> filters = const []}): _products = products,_relatedById = relatedById,_categories = categories,_pickedImages = pickedImages,_uploadedImages = uploadedImages,_filters = filters;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isProductLoading;
@override@JsonKey() final  bool createdSuccessful;
@override@JsonKey() final  bool isCreating;
@override final  String? error;
 final  List<ProductEntity> _products;
@override@JsonKey() List<ProductEntity> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

 final  List<ProductEntity> _relatedById;
@override@JsonKey() List<ProductEntity> get relatedById {
  if (_relatedById is EqualUnmodifiableListView) return _relatedById;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_relatedById);
}

@override final  ProductEntity? product;
 final  List<CategoryEntity> _categories;
@override@JsonKey() List<CategoryEntity> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override@JsonKey() final  String selectedCategoryId;
@override@JsonKey() final  String createdProductCategoryId;
 final  List<AppImageEntity>? _pickedImages;
@override List<AppImageEntity>? get pickedImages {
  final value = _pickedImages;
  if (value == null) return null;
  if (_pickedImages is EqualUnmodifiableListView) return _pickedImages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _uploadedImages;
@override List<String>? get uploadedImages {
  final value = _uploadedImages;
  if (value == null) return null;
  if (_uploadedImages is EqualUnmodifiableListView) return _uploadedImages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<AvailabilityFilterEntity> _filters;
@override@JsonKey() List<AvailabilityFilterEntity> get filters {
  if (_filters is EqualUnmodifiableListView) return _filters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filters);
}


/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductsStateCopyWith<_ProductsState> get copyWith => __$ProductsStateCopyWithImpl<_ProductsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isProductLoading, isProductLoading) || other.isProductLoading == isProductLoading)&&(identical(other.createdSuccessful, createdSuccessful) || other.createdSuccessful == createdSuccessful)&&(identical(other.isCreating, isCreating) || other.isCreating == isCreating)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other._products, _products)&&const DeepCollectionEquality().equals(other._relatedById, _relatedById)&&(identical(other.product, product) || other.product == product)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.selectedCategoryId, selectedCategoryId) || other.selectedCategoryId == selectedCategoryId)&&(identical(other.createdProductCategoryId, createdProductCategoryId) || other.createdProductCategoryId == createdProductCategoryId)&&const DeepCollectionEquality().equals(other._pickedImages, _pickedImages)&&const DeepCollectionEquality().equals(other._uploadedImages, _uploadedImages)&&const DeepCollectionEquality().equals(other._filters, _filters));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isProductLoading,createdSuccessful,isCreating,error,const DeepCollectionEquality().hash(_products),const DeepCollectionEquality().hash(_relatedById),product,const DeepCollectionEquality().hash(_categories),selectedCategoryId,createdProductCategoryId,const DeepCollectionEquality().hash(_pickedImages),const DeepCollectionEquality().hash(_uploadedImages),const DeepCollectionEquality().hash(_filters));

@override
String toString() {
  return 'ProductsState(isLoading: $isLoading, isProductLoading: $isProductLoading, createdSuccessful: $createdSuccessful, isCreating: $isCreating, error: $error, products: $products, relatedById: $relatedById, product: $product, categories: $categories, selectedCategoryId: $selectedCategoryId, createdProductCategoryId: $createdProductCategoryId, pickedImages: $pickedImages, uploadedImages: $uploadedImages, filters: $filters)';
}


}

/// @nodoc
abstract mixin class _$ProductsStateCopyWith<$Res> implements $ProductsStateCopyWith<$Res> {
  factory _$ProductsStateCopyWith(_ProductsState value, $Res Function(_ProductsState) _then) = __$ProductsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isProductLoading, bool createdSuccessful, bool isCreating, String? error, List<ProductEntity> products, List<ProductEntity> relatedById, ProductEntity? product, List<CategoryEntity> categories, String selectedCategoryId, String createdProductCategoryId, List<AppImageEntity>? pickedImages, List<String>? uploadedImages, List<AvailabilityFilterEntity> filters
});




}
/// @nodoc
class __$ProductsStateCopyWithImpl<$Res>
    implements _$ProductsStateCopyWith<$Res> {
  __$ProductsStateCopyWithImpl(this._self, this._then);

  final _ProductsState _self;
  final $Res Function(_ProductsState) _then;

/// Create a copy of ProductsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isProductLoading = null,Object? createdSuccessful = null,Object? isCreating = null,Object? error = freezed,Object? products = null,Object? relatedById = null,Object? product = freezed,Object? categories = null,Object? selectedCategoryId = null,Object? createdProductCategoryId = null,Object? pickedImages = freezed,Object? uploadedImages = freezed,Object? filters = null,}) {
  return _then(_ProductsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isProductLoading: null == isProductLoading ? _self.isProductLoading : isProductLoading // ignore: cast_nullable_to_non_nullable
as bool,createdSuccessful: null == createdSuccessful ? _self.createdSuccessful : createdSuccessful // ignore: cast_nullable_to_non_nullable
as bool,isCreating: null == isCreating ? _self.isCreating : isCreating // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductEntity>,relatedById: null == relatedById ? _self._relatedById : relatedById // ignore: cast_nullable_to_non_nullable
as List<ProductEntity>,product: freezed == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as ProductEntity?,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryEntity>,selectedCategoryId: null == selectedCategoryId ? _self.selectedCategoryId : selectedCategoryId // ignore: cast_nullable_to_non_nullable
as String,createdProductCategoryId: null == createdProductCategoryId ? _self.createdProductCategoryId : createdProductCategoryId // ignore: cast_nullable_to_non_nullable
as String,pickedImages: freezed == pickedImages ? _self._pickedImages : pickedImages // ignore: cast_nullable_to_non_nullable
as List<AppImageEntity>?,uploadedImages: freezed == uploadedImages ? _self._uploadedImages : uploadedImages // ignore: cast_nullable_to_non_nullable
as List<String>?,filters: null == filters ? _self._filters : filters // ignore: cast_nullable_to_non_nullable
as List<AvailabilityFilterEntity>,
  ));
}


}

// dart format on
