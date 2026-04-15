// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AuthCheckRequested value)?  checkRequested,TResult Function( AuthUserProfileRequested value)?  userProfileRequested,TResult Function( AuthLoginRequested value)?  loginRequested,TResult Function( AuthLogoutRequested value)?  logoutRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AuthCheckRequested() when checkRequested != null:
return checkRequested(_that);case AuthUserProfileRequested() when userProfileRequested != null:
return userProfileRequested(_that);case AuthLoginRequested() when loginRequested != null:
return loginRequested(_that);case AuthLogoutRequested() when logoutRequested != null:
return logoutRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AuthCheckRequested value)  checkRequested,required TResult Function( AuthUserProfileRequested value)  userProfileRequested,required TResult Function( AuthLoginRequested value)  loginRequested,required TResult Function( AuthLogoutRequested value)  logoutRequested,}){
final _that = this;
switch (_that) {
case AuthCheckRequested():
return checkRequested(_that);case AuthUserProfileRequested():
return userProfileRequested(_that);case AuthLoginRequested():
return loginRequested(_that);case AuthLogoutRequested():
return logoutRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AuthCheckRequested value)?  checkRequested,TResult? Function( AuthUserProfileRequested value)?  userProfileRequested,TResult? Function( AuthLoginRequested value)?  loginRequested,TResult? Function( AuthLogoutRequested value)?  logoutRequested,}){
final _that = this;
switch (_that) {
case AuthCheckRequested() when checkRequested != null:
return checkRequested(_that);case AuthUserProfileRequested() when userProfileRequested != null:
return userProfileRequested(_that);case AuthLoginRequested() when loginRequested != null:
return loginRequested(_that);case AuthLogoutRequested() when logoutRequested != null:
return logoutRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  checkRequested,TResult Function()?  userProfileRequested,TResult Function( String email,  String password)?  loginRequested,TResult Function()?  logoutRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AuthCheckRequested() when checkRequested != null:
return checkRequested();case AuthUserProfileRequested() when userProfileRequested != null:
return userProfileRequested();case AuthLoginRequested() when loginRequested != null:
return loginRequested(_that.email,_that.password);case AuthLogoutRequested() when logoutRequested != null:
return logoutRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  checkRequested,required TResult Function()  userProfileRequested,required TResult Function( String email,  String password)  loginRequested,required TResult Function()  logoutRequested,}) {final _that = this;
switch (_that) {
case AuthCheckRequested():
return checkRequested();case AuthUserProfileRequested():
return userProfileRequested();case AuthLoginRequested():
return loginRequested(_that.email,_that.password);case AuthLogoutRequested():
return logoutRequested();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  checkRequested,TResult? Function()?  userProfileRequested,TResult? Function( String email,  String password)?  loginRequested,TResult? Function()?  logoutRequested,}) {final _that = this;
switch (_that) {
case AuthCheckRequested() when checkRequested != null:
return checkRequested();case AuthUserProfileRequested() when userProfileRequested != null:
return userProfileRequested();case AuthLoginRequested() when loginRequested != null:
return loginRequested(_that.email,_that.password);case AuthLogoutRequested() when logoutRequested != null:
return logoutRequested();case _:
  return null;

}
}

}

/// @nodoc


class AuthCheckRequested implements AuthEvent {
  const AuthCheckRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthCheckRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.checkRequested()';
}


}

/// @nodoc
class $AuthCheckRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
$AuthCheckRequestedCopyWith(AuthCheckRequested _, $Res Function(AuthCheckRequested) __);
}
/// @nodoc
class _$AuthCheckRequestedCopyWithImpl<$Res>
    implements $AuthCheckRequestedCopyWith<$Res> {
  _$AuthCheckRequestedCopyWithImpl(this._self, this._then);

  final AuthCheckRequested _self;
  final $Res Function(AuthCheckRequested) _then;




}

/// @nodoc


class AuthUserProfileRequested implements AuthEvent {
  const AuthUserProfileRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthUserProfileRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.userProfileRequested()';
}


}

/// @nodoc
class $AuthUserProfileRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
$AuthUserProfileRequestedCopyWith(AuthUserProfileRequested _, $Res Function(AuthUserProfileRequested) __);
}
/// @nodoc
class _$AuthUserProfileRequestedCopyWithImpl<$Res>
    implements $AuthUserProfileRequestedCopyWith<$Res> {
  _$AuthUserProfileRequestedCopyWithImpl(this._self, this._then);

  final AuthUserProfileRequested _self;
  final $Res Function(AuthUserProfileRequested) _then;




}

/// @nodoc


class AuthLoginRequested implements AuthEvent {
  const AuthLoginRequested({required this.email, required this.password});
  

 final  String email;
 final  String password;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthLoginRequestedCopyWith<AuthLoginRequested> get copyWith => _$AuthLoginRequestedCopyWithImpl<AuthLoginRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthLoginRequested&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'AuthEvent.loginRequested(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $AuthLoginRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthLoginRequestedCopyWith(AuthLoginRequested value, $Res Function(AuthLoginRequested) _then) = _$AuthLoginRequestedCopyWithImpl;
@useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class _$AuthLoginRequestedCopyWithImpl<$Res>
    implements $AuthLoginRequestedCopyWith<$Res> {
  _$AuthLoginRequestedCopyWithImpl(this._self, this._then);

  final AuthLoginRequested _self;
  final $Res Function(AuthLoginRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(AuthLoginRequested(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthLogoutRequested implements AuthEvent {
  const AuthLogoutRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthLogoutRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.logoutRequested()';
}


}

/// @nodoc
class $AuthLogoutRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
$AuthLogoutRequestedCopyWith(AuthLogoutRequested _, $Res Function(AuthLogoutRequested) __);
}
/// @nodoc
class _$AuthLogoutRequestedCopyWithImpl<$Res>
    implements $AuthLogoutRequestedCopyWith<$Res> {
  _$AuthLogoutRequestedCopyWithImpl(this._self, this._then);

  final AuthLogoutRequested _self;
  final $Res Function(AuthLogoutRequested) _then;




}

// dart format on
