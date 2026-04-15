// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'locations_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocationsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LocationsEvent()';
}


}

/// @nodoc
class $LocationsEventCopyWith<$Res>  {
$LocationsEventCopyWith(LocationsEvent _, $Res Function(LocationsEvent) __);
}


/// Adds pattern-matching-related methods to [LocationsEvent].
extension LocationsEventPatterns on LocationsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LocationsFetched value)?  locationsFetched,TResult Function( LocationSelected value)?  locationSelected,TResult Function( LocationUpdated value)?  locationUpdated,TResult Function( GeoStatusChecked value)?  geoStatusChecked,TResult Function( GeoStatusModalDisabled value)?  geoStatusModalDisabled,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LocationsFetched() when locationsFetched != null:
return locationsFetched(_that);case LocationSelected() when locationSelected != null:
return locationSelected(_that);case LocationUpdated() when locationUpdated != null:
return locationUpdated(_that);case GeoStatusChecked() when geoStatusChecked != null:
return geoStatusChecked(_that);case GeoStatusModalDisabled() when geoStatusModalDisabled != null:
return geoStatusModalDisabled(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LocationsFetched value)  locationsFetched,required TResult Function( LocationSelected value)  locationSelected,required TResult Function( LocationUpdated value)  locationUpdated,required TResult Function( GeoStatusChecked value)  geoStatusChecked,required TResult Function( GeoStatusModalDisabled value)  geoStatusModalDisabled,}){
final _that = this;
switch (_that) {
case LocationsFetched():
return locationsFetched(_that);case LocationSelected():
return locationSelected(_that);case LocationUpdated():
return locationUpdated(_that);case GeoStatusChecked():
return geoStatusChecked(_that);case GeoStatusModalDisabled():
return geoStatusModalDisabled(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LocationsFetched value)?  locationsFetched,TResult? Function( LocationSelected value)?  locationSelected,TResult? Function( LocationUpdated value)?  locationUpdated,TResult? Function( GeoStatusChecked value)?  geoStatusChecked,TResult? Function( GeoStatusModalDisabled value)?  geoStatusModalDisabled,}){
final _that = this;
switch (_that) {
case LocationsFetched() when locationsFetched != null:
return locationsFetched(_that);case LocationSelected() when locationSelected != null:
return locationSelected(_that);case LocationUpdated() when locationUpdated != null:
return locationUpdated(_that);case GeoStatusChecked() when geoStatusChecked != null:
return geoStatusChecked(_that);case GeoStatusModalDisabled() when geoStatusModalDisabled != null:
return geoStatusModalDisabled(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<double>? origin,  int? radius,  bool loadSilent)?  locationsFetched,TResult Function( String? locationId,  LocationEntity? location)?  locationSelected,TResult Function( Position position)?  locationUpdated,TResult Function()?  geoStatusChecked,TResult Function()?  geoStatusModalDisabled,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LocationsFetched() when locationsFetched != null:
return locationsFetched(_that.origin,_that.radius,_that.loadSilent);case LocationSelected() when locationSelected != null:
return locationSelected(_that.locationId,_that.location);case LocationUpdated() when locationUpdated != null:
return locationUpdated(_that.position);case GeoStatusChecked() when geoStatusChecked != null:
return geoStatusChecked();case GeoStatusModalDisabled() when geoStatusModalDisabled != null:
return geoStatusModalDisabled();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<double>? origin,  int? radius,  bool loadSilent)  locationsFetched,required TResult Function( String? locationId,  LocationEntity? location)  locationSelected,required TResult Function( Position position)  locationUpdated,required TResult Function()  geoStatusChecked,required TResult Function()  geoStatusModalDisabled,}) {final _that = this;
switch (_that) {
case LocationsFetched():
return locationsFetched(_that.origin,_that.radius,_that.loadSilent);case LocationSelected():
return locationSelected(_that.locationId,_that.location);case LocationUpdated():
return locationUpdated(_that.position);case GeoStatusChecked():
return geoStatusChecked();case GeoStatusModalDisabled():
return geoStatusModalDisabled();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<double>? origin,  int? radius,  bool loadSilent)?  locationsFetched,TResult? Function( String? locationId,  LocationEntity? location)?  locationSelected,TResult? Function( Position position)?  locationUpdated,TResult? Function()?  geoStatusChecked,TResult? Function()?  geoStatusModalDisabled,}) {final _that = this;
switch (_that) {
case LocationsFetched() when locationsFetched != null:
return locationsFetched(_that.origin,_that.radius,_that.loadSilent);case LocationSelected() when locationSelected != null:
return locationSelected(_that.locationId,_that.location);case LocationUpdated() when locationUpdated != null:
return locationUpdated(_that.position);case GeoStatusChecked() when geoStatusChecked != null:
return geoStatusChecked();case GeoStatusModalDisabled() when geoStatusModalDisabled != null:
return geoStatusModalDisabled();case _:
  return null;

}
}

}

/// @nodoc


class LocationsFetched implements LocationsEvent {
  const LocationsFetched({final  List<double>? origin, this.radius, this.loadSilent = false}): _origin = origin;
  

