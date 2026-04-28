// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'users_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UsersEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsersEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UsersEvent()';
}


}

/// @nodoc
class $UsersEventCopyWith<$Res>  {
$UsersEventCopyWith(UsersEvent _, $Res Function(UsersEvent) __);
}


/// Adds pattern-matching-related methods to [UsersEvent].
extension UsersEventPatterns on UsersEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UsersFetched value)?  usersFetched,TResult Function( MoreUsersLoaded value)?  moreUsersLoaded,TResult Function( UserFetched value)?  userFetched,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UsersFetched() when usersFetched != null:
return usersFetched(_that);case MoreUsersLoaded() when moreUsersLoaded != null:
return moreUsersLoaded(_that);case UserFetched() when userFetched != null:
return userFetched(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UsersFetched value)  usersFetched,required TResult Function( MoreUsersLoaded value)  moreUsersLoaded,required TResult Function( UserFetched value)  userFetched,}){
final _that = this;
switch (_that) {
case UsersFetched():
return usersFetched(_that);case MoreUsersLoaded():
return moreUsersLoaded(_that);case UserFetched():
return userFetched(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UsersFetched value)?  usersFetched,TResult? Function( MoreUsersLoaded value)?  moreUsersLoaded,TResult? Function( UserFetched value)?  userFetched,}){
final _that = this;
switch (_that) {
case UsersFetched() when usersFetched != null:
return usersFetched(_that);case MoreUsersLoaded() when moreUsersLoaded != null:
return moreUsersLoaded(_that);case UserFetched() when userFetched != null:
return userFetched(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  usersFetched,TResult Function()?  moreUsersLoaded,TResult Function( String id)?  userFetched,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UsersFetched() when usersFetched != null:
return usersFetched();case MoreUsersLoaded() when moreUsersLoaded != null:
return moreUsersLoaded();case UserFetched() when userFetched != null:
return userFetched(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  usersFetched,required TResult Function()  moreUsersLoaded,required TResult Function( String id)  userFetched,}) {final _that = this;
switch (_that) {
case UsersFetched():
return usersFetched();case MoreUsersLoaded():
return moreUsersLoaded();case UserFetched():
return userFetched(_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  usersFetched,TResult? Function()?  moreUsersLoaded,TResult? Function( String id)?  userFetched,}) {final _that = this;
switch (_that) {
case UsersFetched() when usersFetched != null:
return usersFetched();case MoreUsersLoaded() when moreUsersLoaded != null:
return moreUsersLoaded();case UserFetched() when userFetched != null:
return userFetched(_that.id);case _:
  return null;

}
}

}

/// @nodoc


class UsersFetched implements UsersEvent {
  const UsersFetched();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsersFetched);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UsersEvent.usersFetched()';
}


}

/// @nodoc
class $UsersFetchedCopyWith<$Res> implements $UsersEventCopyWith<$Res> {
$UsersFetchedCopyWith(UsersFetched _, $Res Function(UsersFetched) __);
}
/// @nodoc
class _$UsersFetchedCopyWithImpl<$Res>
    implements $UsersFetchedCopyWith<$Res> {
  _$UsersFetchedCopyWithImpl(this._self, this._then);

  final UsersFetched _self;
  final $Res Function(UsersFetched) _then;




}

/// @nodoc


class MoreUsersLoaded implements UsersEvent {
  const MoreUsersLoaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MoreUsersLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UsersEvent.moreUsersLoaded()';
}


}

/// @nodoc
class $MoreUsersLoadedCopyWith<$Res> implements $UsersEventCopyWith<$Res> {
$MoreUsersLoadedCopyWith(MoreUsersLoaded _, $Res Function(MoreUsersLoaded) __);
}
/// @nodoc
class _$MoreUsersLoadedCopyWithImpl<$Res>
    implements $MoreUsersLoadedCopyWith<$Res> {
  _$MoreUsersLoadedCopyWithImpl(this._self, this._then);

  final MoreUsersLoaded _self;
  final $Res Function(MoreUsersLoaded) _then;




}

/// @nodoc


class UserFetched implements UsersEvent {
  const UserFetched(this.id);
  

 final  String id;

/// Create a copy of UsersEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserFetchedCopyWith<UserFetched> get copyWith => _$UserFetchedCopyWithImpl<UserFetched>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserFetched&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'UsersEvent.userFetched(id: $id)';
}


}

/// @nodoc
abstract mixin class $UserFetchedCopyWith<$Res> implements $UsersEventCopyWith<$Res> {
  factory $UserFetchedCopyWith(UserFetched value, $Res Function(UserFetched) _then) = _$UserFetchedCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$UserFetchedCopyWithImpl<$Res>
    implements $UserFetchedCopyWith<$Res> {
  _$UserFetchedCopyWithImpl(this._self, this._then);

  final UserFetched _self;
  final $Res Function(UserFetched) _then;

/// Create a copy of UsersEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(UserFetched(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
