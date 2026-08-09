// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'server_health.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ServerHealth {

 bool get healthy; String get version;
/// Create a copy of ServerHealth
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerHealthCopyWith<ServerHealth> get copyWith => _$ServerHealthCopyWithImpl<ServerHealth>(this as ServerHealth, _$identity);

  /// Serializes this ServerHealth to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerHealth&&(identical(other.healthy, healthy) || other.healthy == healthy)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,healthy,version);

@override
String toString() {
  return 'ServerHealth(healthy: $healthy, version: $version)';
}


}

/// @nodoc
abstract mixin class $ServerHealthCopyWith<$Res>  {
  factory $ServerHealthCopyWith(ServerHealth value, $Res Function(ServerHealth) _then) = _$ServerHealthCopyWithImpl;
@useResult
$Res call({
 bool healthy, String version
});




}
/// @nodoc
class _$ServerHealthCopyWithImpl<$Res>
    implements $ServerHealthCopyWith<$Res> {
  _$ServerHealthCopyWithImpl(this._self, this._then);

  final ServerHealth _self;
  final $Res Function(ServerHealth) _then;

/// Create a copy of ServerHealth
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? healthy = null,Object? version = null,}) {
  return _then(_self.copyWith(
healthy: null == healthy ? _self.healthy : healthy // ignore: cast_nullable_to_non_nullable
as bool,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ServerHealth].
extension ServerHealthPatterns on ServerHealth {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServerHealth value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServerHealth() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServerHealth value)  $default,){
final _that = this;
switch (_that) {
case _ServerHealth():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServerHealth value)?  $default,){
final _that = this;
switch (_that) {
case _ServerHealth() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool healthy,  String version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServerHealth() when $default != null:
return $default(_that.healthy,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool healthy,  String version)  $default,) {final _that = this;
switch (_that) {
case _ServerHealth():
return $default(_that.healthy,_that.version);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool healthy,  String version)?  $default,) {final _that = this;
switch (_that) {
case _ServerHealth() when $default != null:
return $default(_that.healthy,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServerHealth implements ServerHealth {
  const _ServerHealth({required this.healthy, required this.version});
  factory _ServerHealth.fromJson(Map<String, dynamic> json) => _$ServerHealthFromJson(json);

@override final  bool healthy;
@override final  String version;

/// Create a copy of ServerHealth
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServerHealthCopyWith<_ServerHealth> get copyWith => __$ServerHealthCopyWithImpl<_ServerHealth>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServerHealthToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServerHealth&&(identical(other.healthy, healthy) || other.healthy == healthy)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,healthy,version);

@override
String toString() {
  return 'ServerHealth(healthy: $healthy, version: $version)';
}


}

/// @nodoc
abstract mixin class _$ServerHealthCopyWith<$Res> implements $ServerHealthCopyWith<$Res> {
  factory _$ServerHealthCopyWith(_ServerHealth value, $Res Function(_ServerHealth) _then) = __$ServerHealthCopyWithImpl;
@override @useResult
$Res call({
 bool healthy, String version
});




}
/// @nodoc
class __$ServerHealthCopyWithImpl<$Res>
    implements _$ServerHealthCopyWith<$Res> {
  __$ServerHealthCopyWithImpl(this._self, this._then);

  final _ServerHealth _self;
  final $Res Function(_ServerHealth) _then;

/// Create a copy of ServerHealth
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? healthy = null,Object? version = null,}) {
  return _then(_ServerHealth(
healthy: null == healthy ? _self.healthy : healthy // ignore: cast_nullable_to_non_nullable
as bool,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
