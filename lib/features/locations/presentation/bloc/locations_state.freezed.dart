// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'locations_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocationsState {

 bool get isLoading; bool get showGeoModal; String? get error; List<LocationEntity> get locations; String? get selectedLocationId; LocationEntity? get selectedLocation; List<Marker> get markers; LatLng get center;
/// Create a copy of LocationsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationsStateCopyWith<LocationsState> get copyWith => _$LocationsStateCopyWithImpl<LocationsState>(this as LocationsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.showGeoModal, showGeoModal) || other.showGeoModal == showGeoModal)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.locations, locations)&&(identical(other.selectedLocationId, selectedLocationId) || other.selectedLocationId == selectedLocationId)&&(identical(other.selectedLocation, selectedLocation) || other.selectedLocation == selectedLocation)&&const DeepCollectionEquality().equals(other.markers, markers)&&(identical(other.center, center) || other.center == center));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,showGeoModal,error,const DeepCollectionEquality().hash(locations),selectedLocationId,selectedLocation,const DeepCollectionEquality().hash(markers),center);

@override
String toString() {
  return 'LocationsState(isLoading: $isLoading, showGeoModal: $showGeoModal, error: $error, locations: $locations, selectedLocationId: $selectedLocationId, selectedLocation: $selectedLocation, markers: $markers, center: $center)';
}


}

/// @nodoc
abstract mixin class $LocationsStateCopyWith<$Res>  {
  factory $LocationsStateCopyWith(LocationsState value, $Res Function(LocationsState) _then) = _$LocationsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool showGeoModal, String? error, List<LocationEntity> locations, String? selectedLocationId, LocationEntity? selectedLocation, List<Marker> markers, LatLng center
});


$LocationEntityCopyWith<$Res>? get selectedLocation;

}
/// @nodoc
class _$LocationsStateCopyWithImpl<$Res>
    implements $LocationsStateCopyWith<$Res> {
  _$LocationsStateCopyWithImpl(this._self, this._then);

  final LocationsState _self;
  final $Res Function(LocationsState) _then;

/// Create a copy of LocationsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? showGeoModal = null,Object? error = freezed,Object? locations = null,Object? selectedLocationId = freezed,Object? selectedLocation = freezed,Object? markers = null,Object? center = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,showGeoModal: null == showGeoModal ? _self.showGeoModal : showGeoModal // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,locations: null == locations ? _self.locations : locations // ignore: cast_nullable_to_non_nullable
as List<LocationEntity>,selectedLocationId: freezed == selectedLocationId ? _self.selectedLocationId : selectedLocationId // ignore: cast_nullable_to_non_nullable
as String?,selectedLocation: freezed == selectedLocation ? _self.selectedLocation : selectedLocation // ignore: cast_nullable_to_non_nullable
as LocationEntity?,markers: null == markers ? _self.markers : markers // ignore: cast_nullable_to_non_nullable
as List<Marker>,center: null == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as LatLng,
  ));
}
/// Create a copy of LocationsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationEntityCopyWith<$Res>? get selectedLocation {
    if (_self.selectedLocation == null) {
    return null;
  }

  return $LocationEntityCopyWith<$Res>(_self.selectedLocation!, (value) {
    return _then(_self.copyWith(selectedLocation: value));
  });
}
}


/// Adds pattern-matching-related methods to [LocationsState].
extension LocationsStatePatterns on LocationsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationsState value)  $default,){
final _that = this;
switch (_that) {
case _LocationsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationsState value)?  $default,){
final _that = this;
switch (_that) {
case _LocationsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool showGeoModal,  String? error,  List<LocationEntity> locations,  String? selectedLocationId,  LocationEntity? selectedLocation,  List<Marker> markers,  LatLng center)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationsState() when $default != null:
return $default(_that.isLoading,_that.showGeoModal,_that.error,_that.locations,_that.selectedLocationId,_that.selectedLocation,_that.markers,_that.center);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool showGeoModal,  String? error,  List<LocationEntity> locations,  String? selectedLocationId,  LocationEntity? selectedLocation,  List<Marker> markers,  LatLng center)  $default,) {final _that = this;
switch (_that) {
case _LocationsState():
return $default(_that.isLoading,_that.showGeoModal,_that.error,_that.locations,_that.selectedLocationId,_that.selectedLocation,_that.markers,_that.center);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool showGeoModal,  String? error,  List<LocationEntity> locations,  String? selectedLocationId,  LocationEntity? selectedLocation,  List<Marker> markers,  LatLng center)?  $default,) {final _that = this;
switch (_that) {
case _LocationsState() when $default != null:
return $default(_that.isLoading,_that.showGeoModal,_that.error,_that.locations,_that.selectedLocationId,_that.selectedLocation,_that.markers,_that.center);case _:
  return null;

}
}

}