 final  List<double>? _origin;
 List<double>? get origin {
  final value = _origin;
  if (value == null) return null;
  if (_origin is EqualUnmodifiableListView) return _origin;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  int? radius;
@JsonKey() final  bool loadSilent;

/// Create a copy of LocationsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationsFetchedCopyWith<LocationsFetched> get copyWith => _$LocationsFetchedCopyWithImpl<LocationsFetched>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationsFetched&&const DeepCollectionEquality().equals(other._origin, _origin)&&(identical(other.radius, radius) || other.radius == radius)&&(identical(other.loadSilent, loadSilent) || other.loadSilent == loadSilent));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_origin),radius,loadSilent);

@override
String toString() {
  return 'LocationsEvent.locationsFetched(origin: $origin, radius: $radius, loadSilent: $loadSilent)';
}


}

/// @nodoc
abstract mixin class $LocationsFetchedCopyWith<$Res> implements $LocationsEventCopyWith<$Res> {
  factory $LocationsFetchedCopyWith(LocationsFetched value, $Res Function(LocationsFetched) _then) = _$LocationsFetchedCopyWithImpl;
@useResult
$Res call({
 List<double>? origin, int? radius, bool loadSilent
});




}
/// @nodoc
class _$LocationsFetchedCopyWithImpl<$Res>
    implements $LocationsFetchedCopyWith<$Res> {
  _$LocationsFetchedCopyWithImpl(this._self, this._then);

  final LocationsFetched _self;
  final $Res Function(LocationsFetched) _then;

/// Create a copy of LocationsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? origin = freezed,Object? radius = freezed,Object? loadSilent = null,}) {
  return _then(LocationsFetched(
origin: freezed == origin ? _self._origin : origin // ignore: cast_nullable_to_non_nullable
as List<double>?,radius: freezed == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as int?,loadSilent: null == loadSilent ? _self.loadSilent : loadSilent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class LocationSelected implements LocationsEvent {
  const LocationSelected({this.locationId, this.location});
  

 final  String? locationId;
 final  LocationEntity? location;

/// Create a copy of LocationsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationSelectedCopyWith<LocationSelected> get copyWith => _$LocationSelectedCopyWithImpl<LocationSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationSelected&&(identical(other.locationId, locationId) || other.locationId == locationId)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,locationId,location);

@override
String toString() {
  return 'LocationsEvent.locationSelected(locationId: $locationId, location: $location)';
}


}

/// @nodoc
abstract mixin class $LocationSelectedCopyWith<$Res> implements $LocationsEventCopyWith<$Res> {
  factory $LocationSelectedCopyWith(LocationSelected value, $Res Function(LocationSelected) _then) = _$LocationSelectedCopyWithImpl;
@useResult
$Res call({
 String? locationId, LocationEntity? location
});


$LocationEntityCopyWith<$Res>? get location;

}
/// @nodoc
class _$LocationSelectedCopyWithImpl<$Res>
    implements $LocationSelectedCopyWith<$Res> {
  _$LocationSelectedCopyWithImpl(this._self, this._then);

  final LocationSelected _self;
  final $Res Function(LocationSelected) _then;

/// Create a copy of LocationsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? locationId = freezed,Object? location = freezed,}) {
  return _then(LocationSelected(
locationId: freezed == locationId ? _self.locationId : locationId // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocationEntity?,
  ));
}

/// Create a copy of LocationsEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationEntityCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $LocationEntityCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}

/// @nodoc


class LocationUpdated implements LocationsEvent {
  const LocationUpdated({required this.position});
  

 final  Position position;

/// Create a copy of LocationsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationUpdatedCopyWith<LocationUpdated> get copyWith => _$LocationUpdatedCopyWithImpl<LocationUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationUpdated&&(identical(other.position, position) || other.position == position));
}


@override
int get hashCode => Object.hash(runtimeType,position);

@override
String toString() {
  return 'LocationsEvent.locationUpdated(position: $position)';
}


}

/// @nodoc
abstract mixin class $LocationUpdatedCopyWith<$Res> implements $LocationsEventCopyWith<$Res> {
  factory $LocationUpdatedCopyWith(LocationUpdated value, $Res Function(LocationUpdated) _then) = _$LocationUpdatedCopyWithImpl;
@useResult
$Res call({
 Position position
});




}
/// @nodoc
class _$LocationUpdatedCopyWithImpl<$Res>
    implements $LocationUpdatedCopyWith<$Res> {
  _$LocationUpdatedCopyWithImpl(this._self, this._then);

  final LocationUpdated _self;
  final $Res Function(LocationUpdated) _then;

/// Create a copy of LocationsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? position = null,}) {
  return _then(LocationUpdated(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Position,
  ));
}


}

/// @nodoc


class GeoStatusChecked implements LocationsEvent {
  const GeoStatusChecked();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeoStatusChecked);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LocationsEvent.geoStatusChecked()';
}


}

/// @nodoc
class $GeoStatusCheckedCopyWith<$Res> implements $LocationsEventCopyWith<$Res> {
$GeoStatusCheckedCopyWith(GeoStatusChecked _, $Res Function(GeoStatusChecked) __);
}
/// @nodoc
class _$GeoStatusCheckedCopyWithImpl<$Res>
    implements $GeoStatusCheckedCopyWith<$Res> {
  _$GeoStatusCheckedCopyWithImpl(this._self, this._then);

  final GeoStatusChecked _self;
  final $Res Function(GeoStatusChecked) _then;




}

/// @nodoc


class GeoStatusModalDisabled implements LocationsEvent {
  const GeoStatusModalDisabled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeoStatusModalDisabled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LocationsEvent.geoStatusModalDisabled()';
}


}

/// @nodoc
class $GeoStatusModalDisabledCopyWith<$Res> implements $LocationsEventCopyWith<$Res> {
$GeoStatusModalDisabledCopyWith(GeoStatusModalDisabled _, $Res Function(GeoStatusModalDisabled) __);
}
/// @nodoc
class _$GeoStatusModalDisabledCopyWithImpl<$Res>
    implements $GeoStatusModalDisabledCopyWith<$Res> {
  _$GeoStatusModalDisabledCopyWithImpl(this._self, this._then);

  final GeoStatusModalDisabled _self;
  final $Res Function(GeoStatusModalDisabled) _then;




}

// dart format on
