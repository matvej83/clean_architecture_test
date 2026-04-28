// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'users_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UsersState {

 bool get isLoading; bool get isUserLoading;/// pagination
 bool get isShowUsersLoader; bool get hasReachedMaxUsers; String? get error; List<UserEntity> get users; UserEntity? get user;
/// Create a copy of UsersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UsersStateCopyWith<UsersState> get copyWith => _$UsersStateCopyWithImpl<UsersState>(this as UsersState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsersState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isUserLoading, isUserLoading) || other.isUserLoading == isUserLoading)&&(identical(other.isShowUsersLoader, isShowUsersLoader) || other.isShowUsersLoader == isShowUsersLoader)&&(identical(other.hasReachedMaxUsers, hasReachedMaxUsers) || other.hasReachedMaxUsers == hasReachedMaxUsers)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.users, users)&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isUserLoading,isShowUsersLoader,hasReachedMaxUsers,error,const DeepCollectionEquality().hash(users),user);

@override
String toString() {
  return 'UsersState(isLoading: $isLoading, isUserLoading: $isUserLoading, isShowUsersLoader: $isShowUsersLoader, hasReachedMaxUsers: $hasReachedMaxUsers, error: $error, users: $users, user: $user)';
}


}

/// @nodoc
abstract mixin class $UsersStateCopyWith<$Res>  {
  factory $UsersStateCopyWith(UsersState value, $Res Function(UsersState) _then) = _$UsersStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isUserLoading, bool isShowUsersLoader, bool hasReachedMaxUsers, String? error, List<UserEntity> users, UserEntity? user
});




}
/// @nodoc
class _$UsersStateCopyWithImpl<$Res>
    implements $UsersStateCopyWith<$Res> {
  _$UsersStateCopyWithImpl(this._self, this._then);

  final UsersState _self;
  final $Res Function(UsersState) _then;

/// Create a copy of UsersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isUserLoading = null,Object? isShowUsersLoader = null,Object? hasReachedMaxUsers = null,Object? error = freezed,Object? users = null,Object? user = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isUserLoading: null == isUserLoading ? _self.isUserLoading : isUserLoading // ignore: cast_nullable_to_non_nullable
as bool,isShowUsersLoader: null == isShowUsersLoader ? _self.isShowUsersLoader : isShowUsersLoader // ignore: cast_nullable_to_non_nullable
as bool,hasReachedMaxUsers: null == hasReachedMaxUsers ? _self.hasReachedMaxUsers : hasReachedMaxUsers // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,users: null == users ? _self.users : users // ignore: cast_nullable_to_non_nullable
as List<UserEntity>,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserEntity?,
  ));
}

}


/// Adds pattern-matching-related methods to [UsersState].
extension UsersStatePatterns on UsersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UsersState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UsersState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UsersState value)  $default,){
final _that = this;
switch (_that) {
case _UsersState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UsersState value)?  $default,){
final _that = this;
switch (_that) {
case _UsersState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isUserLoading,  bool isShowUsersLoader,  bool hasReachedMaxUsers,  String? error,  List<UserEntity> users,  UserEntity? user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UsersState() when $default != null:
return $default(_that.isLoading,_that.isUserLoading,_that.isShowUsersLoader,_that.hasReachedMaxUsers,_that.error,_that.users,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isUserLoading,  bool isShowUsersLoader,  bool hasReachedMaxUsers,  String? error,  List<UserEntity> users,  UserEntity? user)  $default,) {final _that = this;
switch (_that) {
case _UsersState():
return $default(_that.isLoading,_that.isUserLoading,_that.isShowUsersLoader,_that.hasReachedMaxUsers,_that.error,_that.users,_that.user);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isUserLoading,  bool isShowUsersLoader,  bool hasReachedMaxUsers,  String? error,  List<UserEntity> users,  UserEntity? user)?  $default,) {final _that = this;
switch (_that) {
case _UsersState() when $default != null:
return $default(_that.isLoading,_that.isUserLoading,_that.isShowUsersLoader,_that.hasReachedMaxUsers,_that.error,_that.users,_that.user);case _:
  return null;

}
}

}

/// @nodoc


class _UsersState implements UsersState {
  const _UsersState({this.isLoading = false, this.isUserLoading = false, this.isShowUsersLoader = false, this.hasReachedMaxUsers = false, this.error, final  List<UserEntity> users = const [], this.user}): _users = users;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isUserLoading;
/// pagination
@override@JsonKey() final  bool isShowUsersLoader;
@override@JsonKey() final  bool hasReachedMaxUsers;
@override final  String? error;
 final  List<UserEntity> _users;
@override@JsonKey() List<UserEntity> get users {
  if (_users is EqualUnmodifiableListView) return _users;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_users);
}

@override final  UserEntity? user;

/// Create a copy of UsersState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UsersStateCopyWith<_UsersState> get copyWith => __$UsersStateCopyWithImpl<_UsersState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UsersState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isUserLoading, isUserLoading) || other.isUserLoading == isUserLoading)&&(identical(other.isShowUsersLoader, isShowUsersLoader) || other.isShowUsersLoader == isShowUsersLoader)&&(identical(other.hasReachedMaxUsers, hasReachedMaxUsers) || other.hasReachedMaxUsers == hasReachedMaxUsers)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other._users, _users)&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isUserLoading,isShowUsersLoader,hasReachedMaxUsers,error,const DeepCollectionEquality().hash(_users),user);

@override
String toString() {
  return 'UsersState(isLoading: $isLoading, isUserLoading: $isUserLoading, isShowUsersLoader: $isShowUsersLoader, hasReachedMaxUsers: $hasReachedMaxUsers, error: $error, users: $users, user: $user)';
}


}

/// @nodoc
abstract mixin class _$UsersStateCopyWith<$Res> implements $UsersStateCopyWith<$Res> {
  factory _$UsersStateCopyWith(_UsersState value, $Res Function(_UsersState) _then) = __$UsersStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isUserLoading, bool isShowUsersLoader, bool hasReachedMaxUsers, String? error, List<UserEntity> users, UserEntity? user
});




}
/// @nodoc
class __$UsersStateCopyWithImpl<$Res>
    implements _$UsersStateCopyWith<$Res> {
  __$UsersStateCopyWithImpl(this._self, this._then);

  final _UsersState _self;
  final $Res Function(_UsersState) _then;

/// Create a copy of UsersState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isUserLoading = null,Object? isShowUsersLoader = null,Object? hasReachedMaxUsers = null,Object? error = freezed,Object? users = null,Object? user = freezed,}) {
  return _then(_UsersState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isUserLoading: null == isUserLoading ? _self.isUserLoading : isUserLoading // ignore: cast_nullable_to_non_nullable
as bool,isShowUsersLoader: null == isShowUsersLoader ? _self.isShowUsersLoader : isShowUsersLoader // ignore: cast_nullable_to_non_nullable
as bool,hasReachedMaxUsers: null == hasReachedMaxUsers ? _self.hasReachedMaxUsers : hasReachedMaxUsers // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,users: null == users ? _self._users : users // ignore: cast_nullable_to_non_nullable
as List<UserEntity>,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserEntity?,
  ));
}


}

// dart format on