/// @nodoc


class _LocationsState implements LocationsState {
  const _LocationsState({this.isLoading = false, this.showGeoModal = false, this.error, final  List<LocationEntity> locations = const [], this.selectedLocationId, this.selectedLocation, final  List<Marker> markers = const [], this.center = const LatLng(50.4501, 30.5234)}): _locations = locations,_markers = markers;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool showGeoModal;
@override final  String? error;
 final  List<LocationEntity> _locations;
@override@JsonKey() List<LocationEntity> get locations {
  if (_locations is EqualUnmodifiableListView) return _locations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_locations);
}

@override final  String? selectedLocationId;
@override final  LocationEntity? selectedLocation;
 final  List<Marker> _markers;
@override@JsonKey() List<Marker> get markers {
  if (_markers is EqualUnmodifiableListView) return _markers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_markers);
}

@override@JsonKey() final  LatLng center;

/// Create a copy of LocationsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationsStateCopyWith<_LocationsState> get copyWith => __$LocationsStateCopyWithImpl<_LocationsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.showGeoModal, showGeoModal) || other.showGeoModal == showGeoModal)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other._locations, _locations)&&(identical(other.selectedLocationId, selectedLocationId) || other.selectedLocationId == selectedLocationId)&&(identical(other.selectedLocation, selectedLocation) || other.selectedLocation == selectedLocation)&&const DeepCollectionEquality().equals(other._markers, _markers)&&(identical(other.center, center) || other.center == center));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,showGeoModal,error,const DeepCollectionEquality().hash(_locations),selectedLocationId,selectedLocation,const DeepCollectionEquality().hash(_markers),center);

@override
String toString() {
  return 'LocationsState(isLoading: $isLoading, showGeoModal: $showGeoModal, error: $error, locations: $locations, selectedLocationId: $selectedLocationId, selectedLocation: $selectedLocation, markers: $markers, center: $center)';
}


}

/// @nodoc
abstract mixin class _$LocationsStateCopyWith<$Res> implements $LocationsStateCopyWith<$Res> {
  factory _$LocationsStateCopyWith(_LocationsState value, $Res Function(_LocationsState) _then) = __$LocationsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool showGeoModal, String? error, List<LocationEntity> locations, String? selectedLocationId, LocationEntity? selectedLocation, List<Marker> markers, LatLng center
});


@override $LocationEntityCopyWith<$Res>? get selectedLocation;

}
/// @nodoc
class __$LocationsStateCopyWithImpl<$Res>
    implements _$LocationsStateCopyWith<$Res> {
  __$LocationsStateCopyWithImpl(this._self, this._then);

  final _LocationsState _self;
  final $Res Function(_LocationsState) _then;

/// Create a copy of LocationsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? showGeoModal = null,Object? error = freezed,Object? locations = null,Object? selectedLocationId = freezed,Object? selectedLocation = freezed,Object? markers = null,Object? center = null,}) {
  return _then(_LocationsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,showGeoModal: null == showGeoModal ? _self.showGeoModal : showGeoModal // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,locations: null == locations ? _self._locations : locations // ignore: cast_nullable_to_non_nullable
as List<LocationEntity>,selectedLocationId: freezed == selectedLocationId ? _self.selectedLocationId : selectedLocationId // ignore: cast_nullable_to_non_nullable
as String?,selectedLocation: freezed == selectedLocation ? _self.selectedLocation : selectedLocation // ignore: cast_nullable_to_non_nullable
as LocationEntity?,markers: null == markers ? _self._markers : markers // ignore: cast_nullable_to_non_nullable
as List<Marker>,center: null == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as LatLng,
  ));
}

/// Create a copy of LocationsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationEntityCopyWith<$Res>? get selectedLocation {
    if (_self.selectedLocation == null) {
    return null;
  }

  return $LocationEntityCopyWith<$Res>(_self.selectedLocation!, (value) {
    return _then(_self.copyWith(selectedLocation: value));
  });
}
}

// dart format on
