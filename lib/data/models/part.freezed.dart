// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'part.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PartTime {

 int get start; int? get end;
/// Create a copy of PartTime
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartTimeCopyWith<PartTime> get copyWith => _$PartTimeCopyWithImpl<PartTime>(this as PartTime, _$identity);

  /// Serializes this PartTime to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartTime&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end);

@override
String toString() {
  return 'PartTime(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class $PartTimeCopyWith<$Res>  {
  factory $PartTimeCopyWith(PartTime value, $Res Function(PartTime) _then) = _$PartTimeCopyWithImpl;
@useResult
$Res call({
 int start, int? end
});




}
/// @nodoc
class _$PartTimeCopyWithImpl<$Res>
    implements $PartTimeCopyWith<$Res> {
  _$PartTimeCopyWithImpl(this._self, this._then);

  final PartTime _self;
  final $Res Function(PartTime) _then;

/// Create a copy of PartTime
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = null,Object? end = freezed,}) {
  return _then(_self.copyWith(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as int,end: freezed == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [PartTime].
extension PartTimePatterns on PartTime {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PartTime value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PartTime() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PartTime value)  $default,){
final _that = this;
switch (_that) {
case _PartTime():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PartTime value)?  $default,){
final _that = this;
switch (_that) {
case _PartTime() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int start,  int? end)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PartTime() when $default != null:
return $default(_that.start,_that.end);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int start,  int? end)  $default,) {final _that = this;
switch (_that) {
case _PartTime():
return $default(_that.start,_that.end);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int start,  int? end)?  $default,) {final _that = this;
switch (_that) {
case _PartTime() when $default != null:
return $default(_that.start,_that.end);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PartTime implements PartTime {
  const _PartTime({required this.start, this.end});
  factory _PartTime.fromJson(Map<String, dynamic> json) => _$PartTimeFromJson(json);

@override final  int start;
@override final  int? end;

/// Create a copy of PartTime
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartTimeCopyWith<_PartTime> get copyWith => __$PartTimeCopyWithImpl<_PartTime>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PartTimeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PartTime&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end);

@override
String toString() {
  return 'PartTime(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class _$PartTimeCopyWith<$Res> implements $PartTimeCopyWith<$Res> {
  factory _$PartTimeCopyWith(_PartTime value, $Res Function(_PartTime) _then) = __$PartTimeCopyWithImpl;
@override @useResult
$Res call({
 int start, int? end
});




}
/// @nodoc
class __$PartTimeCopyWithImpl<$Res>
    implements _$PartTimeCopyWith<$Res> {
  __$PartTimeCopyWithImpl(this._self, this._then);

  final _PartTime _self;
  final $Res Function(_PartTime) _then;

/// Create a copy of PartTime
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = freezed,}) {
  return _then(_PartTime(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as int,end: freezed == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$ToolTimeStart {

 int get start;
/// Create a copy of ToolTimeStart
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToolTimeStartCopyWith<ToolTimeStart> get copyWith => _$ToolTimeStartCopyWithImpl<ToolTimeStart>(this as ToolTimeStart, _$identity);

  /// Serializes this ToolTimeStart to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToolTimeStart&&(identical(other.start, start) || other.start == start));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start);

@override
String toString() {
  return 'ToolTimeStart(start: $start)';
}


}

/// @nodoc
abstract mixin class $ToolTimeStartCopyWith<$Res>  {
  factory $ToolTimeStartCopyWith(ToolTimeStart value, $Res Function(ToolTimeStart) _then) = _$ToolTimeStartCopyWithImpl;
@useResult
$Res call({
 int start
});




}
/// @nodoc
class _$ToolTimeStartCopyWithImpl<$Res>
    implements $ToolTimeStartCopyWith<$Res> {
  _$ToolTimeStartCopyWithImpl(this._self, this._then);

  final ToolTimeStart _self;
  final $Res Function(ToolTimeStart) _then;

/// Create a copy of ToolTimeStart
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = null,}) {
  return _then(_self.copyWith(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ToolTimeStart].
extension ToolTimeStartPatterns on ToolTimeStart {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ToolTimeStart value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ToolTimeStart() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ToolTimeStart value)  $default,){
final _that = this;
switch (_that) {
case _ToolTimeStart():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ToolTimeStart value)?  $default,){
final _that = this;
switch (_that) {
case _ToolTimeStart() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int start)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ToolTimeStart() when $default != null:
return $default(_that.start);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int start)  $default,) {final _that = this;
switch (_that) {
case _ToolTimeStart():
return $default(_that.start);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int start)?  $default,) {final _that = this;
switch (_that) {
case _ToolTimeStart() when $default != null:
return $default(_that.start);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ToolTimeStart implements ToolTimeStart {
  const _ToolTimeStart({required this.start});
  factory _ToolTimeStart.fromJson(Map<String, dynamic> json) => _$ToolTimeStartFromJson(json);

@override final  int start;

/// Create a copy of ToolTimeStart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToolTimeStartCopyWith<_ToolTimeStart> get copyWith => __$ToolTimeStartCopyWithImpl<_ToolTimeStart>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ToolTimeStartToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToolTimeStart&&(identical(other.start, start) || other.start == start));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start);

@override
String toString() {
  return 'ToolTimeStart(start: $start)';
}


}

/// @nodoc
abstract mixin class _$ToolTimeStartCopyWith<$Res> implements $ToolTimeStartCopyWith<$Res> {
  factory _$ToolTimeStartCopyWith(_ToolTimeStart value, $Res Function(_ToolTimeStart) _then) = __$ToolTimeStartCopyWithImpl;
@override @useResult
$Res call({
 int start
});




}
/// @nodoc
class __$ToolTimeStartCopyWithImpl<$Res>
    implements _$ToolTimeStartCopyWith<$Res> {
  __$ToolTimeStartCopyWithImpl(this._self, this._then);

  final _ToolTimeStart _self;
  final $Res Function(_ToolTimeStart) _then;

/// Create a copy of ToolTimeStart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,}) {
  return _then(_ToolTimeStart(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ToolTimeFull {

 int get start; int get end; int? get compacted;
/// Create a copy of ToolTimeFull
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToolTimeFullCopyWith<ToolTimeFull> get copyWith => _$ToolTimeFullCopyWithImpl<ToolTimeFull>(this as ToolTimeFull, _$identity);

  /// Serializes this ToolTimeFull to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToolTimeFull&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.compacted, compacted) || other.compacted == compacted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end,compacted);

@override
String toString() {
  return 'ToolTimeFull(start: $start, end: $end, compacted: $compacted)';
}


}

/// @nodoc
abstract mixin class $ToolTimeFullCopyWith<$Res>  {
  factory $ToolTimeFullCopyWith(ToolTimeFull value, $Res Function(ToolTimeFull) _then) = _$ToolTimeFullCopyWithImpl;
@useResult
$Res call({
 int start, int end, int? compacted
});




}
/// @nodoc
class _$ToolTimeFullCopyWithImpl<$Res>
    implements $ToolTimeFullCopyWith<$Res> {
  _$ToolTimeFullCopyWithImpl(this._self, this._then);

  final ToolTimeFull _self;
  final $Res Function(ToolTimeFull) _then;

/// Create a copy of ToolTimeFull
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = null,Object? end = null,Object? compacted = freezed,}) {
  return _then(_self.copyWith(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as int,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as int,compacted: freezed == compacted ? _self.compacted : compacted // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ToolTimeFull].
extension ToolTimeFullPatterns on ToolTimeFull {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ToolTimeFull value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ToolTimeFull() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ToolTimeFull value)  $default,){
final _that = this;
switch (_that) {
case _ToolTimeFull():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ToolTimeFull value)?  $default,){
final _that = this;
switch (_that) {
case _ToolTimeFull() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int start,  int end,  int? compacted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ToolTimeFull() when $default != null:
return $default(_that.start,_that.end,_that.compacted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int start,  int end,  int? compacted)  $default,) {final _that = this;
switch (_that) {
case _ToolTimeFull():
return $default(_that.start,_that.end,_that.compacted);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int start,  int end,  int? compacted)?  $default,) {final _that = this;
switch (_that) {
case _ToolTimeFull() when $default != null:
return $default(_that.start,_that.end,_that.compacted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ToolTimeFull implements ToolTimeFull {
  const _ToolTimeFull({required this.start, required this.end, this.compacted});
  factory _ToolTimeFull.fromJson(Map<String, dynamic> json) => _$ToolTimeFullFromJson(json);

@override final  int start;
@override final  int end;
@override final  int? compacted;

/// Create a copy of ToolTimeFull
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToolTimeFullCopyWith<_ToolTimeFull> get copyWith => __$ToolTimeFullCopyWithImpl<_ToolTimeFull>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ToolTimeFullToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToolTimeFull&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.compacted, compacted) || other.compacted == compacted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end,compacted);

@override
String toString() {
  return 'ToolTimeFull(start: $start, end: $end, compacted: $compacted)';
}


}

/// @nodoc
abstract mixin class _$ToolTimeFullCopyWith<$Res> implements $ToolTimeFullCopyWith<$Res> {
  factory _$ToolTimeFullCopyWith(_ToolTimeFull value, $Res Function(_ToolTimeFull) _then) = __$ToolTimeFullCopyWithImpl;
@override @useResult
$Res call({
 int start, int end, int? compacted
});




}
/// @nodoc
class __$ToolTimeFullCopyWithImpl<$Res>
    implements _$ToolTimeFullCopyWith<$Res> {
  __$ToolTimeFullCopyWithImpl(this._self, this._then);

  final _ToolTimeFull _self;
  final $Res Function(_ToolTimeFull) _then;

/// Create a copy of ToolTimeFull
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = null,Object? compacted = freezed,}) {
  return _then(_ToolTimeFull(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as int,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as int,compacted: freezed == compacted ? _self.compacted : compacted // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$RetryTime {

 int get created;
/// Create a copy of RetryTime
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RetryTimeCopyWith<RetryTime> get copyWith => _$RetryTimeCopyWithImpl<RetryTime>(this as RetryTime, _$identity);

  /// Serializes this RetryTime to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RetryTime&&(identical(other.created, created) || other.created == created));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,created);

@override
String toString() {
  return 'RetryTime(created: $created)';
}


}

/// @nodoc
abstract mixin class $RetryTimeCopyWith<$Res>  {
  factory $RetryTimeCopyWith(RetryTime value, $Res Function(RetryTime) _then) = _$RetryTimeCopyWithImpl;
@useResult
$Res call({
 int created
});




}
/// @nodoc
class _$RetryTimeCopyWithImpl<$Res>
    implements $RetryTimeCopyWith<$Res> {
  _$RetryTimeCopyWithImpl(this._self, this._then);

  final RetryTime _self;
  final $Res Function(RetryTime) _then;

/// Create a copy of RetryTime
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? created = null,}) {
  return _then(_self.copyWith(
created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RetryTime].
extension RetryTimePatterns on RetryTime {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RetryTime value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RetryTime() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RetryTime value)  $default,){
final _that = this;
switch (_that) {
case _RetryTime():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RetryTime value)?  $default,){
final _that = this;
switch (_that) {
case _RetryTime() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int created)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RetryTime() when $default != null:
return $default(_that.created);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int created)  $default,) {final _that = this;
switch (_that) {
case _RetryTime():
return $default(_that.created);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int created)?  $default,) {final _that = this;
switch (_that) {
case _RetryTime() when $default != null:
return $default(_that.created);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RetryTime implements RetryTime {
  const _RetryTime({required this.created});
  factory _RetryTime.fromJson(Map<String, dynamic> json) => _$RetryTimeFromJson(json);

@override final  int created;

/// Create a copy of RetryTime
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RetryTimeCopyWith<_RetryTime> get copyWith => __$RetryTimeCopyWithImpl<_RetryTime>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RetryTimeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RetryTime&&(identical(other.created, created) || other.created == created));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,created);

@override
String toString() {
  return 'RetryTime(created: $created)';
}


}

/// @nodoc
abstract mixin class _$RetryTimeCopyWith<$Res> implements $RetryTimeCopyWith<$Res> {
  factory _$RetryTimeCopyWith(_RetryTime value, $Res Function(_RetryTime) _then) = __$RetryTimeCopyWithImpl;
@override @useResult
$Res call({
 int created
});




}
/// @nodoc
class __$RetryTimeCopyWithImpl<$Res>
    implements _$RetryTimeCopyWith<$Res> {
  __$RetryTimeCopyWithImpl(this._self, this._then);

  final _RetryTime _self;
  final $Res Function(_RetryTime) _then;

/// Create a copy of RetryTime
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? created = null,}) {
  return _then(_RetryTime(
created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$AgentPartSource {

 String get value; int get start; int get end;
/// Create a copy of AgentPartSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgentPartSourceCopyWith<AgentPartSource> get copyWith => _$AgentPartSourceCopyWithImpl<AgentPartSource>(this as AgentPartSource, _$identity);

  /// Serializes this AgentPartSource to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgentPartSource&&(identical(other.value, value) || other.value == value)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,start,end);

@override
String toString() {
  return 'AgentPartSource(value: $value, start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class $AgentPartSourceCopyWith<$Res>  {
  factory $AgentPartSourceCopyWith(AgentPartSource value, $Res Function(AgentPartSource) _then) = _$AgentPartSourceCopyWithImpl;
@useResult
$Res call({
 String value, int start, int end
});




}
/// @nodoc
class _$AgentPartSourceCopyWithImpl<$Res>
    implements $AgentPartSourceCopyWith<$Res> {
  _$AgentPartSourceCopyWithImpl(this._self, this._then);

  final AgentPartSource _self;
  final $Res Function(AgentPartSource) _then;

/// Create a copy of AgentPartSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? start = null,Object? end = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as int,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AgentPartSource].
extension AgentPartSourcePatterns on AgentPartSource {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AgentPartSource value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AgentPartSource() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AgentPartSource value)  $default,){
final _that = this;
switch (_that) {
case _AgentPartSource():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AgentPartSource value)?  $default,){
final _that = this;
switch (_that) {
case _AgentPartSource() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String value,  int start,  int end)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AgentPartSource() when $default != null:
return $default(_that.value,_that.start,_that.end);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String value,  int start,  int end)  $default,) {final _that = this;
switch (_that) {
case _AgentPartSource():
return $default(_that.value,_that.start,_that.end);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String value,  int start,  int end)?  $default,) {final _that = this;
switch (_that) {
case _AgentPartSource() when $default != null:
return $default(_that.value,_that.start,_that.end);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AgentPartSource implements AgentPartSource {
  const _AgentPartSource({required this.value, required this.start, required this.end});
  factory _AgentPartSource.fromJson(Map<String, dynamic> json) => _$AgentPartSourceFromJson(json);

@override final  String value;
@override final  int start;
@override final  int end;

/// Create a copy of AgentPartSource
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AgentPartSourceCopyWith<_AgentPartSource> get copyWith => __$AgentPartSourceCopyWithImpl<_AgentPartSource>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AgentPartSourceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AgentPartSource&&(identical(other.value, value) || other.value == value)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,start,end);

@override
String toString() {
  return 'AgentPartSource(value: $value, start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class _$AgentPartSourceCopyWith<$Res> implements $AgentPartSourceCopyWith<$Res> {
  factory _$AgentPartSourceCopyWith(_AgentPartSource value, $Res Function(_AgentPartSource) _then) = __$AgentPartSourceCopyWithImpl;
@override @useResult
$Res call({
 String value, int start, int end
});




}
/// @nodoc
class __$AgentPartSourceCopyWithImpl<$Res>
    implements _$AgentPartSourceCopyWith<$Res> {
  __$AgentPartSourceCopyWithImpl(this._self, this._then);

  final _AgentPartSource _self;
  final $Res Function(_AgentPartSource) _then;

/// Create a copy of AgentPartSource
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? start = null,Object? end = null,}) {
  return _then(_AgentPartSource(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as int,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$FileSourceText {

 String get value; double get start; double get end;
/// Create a copy of FileSourceText
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FileSourceTextCopyWith<FileSourceText> get copyWith => _$FileSourceTextCopyWithImpl<FileSourceText>(this as FileSourceText, _$identity);

  /// Serializes this FileSourceText to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FileSourceText&&(identical(other.value, value) || other.value == value)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,start,end);

@override
String toString() {
  return 'FileSourceText(value: $value, start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class $FileSourceTextCopyWith<$Res>  {
  factory $FileSourceTextCopyWith(FileSourceText value, $Res Function(FileSourceText) _then) = _$FileSourceTextCopyWithImpl;
@useResult
$Res call({
 String value, double start, double end
});




}
/// @nodoc
class _$FileSourceTextCopyWithImpl<$Res>
    implements $FileSourceTextCopyWith<$Res> {
  _$FileSourceTextCopyWithImpl(this._self, this._then);

  final FileSourceText _self;
  final $Res Function(FileSourceText) _then;

/// Create a copy of FileSourceText
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? start = null,Object? end = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as double,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [FileSourceText].
extension FileSourceTextPatterns on FileSourceText {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FileSourceText value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FileSourceText() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FileSourceText value)  $default,){
final _that = this;
switch (_that) {
case _FileSourceText():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FileSourceText value)?  $default,){
final _that = this;
switch (_that) {
case _FileSourceText() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String value,  double start,  double end)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FileSourceText() when $default != null:
return $default(_that.value,_that.start,_that.end);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String value,  double start,  double end)  $default,) {final _that = this;
switch (_that) {
case _FileSourceText():
return $default(_that.value,_that.start,_that.end);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String value,  double start,  double end)?  $default,) {final _that = this;
switch (_that) {
case _FileSourceText() when $default != null:
return $default(_that.value,_that.start,_that.end);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FileSourceText implements FileSourceText {
  const _FileSourceText({required this.value, required this.start, required this.end});
  factory _FileSourceText.fromJson(Map<String, dynamic> json) => _$FileSourceTextFromJson(json);

@override final  String value;
@override final  double start;
@override final  double end;

/// Create a copy of FileSourceText
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FileSourceTextCopyWith<_FileSourceText> get copyWith => __$FileSourceTextCopyWithImpl<_FileSourceText>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FileSourceTextToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FileSourceText&&(identical(other.value, value) || other.value == value)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,start,end);

@override
String toString() {
  return 'FileSourceText(value: $value, start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class _$FileSourceTextCopyWith<$Res> implements $FileSourceTextCopyWith<$Res> {
  factory _$FileSourceTextCopyWith(_FileSourceText value, $Res Function(_FileSourceText) _then) = __$FileSourceTextCopyWithImpl;
@override @useResult
$Res call({
 String value, double start, double end
});




}
/// @nodoc
class __$FileSourceTextCopyWithImpl<$Res>
    implements _$FileSourceTextCopyWith<$Res> {
  __$FileSourceTextCopyWithImpl(this._self, this._then);

  final _FileSourceText _self;
  final $Res Function(_FileSourceText) _then;

/// Create a copy of FileSourceText
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? start = null,Object? end = null,}) {
  return _then(_FileSourceText(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as double,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$Position {

 int get line; int get character;
/// Create a copy of Position
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PositionCopyWith<Position> get copyWith => _$PositionCopyWithImpl<Position>(this as Position, _$identity);

  /// Serializes this Position to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Position&&(identical(other.line, line) || other.line == line)&&(identical(other.character, character) || other.character == character));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,line,character);

@override
String toString() {
  return 'Position(line: $line, character: $character)';
}


}

/// @nodoc
abstract mixin class $PositionCopyWith<$Res>  {
  factory $PositionCopyWith(Position value, $Res Function(Position) _then) = _$PositionCopyWithImpl;
@useResult
$Res call({
 int line, int character
});




}
/// @nodoc
class _$PositionCopyWithImpl<$Res>
    implements $PositionCopyWith<$Res> {
  _$PositionCopyWithImpl(this._self, this._then);

  final Position _self;
  final $Res Function(Position) _then;

/// Create a copy of Position
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? line = null,Object? character = null,}) {
  return _then(_self.copyWith(
line: null == line ? _self.line : line // ignore: cast_nullable_to_non_nullable
as int,character: null == character ? _self.character : character // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Position].
extension PositionPatterns on Position {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Position value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Position() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Position value)  $default,){
final _that = this;
switch (_that) {
case _Position():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Position value)?  $default,){
final _that = this;
switch (_that) {
case _Position() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int line,  int character)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Position() when $default != null:
return $default(_that.line,_that.character);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int line,  int character)  $default,) {final _that = this;
switch (_that) {
case _Position():
return $default(_that.line,_that.character);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int line,  int character)?  $default,) {final _that = this;
switch (_that) {
case _Position() when $default != null:
return $default(_that.line,_that.character);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Position implements Position {
  const _Position({required this.line, required this.character});
  factory _Position.fromJson(Map<String, dynamic> json) => _$PositionFromJson(json);

@override final  int line;
@override final  int character;

/// Create a copy of Position
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PositionCopyWith<_Position> get copyWith => __$PositionCopyWithImpl<_Position>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PositionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Position&&(identical(other.line, line) || other.line == line)&&(identical(other.character, character) || other.character == character));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,line,character);

@override
String toString() {
  return 'Position(line: $line, character: $character)';
}


}

/// @nodoc
abstract mixin class _$PositionCopyWith<$Res> implements $PositionCopyWith<$Res> {
  factory _$PositionCopyWith(_Position value, $Res Function(_Position) _then) = __$PositionCopyWithImpl;
@override @useResult
$Res call({
 int line, int character
});




}
/// @nodoc
class __$PositionCopyWithImpl<$Res>
    implements _$PositionCopyWith<$Res> {
  __$PositionCopyWithImpl(this._self, this._then);

  final _Position _self;
  final $Res Function(_Position) _then;

/// Create a copy of Position
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? line = null,Object? character = null,}) {
  return _then(_Position(
line: null == line ? _self.line : line // ignore: cast_nullable_to_non_nullable
as int,character: null == character ? _self.character : character // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Range {

 Position get start; Position get end;
/// Create a copy of Range
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RangeCopyWith<Range> get copyWith => _$RangeCopyWithImpl<Range>(this as Range, _$identity);

  /// Serializes this Range to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Range&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end);

@override
String toString() {
  return 'Range(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class $RangeCopyWith<$Res>  {
  factory $RangeCopyWith(Range value, $Res Function(Range) _then) = _$RangeCopyWithImpl;
@useResult
$Res call({
 Position start, Position end
});


$PositionCopyWith<$Res> get start;$PositionCopyWith<$Res> get end;

}
/// @nodoc
class _$RangeCopyWithImpl<$Res>
    implements $RangeCopyWith<$Res> {
  _$RangeCopyWithImpl(this._self, this._then);

  final Range _self;
  final $Res Function(Range) _then;

/// Create a copy of Range
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = null,Object? end = null,}) {
  return _then(_self.copyWith(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as Position,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as Position,
  ));
}
/// Create a copy of Range
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PositionCopyWith<$Res> get start {
  
  return $PositionCopyWith<$Res>(_self.start, (value) {
    return _then(_self.copyWith(start: value));
  });
}/// Create a copy of Range
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PositionCopyWith<$Res> get end {
  
  return $PositionCopyWith<$Res>(_self.end, (value) {
    return _then(_self.copyWith(end: value));
  });
}
}


/// Adds pattern-matching-related methods to [Range].
extension RangePatterns on Range {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Range value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Range() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Range value)  $default,){
final _that = this;
switch (_that) {
case _Range():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Range value)?  $default,){
final _that = this;
switch (_that) {
case _Range() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Position start,  Position end)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Range() when $default != null:
return $default(_that.start,_that.end);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Position start,  Position end)  $default,) {final _that = this;
switch (_that) {
case _Range():
return $default(_that.start,_that.end);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Position start,  Position end)?  $default,) {final _that = this;
switch (_that) {
case _Range() when $default != null:
return $default(_that.start,_that.end);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Range implements Range {
  const _Range({required this.start, required this.end});
  factory _Range.fromJson(Map<String, dynamic> json) => _$RangeFromJson(json);

@override final  Position start;
@override final  Position end;

/// Create a copy of Range
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RangeCopyWith<_Range> get copyWith => __$RangeCopyWithImpl<_Range>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RangeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Range&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end);

@override
String toString() {
  return 'Range(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class _$RangeCopyWith<$Res> implements $RangeCopyWith<$Res> {
  factory _$RangeCopyWith(_Range value, $Res Function(_Range) _then) = __$RangeCopyWithImpl;
@override @useResult
$Res call({
 Position start, Position end
});


@override $PositionCopyWith<$Res> get start;@override $PositionCopyWith<$Res> get end;

}
/// @nodoc
class __$RangeCopyWithImpl<$Res>
    implements _$RangeCopyWith<$Res> {
  __$RangeCopyWithImpl(this._self, this._then);

  final _Range _self;
  final $Res Function(_Range) _then;

/// Create a copy of Range
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = null,}) {
  return _then(_Range(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as Position,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as Position,
  ));
}

/// Create a copy of Range
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PositionCopyWith<$Res> get start {
  
  return $PositionCopyWith<$Res>(_self.start, (value) {
    return _then(_self.copyWith(start: value));
  });
}/// Create a copy of Range
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PositionCopyWith<$Res> get end {
  
  return $PositionCopyWith<$Res>(_self.end, (value) {
    return _then(_self.copyWith(end: value));
  });
}
}


/// @nodoc
mixin _$ApiError {

 String get name; Map<String, dynamic>? get data;
/// Create a copy of ApiError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiErrorCopyWith<ApiError> get copyWith => _$ApiErrorCopyWithImpl<ApiError>(this as ApiError, _$identity);

  /// Serializes this ApiError to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiError&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'ApiError(name: $name, data: $data)';
}


}

/// @nodoc
abstract mixin class $ApiErrorCopyWith<$Res>  {
  factory $ApiErrorCopyWith(ApiError value, $Res Function(ApiError) _then) = _$ApiErrorCopyWithImpl;
@useResult
$Res call({
 String name, Map<String, dynamic>? data
});




}
/// @nodoc
class _$ApiErrorCopyWithImpl<$Res>
    implements $ApiErrorCopyWith<$Res> {
  _$ApiErrorCopyWithImpl(this._self, this._then);

  final ApiError _self;
  final $Res Function(ApiError) _then;

/// Create a copy of ApiError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? data = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ApiError].
extension ApiErrorPatterns on ApiError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApiError value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApiError() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiError value)  $default,){
final _that = this;
switch (_that) {
case _ApiError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiError value)?  $default,){
final _that = this;
switch (_that) {
case _ApiError() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  Map<String, dynamic>? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApiError() when $default != null:
return $default(_that.name,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  Map<String, dynamic>? data)  $default,) {final _that = this;
switch (_that) {
case _ApiError():
return $default(_that.name,_that.data);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  Map<String, dynamic>? data)?  $default,) {final _that = this;
switch (_that) {
case _ApiError() when $default != null:
return $default(_that.name,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApiError extends ApiError {
  const _ApiError({required this.name, final  Map<String, dynamic>? data}): _data = data,super._();
  factory _ApiError.fromJson(Map<String, dynamic> json) => _$ApiErrorFromJson(json);

@override final  String name;
 final  Map<String, dynamic>? _data;
@override Map<String, dynamic>? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of ApiError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiErrorCopyWith<_ApiError> get copyWith => __$ApiErrorCopyWithImpl<_ApiError>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApiErrorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiError&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'ApiError(name: $name, data: $data)';
}


}

/// @nodoc
abstract mixin class _$ApiErrorCopyWith<$Res> implements $ApiErrorCopyWith<$Res> {
  factory _$ApiErrorCopyWith(_ApiError value, $Res Function(_ApiError) _then) = __$ApiErrorCopyWithImpl;
@override @useResult
$Res call({
 String name, Map<String, dynamic>? data
});




}
/// @nodoc
class __$ApiErrorCopyWithImpl<$Res>
    implements _$ApiErrorCopyWith<$Res> {
  __$ApiErrorCopyWithImpl(this._self, this._then);

  final _ApiError _self;
  final $Res Function(_ApiError) _then;

/// Create a copy of ApiError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? data = freezed,}) {
  return _then(_ApiError(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

FilePartSource _$FilePartSourceFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'file':
          return FileSource.fromJson(
            json
          );
                case 'symbol':
          return SymbolSource.fromJson(
            json
          );
                case 'resource':
          return ResourceSource.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'FilePartSource',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$FilePartSource {

 FileSourceText get text;
/// Create a copy of FilePartSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilePartSourceCopyWith<FilePartSource> get copyWith => _$FilePartSourceCopyWithImpl<FilePartSource>(this as FilePartSource, _$identity);

  /// Serializes this FilePartSource to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilePartSource&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'FilePartSource(text: $text)';
}


}

/// @nodoc
abstract mixin class $FilePartSourceCopyWith<$Res>  {
  factory $FilePartSourceCopyWith(FilePartSource value, $Res Function(FilePartSource) _then) = _$FilePartSourceCopyWithImpl;
@useResult
$Res call({
 FileSourceText text
});


$FileSourceTextCopyWith<$Res> get text;

}
/// @nodoc
class _$FilePartSourceCopyWithImpl<$Res>
    implements $FilePartSourceCopyWith<$Res> {
  _$FilePartSourceCopyWithImpl(this._self, this._then);

  final FilePartSource _self;
  final $Res Function(FilePartSource) _then;

/// Create a copy of FilePartSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as FileSourceText,
  ));
}
/// Create a copy of FilePartSource
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FileSourceTextCopyWith<$Res> get text {
  
  return $FileSourceTextCopyWith<$Res>(_self.text, (value) {
    return _then(_self.copyWith(text: value));
  });
}
}


/// Adds pattern-matching-related methods to [FilePartSource].
extension FilePartSourcePatterns on FilePartSource {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FileSource value)?  file,TResult Function( SymbolSource value)?  symbol,TResult Function( ResourceSource value)?  resource,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FileSource() when file != null:
return file(_that);case SymbolSource() when symbol != null:
return symbol(_that);case ResourceSource() when resource != null:
return resource(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FileSource value)  file,required TResult Function( SymbolSource value)  symbol,required TResult Function( ResourceSource value)  resource,}){
final _that = this;
switch (_that) {
case FileSource():
return file(_that);case SymbolSource():
return symbol(_that);case ResourceSource():
return resource(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FileSource value)?  file,TResult? Function( SymbolSource value)?  symbol,TResult? Function( ResourceSource value)?  resource,}){
final _that = this;
switch (_that) {
case FileSource() when file != null:
return file(_that);case SymbolSource() when symbol != null:
return symbol(_that);case ResourceSource() when resource != null:
return resource(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( FileSourceText text,  String path)?  file,TResult Function( FileSourceText text,  String path,  Range range,  String name,  int kind)?  symbol,TResult Function( FileSourceText text,  String clientName,  String uri)?  resource,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FileSource() when file != null:
return file(_that.text,_that.path);case SymbolSource() when symbol != null:
return symbol(_that.text,_that.path,_that.range,_that.name,_that.kind);case ResourceSource() when resource != null:
return resource(_that.text,_that.clientName,_that.uri);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( FileSourceText text,  String path)  file,required TResult Function( FileSourceText text,  String path,  Range range,  String name,  int kind)  symbol,required TResult Function( FileSourceText text,  String clientName,  String uri)  resource,}) {final _that = this;
switch (_that) {
case FileSource():
return file(_that.text,_that.path);case SymbolSource():
return symbol(_that.text,_that.path,_that.range,_that.name,_that.kind);case ResourceSource():
return resource(_that.text,_that.clientName,_that.uri);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( FileSourceText text,  String path)?  file,TResult? Function( FileSourceText text,  String path,  Range range,  String name,  int kind)?  symbol,TResult? Function( FileSourceText text,  String clientName,  String uri)?  resource,}) {final _that = this;
switch (_that) {
case FileSource() when file != null:
return file(_that.text,_that.path);case SymbolSource() when symbol != null:
return symbol(_that.text,_that.path,_that.range,_that.name,_that.kind);case ResourceSource() when resource != null:
return resource(_that.text,_that.clientName,_that.uri);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class FileSource implements FilePartSource {
  const FileSource({required this.text, required this.path, final  String? $type}): $type = $type ?? 'file';
  factory FileSource.fromJson(Map<String, dynamic> json) => _$FileSourceFromJson(json);

@override final  FileSourceText text;
 final  String path;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of FilePartSource
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FileSourceCopyWith<FileSource> get copyWith => _$FileSourceCopyWithImpl<FileSource>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FileSourceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FileSource&&(identical(other.text, text) || other.text == text)&&(identical(other.path, path) || other.path == path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,path);

@override
String toString() {
  return 'FilePartSource.file(text: $text, path: $path)';
}


}

/// @nodoc
abstract mixin class $FileSourceCopyWith<$Res> implements $FilePartSourceCopyWith<$Res> {
  factory $FileSourceCopyWith(FileSource value, $Res Function(FileSource) _then) = _$FileSourceCopyWithImpl;
@override @useResult
$Res call({
 FileSourceText text, String path
});


@override $FileSourceTextCopyWith<$Res> get text;

}
/// @nodoc
class _$FileSourceCopyWithImpl<$Res>
    implements $FileSourceCopyWith<$Res> {
  _$FileSourceCopyWithImpl(this._self, this._then);

  final FileSource _self;
  final $Res Function(FileSource) _then;

/// Create a copy of FilePartSource
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? path = null,}) {
  return _then(FileSource(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as FileSourceText,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of FilePartSource
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FileSourceTextCopyWith<$Res> get text {
  
  return $FileSourceTextCopyWith<$Res>(_self.text, (value) {
    return _then(_self.copyWith(text: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class SymbolSource implements FilePartSource {
  const SymbolSource({required this.text, required this.path, required this.range, required this.name, required this.kind, final  String? $type}): $type = $type ?? 'symbol';
  factory SymbolSource.fromJson(Map<String, dynamic> json) => _$SymbolSourceFromJson(json);

@override final  FileSourceText text;
 final  String path;
 final  Range range;
 final  String name;
 final  int kind;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of FilePartSource
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SymbolSourceCopyWith<SymbolSource> get copyWith => _$SymbolSourceCopyWithImpl<SymbolSource>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SymbolSourceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SymbolSource&&(identical(other.text, text) || other.text == text)&&(identical(other.path, path) || other.path == path)&&(identical(other.range, range) || other.range == range)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,path,range,name,kind);

@override
String toString() {
  return 'FilePartSource.symbol(text: $text, path: $path, range: $range, name: $name, kind: $kind)';
}


}

/// @nodoc
abstract mixin class $SymbolSourceCopyWith<$Res> implements $FilePartSourceCopyWith<$Res> {
  factory $SymbolSourceCopyWith(SymbolSource value, $Res Function(SymbolSource) _then) = _$SymbolSourceCopyWithImpl;
@override @useResult
$Res call({
 FileSourceText text, String path, Range range, String name, int kind
});


@override $FileSourceTextCopyWith<$Res> get text;$RangeCopyWith<$Res> get range;

}
/// @nodoc
class _$SymbolSourceCopyWithImpl<$Res>
    implements $SymbolSourceCopyWith<$Res> {
  _$SymbolSourceCopyWithImpl(this._self, this._then);

  final SymbolSource _self;
  final $Res Function(SymbolSource) _then;

/// Create a copy of FilePartSource
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? path = null,Object? range = null,Object? name = null,Object? kind = null,}) {
  return _then(SymbolSource(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as FileSourceText,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as Range,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of FilePartSource
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FileSourceTextCopyWith<$Res> get text {
  
  return $FileSourceTextCopyWith<$Res>(_self.text, (value) {
    return _then(_self.copyWith(text: value));
  });
}/// Create a copy of FilePartSource
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RangeCopyWith<$Res> get range {
  
  return $RangeCopyWith<$Res>(_self.range, (value) {
    return _then(_self.copyWith(range: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class ResourceSource implements FilePartSource {
  const ResourceSource({required this.text, required this.clientName, required this.uri, final  String? $type}): $type = $type ?? 'resource';
  factory ResourceSource.fromJson(Map<String, dynamic> json) => _$ResourceSourceFromJson(json);

@override final  FileSourceText text;
 final  String clientName;
 final  String uri;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of FilePartSource
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResourceSourceCopyWith<ResourceSource> get copyWith => _$ResourceSourceCopyWithImpl<ResourceSource>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResourceSourceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResourceSource&&(identical(other.text, text) || other.text == text)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.uri, uri) || other.uri == uri));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,clientName,uri);

@override
String toString() {
  return 'FilePartSource.resource(text: $text, clientName: $clientName, uri: $uri)';
}


}

/// @nodoc
abstract mixin class $ResourceSourceCopyWith<$Res> implements $FilePartSourceCopyWith<$Res> {
  factory $ResourceSourceCopyWith(ResourceSource value, $Res Function(ResourceSource) _then) = _$ResourceSourceCopyWithImpl;
@override @useResult
$Res call({
 FileSourceText text, String clientName, String uri
});


@override $FileSourceTextCopyWith<$Res> get text;

}
/// @nodoc
class _$ResourceSourceCopyWithImpl<$Res>
    implements $ResourceSourceCopyWith<$Res> {
  _$ResourceSourceCopyWithImpl(this._self, this._then);

  final ResourceSource _self;
  final $Res Function(ResourceSource) _then;

/// Create a copy of FilePartSource
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? clientName = null,Object? uri = null,}) {
  return _then(ResourceSource(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as FileSourceText,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of FilePartSource
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FileSourceTextCopyWith<$Res> get text {
  
  return $FileSourceTextCopyWith<$Res>(_self.text, (value) {
    return _then(_self.copyWith(text: value));
  });
}
}

ToolState _$ToolStateFromJson(
  Map<String, dynamic> json
) {
        switch (json['status']) {
                  case 'pending':
          return ToolStatePending.fromJson(
            json
          );
                case 'running':
          return ToolStateRunning.fromJson(
            json
          );
                case 'completed':
          return ToolStateCompleted.fromJson(
            json
          );
                case 'error':
          return ToolStateError.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'status',
  'ToolState',
  'Invalid union type "${json['status']}"!'
);
        }
      
}

/// @nodoc
mixin _$ToolState {

 Map<String, dynamic> get input;
/// Create a copy of ToolState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToolStateCopyWith<ToolState> get copyWith => _$ToolStateCopyWithImpl<ToolState>(this as ToolState, _$identity);

  /// Serializes this ToolState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToolState&&const DeepCollectionEquality().equals(other.input, input));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(input));

@override
String toString() {
  return 'ToolState(input: $input)';
}


}

/// @nodoc
abstract mixin class $ToolStateCopyWith<$Res>  {
  factory $ToolStateCopyWith(ToolState value, $Res Function(ToolState) _then) = _$ToolStateCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> input
});




}
/// @nodoc
class _$ToolStateCopyWithImpl<$Res>
    implements $ToolStateCopyWith<$Res> {
  _$ToolStateCopyWithImpl(this._self, this._then);

  final ToolState _self;
  final $Res Function(ToolState) _then;

/// Create a copy of ToolState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? input = null,}) {
  return _then(_self.copyWith(
input: null == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [ToolState].
extension ToolStatePatterns on ToolState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ToolStatePending value)?  pending,TResult Function( ToolStateRunning value)?  running,TResult Function( ToolStateCompleted value)?  completed,TResult Function( ToolStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ToolStatePending() when pending != null:
return pending(_that);case ToolStateRunning() when running != null:
return running(_that);case ToolStateCompleted() when completed != null:
return completed(_that);case ToolStateError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ToolStatePending value)  pending,required TResult Function( ToolStateRunning value)  running,required TResult Function( ToolStateCompleted value)  completed,required TResult Function( ToolStateError value)  error,}){
final _that = this;
switch (_that) {
case ToolStatePending():
return pending(_that);case ToolStateRunning():
return running(_that);case ToolStateCompleted():
return completed(_that);case ToolStateError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ToolStatePending value)?  pending,TResult? Function( ToolStateRunning value)?  running,TResult? Function( ToolStateCompleted value)?  completed,TResult? Function( ToolStateError value)?  error,}){
final _that = this;
switch (_that) {
case ToolStatePending() when pending != null:
return pending(_that);case ToolStateRunning() when running != null:
return running(_that);case ToolStateCompleted() when completed != null:
return completed(_that);case ToolStateError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Map<String, dynamic> input,  String raw)?  pending,TResult Function( Map<String, dynamic> input,  String? title,  Map<String, dynamic>? metadata,  ToolTimeStart time)?  running,TResult Function( Map<String, dynamic> input,  String output,  String title,  Map<String, dynamic> metadata,  ToolTimeFull time,  List<FilePart>? attachments)?  completed,TResult Function( Map<String, dynamic> input,  String error,  Map<String, dynamic>? metadata,  ToolTimeFull time)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ToolStatePending() when pending != null:
return pending(_that.input,_that.raw);case ToolStateRunning() when running != null:
return running(_that.input,_that.title,_that.metadata,_that.time);case ToolStateCompleted() when completed != null:
return completed(_that.input,_that.output,_that.title,_that.metadata,_that.time,_that.attachments);case ToolStateError() when error != null:
return error(_that.input,_that.error,_that.metadata,_that.time);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Map<String, dynamic> input,  String raw)  pending,required TResult Function( Map<String, dynamic> input,  String? title,  Map<String, dynamic>? metadata,  ToolTimeStart time)  running,required TResult Function( Map<String, dynamic> input,  String output,  String title,  Map<String, dynamic> metadata,  ToolTimeFull time,  List<FilePart>? attachments)  completed,required TResult Function( Map<String, dynamic> input,  String error,  Map<String, dynamic>? metadata,  ToolTimeFull time)  error,}) {final _that = this;
switch (_that) {
case ToolStatePending():
return pending(_that.input,_that.raw);case ToolStateRunning():
return running(_that.input,_that.title,_that.metadata,_that.time);case ToolStateCompleted():
return completed(_that.input,_that.output,_that.title,_that.metadata,_that.time,_that.attachments);case ToolStateError():
return error(_that.input,_that.error,_that.metadata,_that.time);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Map<String, dynamic> input,  String raw)?  pending,TResult? Function( Map<String, dynamic> input,  String? title,  Map<String, dynamic>? metadata,  ToolTimeStart time)?  running,TResult? Function( Map<String, dynamic> input,  String output,  String title,  Map<String, dynamic> metadata,  ToolTimeFull time,  List<FilePart>? attachments)?  completed,TResult? Function( Map<String, dynamic> input,  String error,  Map<String, dynamic>? metadata,  ToolTimeFull time)?  error,}) {final _that = this;
switch (_that) {
case ToolStatePending() when pending != null:
return pending(_that.input,_that.raw);case ToolStateRunning() when running != null:
return running(_that.input,_that.title,_that.metadata,_that.time);case ToolStateCompleted() when completed != null:
return completed(_that.input,_that.output,_that.title,_that.metadata,_that.time,_that.attachments);case ToolStateError() when error != null:
return error(_that.input,_that.error,_that.metadata,_that.time);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class ToolStatePending implements ToolState {
  const ToolStatePending({required final  Map<String, dynamic> input, required this.raw, final  String? $type}): _input = input,$type = $type ?? 'pending';
  factory ToolStatePending.fromJson(Map<String, dynamic> json) => _$ToolStatePendingFromJson(json);

 final  Map<String, dynamic> _input;
@override Map<String, dynamic> get input {
  if (_input is EqualUnmodifiableMapView) return _input;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_input);
}

 final  String raw;

@JsonKey(name: 'status')
final String $type;


/// Create a copy of ToolState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToolStatePendingCopyWith<ToolStatePending> get copyWith => _$ToolStatePendingCopyWithImpl<ToolStatePending>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ToolStatePendingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToolStatePending&&const DeepCollectionEquality().equals(other._input, _input)&&(identical(other.raw, raw) || other.raw == raw));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_input),raw);

@override
String toString() {
  return 'ToolState.pending(input: $input, raw: $raw)';
}


}

/// @nodoc
abstract mixin class $ToolStatePendingCopyWith<$Res> implements $ToolStateCopyWith<$Res> {
  factory $ToolStatePendingCopyWith(ToolStatePending value, $Res Function(ToolStatePending) _then) = _$ToolStatePendingCopyWithImpl;
@override @useResult
$Res call({
 Map<String, dynamic> input, String raw
});




}
/// @nodoc
class _$ToolStatePendingCopyWithImpl<$Res>
    implements $ToolStatePendingCopyWith<$Res> {
  _$ToolStatePendingCopyWithImpl(this._self, this._then);

  final ToolStatePending _self;
  final $Res Function(ToolStatePending) _then;

/// Create a copy of ToolState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? input = null,Object? raw = null,}) {
  return _then(ToolStatePending(
input: null == input ? _self._input : input // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ToolStateRunning implements ToolState {
  const ToolStateRunning({required final  Map<String, dynamic> input, this.title, final  Map<String, dynamic>? metadata, required this.time, final  String? $type}): _input = input,_metadata = metadata,$type = $type ?? 'running';
  factory ToolStateRunning.fromJson(Map<String, dynamic> json) => _$ToolStateRunningFromJson(json);

 final  Map<String, dynamic> _input;
@override Map<String, dynamic> get input {
  if (_input is EqualUnmodifiableMapView) return _input;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_input);
}

 final  String? title;
 final  Map<String, dynamic>? _metadata;
 Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  ToolTimeStart time;

@JsonKey(name: 'status')
final String $type;


/// Create a copy of ToolState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToolStateRunningCopyWith<ToolStateRunning> get copyWith => _$ToolStateRunningCopyWithImpl<ToolStateRunning>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ToolStateRunningToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToolStateRunning&&const DeepCollectionEquality().equals(other._input, _input)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.time, time) || other.time == time));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_input),title,const DeepCollectionEquality().hash(_metadata),time);

@override
String toString() {
  return 'ToolState.running(input: $input, title: $title, metadata: $metadata, time: $time)';
}


}

/// @nodoc
abstract mixin class $ToolStateRunningCopyWith<$Res> implements $ToolStateCopyWith<$Res> {
  factory $ToolStateRunningCopyWith(ToolStateRunning value, $Res Function(ToolStateRunning) _then) = _$ToolStateRunningCopyWithImpl;
@override @useResult
$Res call({
 Map<String, dynamic> input, String? title, Map<String, dynamic>? metadata, ToolTimeStart time
});


$ToolTimeStartCopyWith<$Res> get time;

}
/// @nodoc
class _$ToolStateRunningCopyWithImpl<$Res>
    implements $ToolStateRunningCopyWith<$Res> {
  _$ToolStateRunningCopyWithImpl(this._self, this._then);

  final ToolStateRunning _self;
  final $Res Function(ToolStateRunning) _then;

/// Create a copy of ToolState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? input = null,Object? title = freezed,Object? metadata = freezed,Object? time = null,}) {
  return _then(ToolStateRunning(
input: null == input ? _self._input : input // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as ToolTimeStart,
  ));
}

/// Create a copy of ToolState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ToolTimeStartCopyWith<$Res> get time {
  
  return $ToolTimeStartCopyWith<$Res>(_self.time, (value) {
    return _then(_self.copyWith(time: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class ToolStateCompleted implements ToolState {
  const ToolStateCompleted({required final  Map<String, dynamic> input, required this.output, required this.title, required final  Map<String, dynamic> metadata, required this.time, final  List<FilePart>? attachments, final  String? $type}): _input = input,_metadata = metadata,_attachments = attachments,$type = $type ?? 'completed';
  factory ToolStateCompleted.fromJson(Map<String, dynamic> json) => _$ToolStateCompletedFromJson(json);

 final  Map<String, dynamic> _input;
@override Map<String, dynamic> get input {
  if (_input is EqualUnmodifiableMapView) return _input;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_input);
}

 final  String output;
 final  String title;
 final  Map<String, dynamic> _metadata;
 Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

 final  ToolTimeFull time;
 final  List<FilePart>? _attachments;
 List<FilePart>? get attachments {
  final value = _attachments;
  if (value == null) return null;
  if (_attachments is EqualUnmodifiableListView) return _attachments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


@JsonKey(name: 'status')
final String $type;


/// Create a copy of ToolState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToolStateCompletedCopyWith<ToolStateCompleted> get copyWith => _$ToolStateCompletedCopyWithImpl<ToolStateCompleted>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ToolStateCompletedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToolStateCompleted&&const DeepCollectionEquality().equals(other._input, _input)&&(identical(other.output, output) || other.output == output)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.time, time) || other.time == time)&&const DeepCollectionEquality().equals(other._attachments, _attachments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_input),output,title,const DeepCollectionEquality().hash(_metadata),time,const DeepCollectionEquality().hash(_attachments));

@override
String toString() {
  return 'ToolState.completed(input: $input, output: $output, title: $title, metadata: $metadata, time: $time, attachments: $attachments)';
}


}

/// @nodoc
abstract mixin class $ToolStateCompletedCopyWith<$Res> implements $ToolStateCopyWith<$Res> {
  factory $ToolStateCompletedCopyWith(ToolStateCompleted value, $Res Function(ToolStateCompleted) _then) = _$ToolStateCompletedCopyWithImpl;
@override @useResult
$Res call({
 Map<String, dynamic> input, String output, String title, Map<String, dynamic> metadata, ToolTimeFull time, List<FilePart>? attachments
});


$ToolTimeFullCopyWith<$Res> get time;

}
/// @nodoc
class _$ToolStateCompletedCopyWithImpl<$Res>
    implements $ToolStateCompletedCopyWith<$Res> {
  _$ToolStateCompletedCopyWithImpl(this._self, this._then);

  final ToolStateCompleted _self;
  final $Res Function(ToolStateCompleted) _then;

/// Create a copy of ToolState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? input = null,Object? output = null,Object? title = null,Object? metadata = null,Object? time = null,Object? attachments = freezed,}) {
  return _then(ToolStateCompleted(
input: null == input ? _self._input : input // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,output: null == output ? _self.output : output // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as ToolTimeFull,attachments: freezed == attachments ? _self._attachments : attachments // ignore: cast_nullable_to_non_nullable
as List<FilePart>?,
  ));
}

/// Create a copy of ToolState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ToolTimeFullCopyWith<$Res> get time {
  
  return $ToolTimeFullCopyWith<$Res>(_self.time, (value) {
    return _then(_self.copyWith(time: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class ToolStateError implements ToolState {
  const ToolStateError({required final  Map<String, dynamic> input, required this.error, final  Map<String, dynamic>? metadata, required this.time, final  String? $type}): _input = input,_metadata = metadata,$type = $type ?? 'error';
  factory ToolStateError.fromJson(Map<String, dynamic> json) => _$ToolStateErrorFromJson(json);

 final  Map<String, dynamic> _input;
@override Map<String, dynamic> get input {
  if (_input is EqualUnmodifiableMapView) return _input;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_input);
}

 final  String error;
 final  Map<String, dynamic>? _metadata;
 Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  ToolTimeFull time;

@JsonKey(name: 'status')
final String $type;


/// Create a copy of ToolState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToolStateErrorCopyWith<ToolStateError> get copyWith => _$ToolStateErrorCopyWithImpl<ToolStateError>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ToolStateErrorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToolStateError&&const DeepCollectionEquality().equals(other._input, _input)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.time, time) || other.time == time));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_input),error,const DeepCollectionEquality().hash(_metadata),time);

@override
String toString() {
  return 'ToolState.error(input: $input, error: $error, metadata: $metadata, time: $time)';
}


}

/// @nodoc
abstract mixin class $ToolStateErrorCopyWith<$Res> implements $ToolStateCopyWith<$Res> {
  factory $ToolStateErrorCopyWith(ToolStateError value, $Res Function(ToolStateError) _then) = _$ToolStateErrorCopyWithImpl;
@override @useResult
$Res call({
 Map<String, dynamic> input, String error, Map<String, dynamic>? metadata, ToolTimeFull time
});


$ToolTimeFullCopyWith<$Res> get time;

}
/// @nodoc
class _$ToolStateErrorCopyWithImpl<$Res>
    implements $ToolStateErrorCopyWith<$Res> {
  _$ToolStateErrorCopyWithImpl(this._self, this._then);

  final ToolStateError _self;
  final $Res Function(ToolStateError) _then;

/// Create a copy of ToolState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? input = null,Object? error = null,Object? metadata = freezed,Object? time = null,}) {
  return _then(ToolStateError(
input: null == input ? _self._input : input // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as ToolTimeFull,
  ));
}

/// Create a copy of ToolState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ToolTimeFullCopyWith<$Res> get time {
  
  return $ToolTimeFullCopyWith<$Res>(_self.time, (value) {
    return _then(_self.copyWith(time: value));
  });
}
}

MessagePart _$MessagePartFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'text':
          return TextPart.fromJson(
            json
          );
                case 'reasoning':
          return ReasoningPart.fromJson(
            json
          );
                case 'tool':
          return ToolPart.fromJson(
            json
          );
                case 'step-start':
          return StepStartPart.fromJson(
            json
          );
                case 'step-finish':
          return StepFinishPart.fromJson(
            json
          );
                case 'file':
          return FilePart.fromJson(
            json
          );
                case 'snapshot':
          return SnapshotPart.fromJson(
            json
          );
                case 'patch':
          return PatchPart.fromJson(
            json
          );
                case 'agent':
          return AgentPart.fromJson(
            json
          );
                case 'retry':
          return RetryPart.fromJson(
            json
          );
                case 'compaction':
          return CompactionPart.fromJson(
            json
          );
                case 'subtask':
          return SubtaskPart.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'MessagePart',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$MessagePart {

 String get id; String get sessionID; String get messageID;
/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessagePartCopyWith<MessagePart> get copyWith => _$MessagePartCopyWithImpl<MessagePart>(this as MessagePart, _$identity);

  /// Serializes this MessagePart to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessagePart&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionID, sessionID) || other.sessionID == sessionID)&&(identical(other.messageID, messageID) || other.messageID == messageID));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sessionID,messageID);

@override
String toString() {
  return 'MessagePart(id: $id, sessionID: $sessionID, messageID: $messageID)';
}


}

/// @nodoc
abstract mixin class $MessagePartCopyWith<$Res>  {
  factory $MessagePartCopyWith(MessagePart value, $Res Function(MessagePart) _then) = _$MessagePartCopyWithImpl;
@useResult
$Res call({
 String id, String sessionID, String messageID
});




}
/// @nodoc
class _$MessagePartCopyWithImpl<$Res>
    implements $MessagePartCopyWith<$Res> {
  _$MessagePartCopyWithImpl(this._self, this._then);

  final MessagePart _self;
  final $Res Function(MessagePart) _then;

/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sessionID = null,Object? messageID = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionID: null == sessionID ? _self.sessionID : sessionID // ignore: cast_nullable_to_non_nullable
as String,messageID: null == messageID ? _self.messageID : messageID // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MessagePart].
extension MessagePartPatterns on MessagePart {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TextPart value)?  text,TResult Function( ReasoningPart value)?  reasoning,TResult Function( ToolPart value)?  tool,TResult Function( StepStartPart value)?  stepStart,TResult Function( StepFinishPart value)?  stepFinish,TResult Function( FilePart value)?  file,TResult Function( SnapshotPart value)?  snapshot,TResult Function( PatchPart value)?  patch,TResult Function( AgentPart value)?  agent,TResult Function( RetryPart value)?  retry,TResult Function( CompactionPart value)?  compaction,TResult Function( SubtaskPart value)?  subtask,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TextPart() when text != null:
return text(_that);case ReasoningPart() when reasoning != null:
return reasoning(_that);case ToolPart() when tool != null:
return tool(_that);case StepStartPart() when stepStart != null:
return stepStart(_that);case StepFinishPart() when stepFinish != null:
return stepFinish(_that);case FilePart() when file != null:
return file(_that);case SnapshotPart() when snapshot != null:
return snapshot(_that);case PatchPart() when patch != null:
return patch(_that);case AgentPart() when agent != null:
return agent(_that);case RetryPart() when retry != null:
return retry(_that);case CompactionPart() when compaction != null:
return compaction(_that);case SubtaskPart() when subtask != null:
return subtask(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TextPart value)  text,required TResult Function( ReasoningPart value)  reasoning,required TResult Function( ToolPart value)  tool,required TResult Function( StepStartPart value)  stepStart,required TResult Function( StepFinishPart value)  stepFinish,required TResult Function( FilePart value)  file,required TResult Function( SnapshotPart value)  snapshot,required TResult Function( PatchPart value)  patch,required TResult Function( AgentPart value)  agent,required TResult Function( RetryPart value)  retry,required TResult Function( CompactionPart value)  compaction,required TResult Function( SubtaskPart value)  subtask,}){
final _that = this;
switch (_that) {
case TextPart():
return text(_that);case ReasoningPart():
return reasoning(_that);case ToolPart():
return tool(_that);case StepStartPart():
return stepStart(_that);case StepFinishPart():
return stepFinish(_that);case FilePart():
return file(_that);case SnapshotPart():
return snapshot(_that);case PatchPart():
return patch(_that);case AgentPart():
return agent(_that);case RetryPart():
return retry(_that);case CompactionPart():
return compaction(_that);case SubtaskPart():
return subtask(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TextPart value)?  text,TResult? Function( ReasoningPart value)?  reasoning,TResult? Function( ToolPart value)?  tool,TResult? Function( StepStartPart value)?  stepStart,TResult? Function( StepFinishPart value)?  stepFinish,TResult? Function( FilePart value)?  file,TResult? Function( SnapshotPart value)?  snapshot,TResult? Function( PatchPart value)?  patch,TResult? Function( AgentPart value)?  agent,TResult? Function( RetryPart value)?  retry,TResult? Function( CompactionPart value)?  compaction,TResult? Function( SubtaskPart value)?  subtask,}){
final _that = this;
switch (_that) {
case TextPart() when text != null:
return text(_that);case ReasoningPart() when reasoning != null:
return reasoning(_that);case ToolPart() when tool != null:
return tool(_that);case StepStartPart() when stepStart != null:
return stepStart(_that);case StepFinishPart() when stepFinish != null:
return stepFinish(_that);case FilePart() when file != null:
return file(_that);case SnapshotPart() when snapshot != null:
return snapshot(_that);case PatchPart() when patch != null:
return patch(_that);case AgentPart() when agent != null:
return agent(_that);case RetryPart() when retry != null:
return retry(_that);case CompactionPart() when compaction != null:
return compaction(_that);case SubtaskPart() when subtask != null:
return subtask(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String id,  String sessionID,  String messageID,  String text,  bool? synthetic,  bool? ignored,  PartTime? time,  Map<String, dynamic>? metadata)?  text,TResult Function( String id,  String sessionID,  String messageID,  String text,  Map<String, dynamic>? metadata,  PartTime time)?  reasoning,TResult Function( String id,  String sessionID,  String messageID,  String callID,  String tool,  ToolState state,  Map<String, dynamic>? metadata)?  tool,TResult Function( String id,  String sessionID,  String messageID,  String? snapshot)?  stepStart,TResult Function( String id,  String sessionID,  String messageID,  String reason,  String? snapshot,  double cost,  Tokens tokens)?  stepFinish,TResult Function( String id,  String sessionID,  String messageID,  String mime,  String? filename,  String url,  FilePartSource? source)?  file,TResult Function( String id,  String sessionID,  String messageID,  String snapshot)?  snapshot,TResult Function( String id,  String sessionID,  String messageID,  String hash,  List<String> files)?  patch,TResult Function( String id,  String sessionID,  String messageID,  String name,  AgentPartSource? source)?  agent,TResult Function( String id,  String sessionID,  String messageID,  int attempt,  ApiError error,  RetryTime time)?  retry,TResult Function( String id,  String sessionID,  String messageID,  bool auto,  bool? overflow, @JsonKey(name: 'tail_start_id')  String? tailStartID)?  compaction,TResult Function( String id,  String sessionID,  String messageID,  String prompt,  String description,  String agent,  ModelRef? model,  String? command)?  subtask,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TextPart() when text != null:
return text(_that.id,_that.sessionID,_that.messageID,_that.text,_that.synthetic,_that.ignored,_that.time,_that.metadata);case ReasoningPart() when reasoning != null:
return reasoning(_that.id,_that.sessionID,_that.messageID,_that.text,_that.metadata,_that.time);case ToolPart() when tool != null:
return tool(_that.id,_that.sessionID,_that.messageID,_that.callID,_that.tool,_that.state,_that.metadata);case StepStartPart() when stepStart != null:
return stepStart(_that.id,_that.sessionID,_that.messageID,_that.snapshot);case StepFinishPart() when stepFinish != null:
return stepFinish(_that.id,_that.sessionID,_that.messageID,_that.reason,_that.snapshot,_that.cost,_that.tokens);case FilePart() when file != null:
return file(_that.id,_that.sessionID,_that.messageID,_that.mime,_that.filename,_that.url,_that.source);case SnapshotPart() when snapshot != null:
return snapshot(_that.id,_that.sessionID,_that.messageID,_that.snapshot);case PatchPart() when patch != null:
return patch(_that.id,_that.sessionID,_that.messageID,_that.hash,_that.files);case AgentPart() when agent != null:
return agent(_that.id,_that.sessionID,_that.messageID,_that.name,_that.source);case RetryPart() when retry != null:
return retry(_that.id,_that.sessionID,_that.messageID,_that.attempt,_that.error,_that.time);case CompactionPart() when compaction != null:
return compaction(_that.id,_that.sessionID,_that.messageID,_that.auto,_that.overflow,_that.tailStartID);case SubtaskPart() when subtask != null:
return subtask(_that.id,_that.sessionID,_that.messageID,_that.prompt,_that.description,_that.agent,_that.model,_that.command);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String id,  String sessionID,  String messageID,  String text,  bool? synthetic,  bool? ignored,  PartTime? time,  Map<String, dynamic>? metadata)  text,required TResult Function( String id,  String sessionID,  String messageID,  String text,  Map<String, dynamic>? metadata,  PartTime time)  reasoning,required TResult Function( String id,  String sessionID,  String messageID,  String callID,  String tool,  ToolState state,  Map<String, dynamic>? metadata)  tool,required TResult Function( String id,  String sessionID,  String messageID,  String? snapshot)  stepStart,required TResult Function( String id,  String sessionID,  String messageID,  String reason,  String? snapshot,  double cost,  Tokens tokens)  stepFinish,required TResult Function( String id,  String sessionID,  String messageID,  String mime,  String? filename,  String url,  FilePartSource? source)  file,required TResult Function( String id,  String sessionID,  String messageID,  String snapshot)  snapshot,required TResult Function( String id,  String sessionID,  String messageID,  String hash,  List<String> files)  patch,required TResult Function( String id,  String sessionID,  String messageID,  String name,  AgentPartSource? source)  agent,required TResult Function( String id,  String sessionID,  String messageID,  int attempt,  ApiError error,  RetryTime time)  retry,required TResult Function( String id,  String sessionID,  String messageID,  bool auto,  bool? overflow, @JsonKey(name: 'tail_start_id')  String? tailStartID)  compaction,required TResult Function( String id,  String sessionID,  String messageID,  String prompt,  String description,  String agent,  ModelRef? model,  String? command)  subtask,}) {final _that = this;
switch (_that) {
case TextPart():
return text(_that.id,_that.sessionID,_that.messageID,_that.text,_that.synthetic,_that.ignored,_that.time,_that.metadata);case ReasoningPart():
return reasoning(_that.id,_that.sessionID,_that.messageID,_that.text,_that.metadata,_that.time);case ToolPart():
return tool(_that.id,_that.sessionID,_that.messageID,_that.callID,_that.tool,_that.state,_that.metadata);case StepStartPart():
return stepStart(_that.id,_that.sessionID,_that.messageID,_that.snapshot);case StepFinishPart():
return stepFinish(_that.id,_that.sessionID,_that.messageID,_that.reason,_that.snapshot,_that.cost,_that.tokens);case FilePart():
return file(_that.id,_that.sessionID,_that.messageID,_that.mime,_that.filename,_that.url,_that.source);case SnapshotPart():
return snapshot(_that.id,_that.sessionID,_that.messageID,_that.snapshot);case PatchPart():
return patch(_that.id,_that.sessionID,_that.messageID,_that.hash,_that.files);case AgentPart():
return agent(_that.id,_that.sessionID,_that.messageID,_that.name,_that.source);case RetryPart():
return retry(_that.id,_that.sessionID,_that.messageID,_that.attempt,_that.error,_that.time);case CompactionPart():
return compaction(_that.id,_that.sessionID,_that.messageID,_that.auto,_that.overflow,_that.tailStartID);case SubtaskPart():
return subtask(_that.id,_that.sessionID,_that.messageID,_that.prompt,_that.description,_that.agent,_that.model,_that.command);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String id,  String sessionID,  String messageID,  String text,  bool? synthetic,  bool? ignored,  PartTime? time,  Map<String, dynamic>? metadata)?  text,TResult? Function( String id,  String sessionID,  String messageID,  String text,  Map<String, dynamic>? metadata,  PartTime time)?  reasoning,TResult? Function( String id,  String sessionID,  String messageID,  String callID,  String tool,  ToolState state,  Map<String, dynamic>? metadata)?  tool,TResult? Function( String id,  String sessionID,  String messageID,  String? snapshot)?  stepStart,TResult? Function( String id,  String sessionID,  String messageID,  String reason,  String? snapshot,  double cost,  Tokens tokens)?  stepFinish,TResult? Function( String id,  String sessionID,  String messageID,  String mime,  String? filename,  String url,  FilePartSource? source)?  file,TResult? Function( String id,  String sessionID,  String messageID,  String snapshot)?  snapshot,TResult? Function( String id,  String sessionID,  String messageID,  String hash,  List<String> files)?  patch,TResult? Function( String id,  String sessionID,  String messageID,  String name,  AgentPartSource? source)?  agent,TResult? Function( String id,  String sessionID,  String messageID,  int attempt,  ApiError error,  RetryTime time)?  retry,TResult? Function( String id,  String sessionID,  String messageID,  bool auto,  bool? overflow, @JsonKey(name: 'tail_start_id')  String? tailStartID)?  compaction,TResult? Function( String id,  String sessionID,  String messageID,  String prompt,  String description,  String agent,  ModelRef? model,  String? command)?  subtask,}) {final _that = this;
switch (_that) {
case TextPart() when text != null:
return text(_that.id,_that.sessionID,_that.messageID,_that.text,_that.synthetic,_that.ignored,_that.time,_that.metadata);case ReasoningPart() when reasoning != null:
return reasoning(_that.id,_that.sessionID,_that.messageID,_that.text,_that.metadata,_that.time);case ToolPart() when tool != null:
return tool(_that.id,_that.sessionID,_that.messageID,_that.callID,_that.tool,_that.state,_that.metadata);case StepStartPart() when stepStart != null:
return stepStart(_that.id,_that.sessionID,_that.messageID,_that.snapshot);case StepFinishPart() when stepFinish != null:
return stepFinish(_that.id,_that.sessionID,_that.messageID,_that.reason,_that.snapshot,_that.cost,_that.tokens);case FilePart() when file != null:
return file(_that.id,_that.sessionID,_that.messageID,_that.mime,_that.filename,_that.url,_that.source);case SnapshotPart() when snapshot != null:
return snapshot(_that.id,_that.sessionID,_that.messageID,_that.snapshot);case PatchPart() when patch != null:
return patch(_that.id,_that.sessionID,_that.messageID,_that.hash,_that.files);case AgentPart() when agent != null:
return agent(_that.id,_that.sessionID,_that.messageID,_that.name,_that.source);case RetryPart() when retry != null:
return retry(_that.id,_that.sessionID,_that.messageID,_that.attempt,_that.error,_that.time);case CompactionPart() when compaction != null:
return compaction(_that.id,_that.sessionID,_that.messageID,_that.auto,_that.overflow,_that.tailStartID);case SubtaskPart() when subtask != null:
return subtask(_that.id,_that.sessionID,_that.messageID,_that.prompt,_that.description,_that.agent,_that.model,_that.command);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class TextPart implements MessagePart {
  const TextPart({required this.id, required this.sessionID, required this.messageID, required this.text, this.synthetic, this.ignored, this.time, final  Map<String, dynamic>? metadata, final  String? $type}): _metadata = metadata,$type = $type ?? 'text';
  factory TextPart.fromJson(Map<String, dynamic> json) => _$TextPartFromJson(json);

@override final  String id;
@override final  String sessionID;
@override final  String messageID;
 final  String text;
 final  bool? synthetic;
 final  bool? ignored;
 final  PartTime? time;
 final  Map<String, dynamic>? _metadata;
 Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextPartCopyWith<TextPart> get copyWith => _$TextPartCopyWithImpl<TextPart>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TextPartToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextPart&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionID, sessionID) || other.sessionID == sessionID)&&(identical(other.messageID, messageID) || other.messageID == messageID)&&(identical(other.text, text) || other.text == text)&&(identical(other.synthetic, synthetic) || other.synthetic == synthetic)&&(identical(other.ignored, ignored) || other.ignored == ignored)&&(identical(other.time, time) || other.time == time)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sessionID,messageID,text,synthetic,ignored,time,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'MessagePart.text(id: $id, sessionID: $sessionID, messageID: $messageID, text: $text, synthetic: $synthetic, ignored: $ignored, time: $time, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $TextPartCopyWith<$Res> implements $MessagePartCopyWith<$Res> {
  factory $TextPartCopyWith(TextPart value, $Res Function(TextPart) _then) = _$TextPartCopyWithImpl;
@override @useResult
$Res call({
 String id, String sessionID, String messageID, String text, bool? synthetic, bool? ignored, PartTime? time, Map<String, dynamic>? metadata
});


$PartTimeCopyWith<$Res>? get time;

}
/// @nodoc
class _$TextPartCopyWithImpl<$Res>
    implements $TextPartCopyWith<$Res> {
  _$TextPartCopyWithImpl(this._self, this._then);

  final TextPart _self;
  final $Res Function(TextPart) _then;

/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sessionID = null,Object? messageID = null,Object? text = null,Object? synthetic = freezed,Object? ignored = freezed,Object? time = freezed,Object? metadata = freezed,}) {
  return _then(TextPart(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionID: null == sessionID ? _self.sessionID : sessionID // ignore: cast_nullable_to_non_nullable
as String,messageID: null == messageID ? _self.messageID : messageID // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,synthetic: freezed == synthetic ? _self.synthetic : synthetic // ignore: cast_nullable_to_non_nullable
as bool?,ignored: freezed == ignored ? _self.ignored : ignored // ignore: cast_nullable_to_non_nullable
as bool?,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as PartTime?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PartTimeCopyWith<$Res>? get time {
    if (_self.time == null) {
    return null;
  }

  return $PartTimeCopyWith<$Res>(_self.time!, (value) {
    return _then(_self.copyWith(time: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class ReasoningPart implements MessagePart {
  const ReasoningPart({required this.id, required this.sessionID, required this.messageID, required this.text, final  Map<String, dynamic>? metadata, required this.time, final  String? $type}): _metadata = metadata,$type = $type ?? 'reasoning';
  factory ReasoningPart.fromJson(Map<String, dynamic> json) => _$ReasoningPartFromJson(json);

@override final  String id;
@override final  String sessionID;
@override final  String messageID;
 final  String text;
 final  Map<String, dynamic>? _metadata;
 Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  PartTime time;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReasoningPartCopyWith<ReasoningPart> get copyWith => _$ReasoningPartCopyWithImpl<ReasoningPart>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReasoningPartToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReasoningPart&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionID, sessionID) || other.sessionID == sessionID)&&(identical(other.messageID, messageID) || other.messageID == messageID)&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.time, time) || other.time == time));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sessionID,messageID,text,const DeepCollectionEquality().hash(_metadata),time);

@override
String toString() {
  return 'MessagePart.reasoning(id: $id, sessionID: $sessionID, messageID: $messageID, text: $text, metadata: $metadata, time: $time)';
}


}

/// @nodoc
abstract mixin class $ReasoningPartCopyWith<$Res> implements $MessagePartCopyWith<$Res> {
  factory $ReasoningPartCopyWith(ReasoningPart value, $Res Function(ReasoningPart) _then) = _$ReasoningPartCopyWithImpl;
@override @useResult
$Res call({
 String id, String sessionID, String messageID, String text, Map<String, dynamic>? metadata, PartTime time
});


$PartTimeCopyWith<$Res> get time;

}
/// @nodoc
class _$ReasoningPartCopyWithImpl<$Res>
    implements $ReasoningPartCopyWith<$Res> {
  _$ReasoningPartCopyWithImpl(this._self, this._then);

  final ReasoningPart _self;
  final $Res Function(ReasoningPart) _then;

/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sessionID = null,Object? messageID = null,Object? text = null,Object? metadata = freezed,Object? time = null,}) {
  return _then(ReasoningPart(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionID: null == sessionID ? _self.sessionID : sessionID // ignore: cast_nullable_to_non_nullable
as String,messageID: null == messageID ? _self.messageID : messageID // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as PartTime,
  ));
}

/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PartTimeCopyWith<$Res> get time {
  
  return $PartTimeCopyWith<$Res>(_self.time, (value) {
    return _then(_self.copyWith(time: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class ToolPart implements MessagePart {
  const ToolPart({required this.id, required this.sessionID, required this.messageID, required this.callID, required this.tool, required this.state, final  Map<String, dynamic>? metadata, final  String? $type}): _metadata = metadata,$type = $type ?? 'tool';
  factory ToolPart.fromJson(Map<String, dynamic> json) => _$ToolPartFromJson(json);

@override final  String id;
@override final  String sessionID;
@override final  String messageID;
 final  String callID;
 final  String tool;
 final  ToolState state;
 final  Map<String, dynamic>? _metadata;
 Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToolPartCopyWith<ToolPart> get copyWith => _$ToolPartCopyWithImpl<ToolPart>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ToolPartToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToolPart&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionID, sessionID) || other.sessionID == sessionID)&&(identical(other.messageID, messageID) || other.messageID == messageID)&&(identical(other.callID, callID) || other.callID == callID)&&(identical(other.tool, tool) || other.tool == tool)&&(identical(other.state, state) || other.state == state)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sessionID,messageID,callID,tool,state,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'MessagePart.tool(id: $id, sessionID: $sessionID, messageID: $messageID, callID: $callID, tool: $tool, state: $state, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $ToolPartCopyWith<$Res> implements $MessagePartCopyWith<$Res> {
  factory $ToolPartCopyWith(ToolPart value, $Res Function(ToolPart) _then) = _$ToolPartCopyWithImpl;
@override @useResult
$Res call({
 String id, String sessionID, String messageID, String callID, String tool, ToolState state, Map<String, dynamic>? metadata
});


$ToolStateCopyWith<$Res> get state;

}
/// @nodoc
class _$ToolPartCopyWithImpl<$Res>
    implements $ToolPartCopyWith<$Res> {
  _$ToolPartCopyWithImpl(this._self, this._then);

  final ToolPart _self;
  final $Res Function(ToolPart) _then;

/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sessionID = null,Object? messageID = null,Object? callID = null,Object? tool = null,Object? state = null,Object? metadata = freezed,}) {
  return _then(ToolPart(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionID: null == sessionID ? _self.sessionID : sessionID // ignore: cast_nullable_to_non_nullable
as String,messageID: null == messageID ? _self.messageID : messageID // ignore: cast_nullable_to_non_nullable
as String,callID: null == callID ? _self.callID : callID // ignore: cast_nullable_to_non_nullable
as String,tool: null == tool ? _self.tool : tool // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as ToolState,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ToolStateCopyWith<$Res> get state {
  
  return $ToolStateCopyWith<$Res>(_self.state, (value) {
    return _then(_self.copyWith(state: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class StepStartPart implements MessagePart {
  const StepStartPart({required this.id, required this.sessionID, required this.messageID, this.snapshot, final  String? $type}): $type = $type ?? 'step-start';
  factory StepStartPart.fromJson(Map<String, dynamic> json) => _$StepStartPartFromJson(json);

@override final  String id;
@override final  String sessionID;
@override final  String messageID;
 final  String? snapshot;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StepStartPartCopyWith<StepStartPart> get copyWith => _$StepStartPartCopyWithImpl<StepStartPart>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StepStartPartToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StepStartPart&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionID, sessionID) || other.sessionID == sessionID)&&(identical(other.messageID, messageID) || other.messageID == messageID)&&(identical(other.snapshot, snapshot) || other.snapshot == snapshot));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sessionID,messageID,snapshot);

@override
String toString() {
  return 'MessagePart.stepStart(id: $id, sessionID: $sessionID, messageID: $messageID, snapshot: $snapshot)';
}


}

/// @nodoc
abstract mixin class $StepStartPartCopyWith<$Res> implements $MessagePartCopyWith<$Res> {
  factory $StepStartPartCopyWith(StepStartPart value, $Res Function(StepStartPart) _then) = _$StepStartPartCopyWithImpl;
@override @useResult
$Res call({
 String id, String sessionID, String messageID, String? snapshot
});




}
/// @nodoc
class _$StepStartPartCopyWithImpl<$Res>
    implements $StepStartPartCopyWith<$Res> {
  _$StepStartPartCopyWithImpl(this._self, this._then);

  final StepStartPart _self;
  final $Res Function(StepStartPart) _then;

/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sessionID = null,Object? messageID = null,Object? snapshot = freezed,}) {
  return _then(StepStartPart(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionID: null == sessionID ? _self.sessionID : sessionID // ignore: cast_nullable_to_non_nullable
as String,messageID: null == messageID ? _self.messageID : messageID // ignore: cast_nullable_to_non_nullable
as String,snapshot: freezed == snapshot ? _self.snapshot : snapshot // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class StepFinishPart implements MessagePart {
  const StepFinishPart({required this.id, required this.sessionID, required this.messageID, required this.reason, this.snapshot, required this.cost, required this.tokens, final  String? $type}): $type = $type ?? 'step-finish';
  factory StepFinishPart.fromJson(Map<String, dynamic> json) => _$StepFinishPartFromJson(json);

@override final  String id;
@override final  String sessionID;
@override final  String messageID;
 final  String reason;
 final  String? snapshot;
 final  double cost;
 final  Tokens tokens;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StepFinishPartCopyWith<StepFinishPart> get copyWith => _$StepFinishPartCopyWithImpl<StepFinishPart>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StepFinishPartToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StepFinishPart&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionID, sessionID) || other.sessionID == sessionID)&&(identical(other.messageID, messageID) || other.messageID == messageID)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.snapshot, snapshot) || other.snapshot == snapshot)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.tokens, tokens) || other.tokens == tokens));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sessionID,messageID,reason,snapshot,cost,tokens);

@override
String toString() {
  return 'MessagePart.stepFinish(id: $id, sessionID: $sessionID, messageID: $messageID, reason: $reason, snapshot: $snapshot, cost: $cost, tokens: $tokens)';
}


}

/// @nodoc
abstract mixin class $StepFinishPartCopyWith<$Res> implements $MessagePartCopyWith<$Res> {
  factory $StepFinishPartCopyWith(StepFinishPart value, $Res Function(StepFinishPart) _then) = _$StepFinishPartCopyWithImpl;
@override @useResult
$Res call({
 String id, String sessionID, String messageID, String reason, String? snapshot, double cost, Tokens tokens
});


$TokensCopyWith<$Res> get tokens;

}
/// @nodoc
class _$StepFinishPartCopyWithImpl<$Res>
    implements $StepFinishPartCopyWith<$Res> {
  _$StepFinishPartCopyWithImpl(this._self, this._then);

  final StepFinishPart _self;
  final $Res Function(StepFinishPart) _then;

/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sessionID = null,Object? messageID = null,Object? reason = null,Object? snapshot = freezed,Object? cost = null,Object? tokens = null,}) {
  return _then(StepFinishPart(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionID: null == sessionID ? _self.sessionID : sessionID // ignore: cast_nullable_to_non_nullable
as String,messageID: null == messageID ? _self.messageID : messageID // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,snapshot: freezed == snapshot ? _self.snapshot : snapshot // ignore: cast_nullable_to_non_nullable
as String?,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double,tokens: null == tokens ? _self.tokens : tokens // ignore: cast_nullable_to_non_nullable
as Tokens,
  ));
}

/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TokensCopyWith<$Res> get tokens {
  
  return $TokensCopyWith<$Res>(_self.tokens, (value) {
    return _then(_self.copyWith(tokens: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class FilePart implements MessagePart {
  const FilePart({required this.id, required this.sessionID, required this.messageID, required this.mime, this.filename, required this.url, this.source, final  String? $type}): $type = $type ?? 'file';
  factory FilePart.fromJson(Map<String, dynamic> json) => _$FilePartFromJson(json);

@override final  String id;
@override final  String sessionID;
@override final  String messageID;
 final  String mime;
 final  String? filename;
 final  String url;
 final  FilePartSource? source;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilePartCopyWith<FilePart> get copyWith => _$FilePartCopyWithImpl<FilePart>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FilePartToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilePart&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionID, sessionID) || other.sessionID == sessionID)&&(identical(other.messageID, messageID) || other.messageID == messageID)&&(identical(other.mime, mime) || other.mime == mime)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.url, url) || other.url == url)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sessionID,messageID,mime,filename,url,source);

@override
String toString() {
  return 'MessagePart.file(id: $id, sessionID: $sessionID, messageID: $messageID, mime: $mime, filename: $filename, url: $url, source: $source)';
}


}

/// @nodoc
abstract mixin class $FilePartCopyWith<$Res> implements $MessagePartCopyWith<$Res> {
  factory $FilePartCopyWith(FilePart value, $Res Function(FilePart) _then) = _$FilePartCopyWithImpl;
@override @useResult
$Res call({
 String id, String sessionID, String messageID, String mime, String? filename, String url, FilePartSource? source
});


$FilePartSourceCopyWith<$Res>? get source;

}
/// @nodoc
class _$FilePartCopyWithImpl<$Res>
    implements $FilePartCopyWith<$Res> {
  _$FilePartCopyWithImpl(this._self, this._then);

  final FilePart _self;
  final $Res Function(FilePart) _then;

/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sessionID = null,Object? messageID = null,Object? mime = null,Object? filename = freezed,Object? url = null,Object? source = freezed,}) {
  return _then(FilePart(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionID: null == sessionID ? _self.sessionID : sessionID // ignore: cast_nullable_to_non_nullable
as String,messageID: null == messageID ? _self.messageID : messageID // ignore: cast_nullable_to_non_nullable
as String,mime: null == mime ? _self.mime : mime // ignore: cast_nullable_to_non_nullable
as String,filename: freezed == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as FilePartSource?,
  ));
}

/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FilePartSourceCopyWith<$Res>? get source {
    if (_self.source == null) {
    return null;
  }

  return $FilePartSourceCopyWith<$Res>(_self.source!, (value) {
    return _then(_self.copyWith(source: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class SnapshotPart implements MessagePart {
  const SnapshotPart({required this.id, required this.sessionID, required this.messageID, required this.snapshot, final  String? $type}): $type = $type ?? 'snapshot';
  factory SnapshotPart.fromJson(Map<String, dynamic> json) => _$SnapshotPartFromJson(json);

@override final  String id;
@override final  String sessionID;
@override final  String messageID;
 final  String snapshot;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SnapshotPartCopyWith<SnapshotPart> get copyWith => _$SnapshotPartCopyWithImpl<SnapshotPart>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SnapshotPartToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SnapshotPart&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionID, sessionID) || other.sessionID == sessionID)&&(identical(other.messageID, messageID) || other.messageID == messageID)&&(identical(other.snapshot, snapshot) || other.snapshot == snapshot));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sessionID,messageID,snapshot);

@override
String toString() {
  return 'MessagePart.snapshot(id: $id, sessionID: $sessionID, messageID: $messageID, snapshot: $snapshot)';
}


}

/// @nodoc
abstract mixin class $SnapshotPartCopyWith<$Res> implements $MessagePartCopyWith<$Res> {
  factory $SnapshotPartCopyWith(SnapshotPart value, $Res Function(SnapshotPart) _then) = _$SnapshotPartCopyWithImpl;
@override @useResult
$Res call({
 String id, String sessionID, String messageID, String snapshot
});




}
/// @nodoc
class _$SnapshotPartCopyWithImpl<$Res>
    implements $SnapshotPartCopyWith<$Res> {
  _$SnapshotPartCopyWithImpl(this._self, this._then);

  final SnapshotPart _self;
  final $Res Function(SnapshotPart) _then;

/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sessionID = null,Object? messageID = null,Object? snapshot = null,}) {
  return _then(SnapshotPart(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionID: null == sessionID ? _self.sessionID : sessionID // ignore: cast_nullable_to_non_nullable
as String,messageID: null == messageID ? _self.messageID : messageID // ignore: cast_nullable_to_non_nullable
as String,snapshot: null == snapshot ? _self.snapshot : snapshot // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PatchPart implements MessagePart {
  const PatchPart({required this.id, required this.sessionID, required this.messageID, required this.hash, required final  List<String> files, final  String? $type}): _files = files,$type = $type ?? 'patch';
  factory PatchPart.fromJson(Map<String, dynamic> json) => _$PatchPartFromJson(json);

@override final  String id;
@override final  String sessionID;
@override final  String messageID;
 final  String hash;
 final  List<String> _files;
 List<String> get files {
  if (_files is EqualUnmodifiableListView) return _files;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_files);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatchPartCopyWith<PatchPart> get copyWith => _$PatchPartCopyWithImpl<PatchPart>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PatchPartToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatchPart&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionID, sessionID) || other.sessionID == sessionID)&&(identical(other.messageID, messageID) || other.messageID == messageID)&&(identical(other.hash, hash) || other.hash == hash)&&const DeepCollectionEquality().equals(other._files, _files));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sessionID,messageID,hash,const DeepCollectionEquality().hash(_files));

@override
String toString() {
  return 'MessagePart.patch(id: $id, sessionID: $sessionID, messageID: $messageID, hash: $hash, files: $files)';
}


}

/// @nodoc
abstract mixin class $PatchPartCopyWith<$Res> implements $MessagePartCopyWith<$Res> {
  factory $PatchPartCopyWith(PatchPart value, $Res Function(PatchPart) _then) = _$PatchPartCopyWithImpl;
@override @useResult
$Res call({
 String id, String sessionID, String messageID, String hash, List<String> files
});




}
/// @nodoc
class _$PatchPartCopyWithImpl<$Res>
    implements $PatchPartCopyWith<$Res> {
  _$PatchPartCopyWithImpl(this._self, this._then);

  final PatchPart _self;
  final $Res Function(PatchPart) _then;

/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sessionID = null,Object? messageID = null,Object? hash = null,Object? files = null,}) {
  return _then(PatchPart(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionID: null == sessionID ? _self.sessionID : sessionID // ignore: cast_nullable_to_non_nullable
as String,messageID: null == messageID ? _self.messageID : messageID // ignore: cast_nullable_to_non_nullable
as String,hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,files: null == files ? _self._files : files // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AgentPart implements MessagePart {
  const AgentPart({required this.id, required this.sessionID, required this.messageID, required this.name, this.source, final  String? $type}): $type = $type ?? 'agent';
  factory AgentPart.fromJson(Map<String, dynamic> json) => _$AgentPartFromJson(json);

@override final  String id;
@override final  String sessionID;
@override final  String messageID;
 final  String name;
 final  AgentPartSource? source;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgentPartCopyWith<AgentPart> get copyWith => _$AgentPartCopyWithImpl<AgentPart>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AgentPartToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgentPart&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionID, sessionID) || other.sessionID == sessionID)&&(identical(other.messageID, messageID) || other.messageID == messageID)&&(identical(other.name, name) || other.name == name)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sessionID,messageID,name,source);

@override
String toString() {
  return 'MessagePart.agent(id: $id, sessionID: $sessionID, messageID: $messageID, name: $name, source: $source)';
}


}

/// @nodoc
abstract mixin class $AgentPartCopyWith<$Res> implements $MessagePartCopyWith<$Res> {
  factory $AgentPartCopyWith(AgentPart value, $Res Function(AgentPart) _then) = _$AgentPartCopyWithImpl;
@override @useResult
$Res call({
 String id, String sessionID, String messageID, String name, AgentPartSource? source
});


$AgentPartSourceCopyWith<$Res>? get source;

}
/// @nodoc
class _$AgentPartCopyWithImpl<$Res>
    implements $AgentPartCopyWith<$Res> {
  _$AgentPartCopyWithImpl(this._self, this._then);

  final AgentPart _self;
  final $Res Function(AgentPart) _then;

/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sessionID = null,Object? messageID = null,Object? name = null,Object? source = freezed,}) {
  return _then(AgentPart(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionID: null == sessionID ? _self.sessionID : sessionID // ignore: cast_nullable_to_non_nullable
as String,messageID: null == messageID ? _self.messageID : messageID // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as AgentPartSource?,
  ));
}

/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AgentPartSourceCopyWith<$Res>? get source {
    if (_self.source == null) {
    return null;
  }

  return $AgentPartSourceCopyWith<$Res>(_self.source!, (value) {
    return _then(_self.copyWith(source: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class RetryPart implements MessagePart {
  const RetryPart({required this.id, required this.sessionID, required this.messageID, required this.attempt, required this.error, required this.time, final  String? $type}): $type = $type ?? 'retry';
  factory RetryPart.fromJson(Map<String, dynamic> json) => _$RetryPartFromJson(json);

@override final  String id;
@override final  String sessionID;
@override final  String messageID;
 final  int attempt;
 final  ApiError error;
 final  RetryTime time;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RetryPartCopyWith<RetryPart> get copyWith => _$RetryPartCopyWithImpl<RetryPart>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RetryPartToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RetryPart&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionID, sessionID) || other.sessionID == sessionID)&&(identical(other.messageID, messageID) || other.messageID == messageID)&&(identical(other.attempt, attempt) || other.attempt == attempt)&&(identical(other.error, error) || other.error == error)&&(identical(other.time, time) || other.time == time));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sessionID,messageID,attempt,error,time);

@override
String toString() {
  return 'MessagePart.retry(id: $id, sessionID: $sessionID, messageID: $messageID, attempt: $attempt, error: $error, time: $time)';
}


}

/// @nodoc
abstract mixin class $RetryPartCopyWith<$Res> implements $MessagePartCopyWith<$Res> {
  factory $RetryPartCopyWith(RetryPart value, $Res Function(RetryPart) _then) = _$RetryPartCopyWithImpl;
@override @useResult
$Res call({
 String id, String sessionID, String messageID, int attempt, ApiError error, RetryTime time
});


$ApiErrorCopyWith<$Res> get error;$RetryTimeCopyWith<$Res> get time;

}
/// @nodoc
class _$RetryPartCopyWithImpl<$Res>
    implements $RetryPartCopyWith<$Res> {
  _$RetryPartCopyWithImpl(this._self, this._then);

  final RetryPart _self;
  final $Res Function(RetryPart) _then;

/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sessionID = null,Object? messageID = null,Object? attempt = null,Object? error = null,Object? time = null,}) {
  return _then(RetryPart(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionID: null == sessionID ? _self.sessionID : sessionID // ignore: cast_nullable_to_non_nullable
as String,messageID: null == messageID ? _self.messageID : messageID // ignore: cast_nullable_to_non_nullable
as String,attempt: null == attempt ? _self.attempt : attempt // ignore: cast_nullable_to_non_nullable
as int,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiError,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as RetryTime,
  ));
}

/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiErrorCopyWith<$Res> get error {
  
  return $ApiErrorCopyWith<$Res>(_self.error, (value) {
    return _then(_self.copyWith(error: value));
  });
}/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RetryTimeCopyWith<$Res> get time {
  
  return $RetryTimeCopyWith<$Res>(_self.time, (value) {
    return _then(_self.copyWith(time: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class CompactionPart implements MessagePart {
  const CompactionPart({required this.id, required this.sessionID, required this.messageID, required this.auto, this.overflow, @JsonKey(name: 'tail_start_id') this.tailStartID, final  String? $type}): $type = $type ?? 'compaction';
  factory CompactionPart.fromJson(Map<String, dynamic> json) => _$CompactionPartFromJson(json);

@override final  String id;
@override final  String sessionID;
@override final  String messageID;
 final  bool auto;
 final  bool? overflow;
@JsonKey(name: 'tail_start_id') final  String? tailStartID;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompactionPartCopyWith<CompactionPart> get copyWith => _$CompactionPartCopyWithImpl<CompactionPart>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompactionPartToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompactionPart&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionID, sessionID) || other.sessionID == sessionID)&&(identical(other.messageID, messageID) || other.messageID == messageID)&&(identical(other.auto, auto) || other.auto == auto)&&(identical(other.overflow, overflow) || other.overflow == overflow)&&(identical(other.tailStartID, tailStartID) || other.tailStartID == tailStartID));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sessionID,messageID,auto,overflow,tailStartID);

@override
String toString() {
  return 'MessagePart.compaction(id: $id, sessionID: $sessionID, messageID: $messageID, auto: $auto, overflow: $overflow, tailStartID: $tailStartID)';
}


}

/// @nodoc
abstract mixin class $CompactionPartCopyWith<$Res> implements $MessagePartCopyWith<$Res> {
  factory $CompactionPartCopyWith(CompactionPart value, $Res Function(CompactionPart) _then) = _$CompactionPartCopyWithImpl;
@override @useResult
$Res call({
 String id, String sessionID, String messageID, bool auto, bool? overflow,@JsonKey(name: 'tail_start_id') String? tailStartID
});




}
/// @nodoc
class _$CompactionPartCopyWithImpl<$Res>
    implements $CompactionPartCopyWith<$Res> {
  _$CompactionPartCopyWithImpl(this._self, this._then);

  final CompactionPart _self;
  final $Res Function(CompactionPart) _then;

/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sessionID = null,Object? messageID = null,Object? auto = null,Object? overflow = freezed,Object? tailStartID = freezed,}) {
  return _then(CompactionPart(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionID: null == sessionID ? _self.sessionID : sessionID // ignore: cast_nullable_to_non_nullable
as String,messageID: null == messageID ? _self.messageID : messageID // ignore: cast_nullable_to_non_nullable
as String,auto: null == auto ? _self.auto : auto // ignore: cast_nullable_to_non_nullable
as bool,overflow: freezed == overflow ? _self.overflow : overflow // ignore: cast_nullable_to_non_nullable
as bool?,tailStartID: freezed == tailStartID ? _self.tailStartID : tailStartID // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SubtaskPart implements MessagePart {
  const SubtaskPart({required this.id, required this.sessionID, required this.messageID, required this.prompt, required this.description, required this.agent, this.model, this.command, final  String? $type}): $type = $type ?? 'subtask';
  factory SubtaskPart.fromJson(Map<String, dynamic> json) => _$SubtaskPartFromJson(json);

@override final  String id;
@override final  String sessionID;
@override final  String messageID;
 final  String prompt;
 final  String description;
 final  String agent;
 final  ModelRef? model;
 final  String? command;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubtaskPartCopyWith<SubtaskPart> get copyWith => _$SubtaskPartCopyWithImpl<SubtaskPart>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubtaskPartToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubtaskPart&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionID, sessionID) || other.sessionID == sessionID)&&(identical(other.messageID, messageID) || other.messageID == messageID)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&(identical(other.description, description) || other.description == description)&&(identical(other.agent, agent) || other.agent == agent)&&(identical(other.model, model) || other.model == model)&&(identical(other.command, command) || other.command == command));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sessionID,messageID,prompt,description,agent,model,command);

@override
String toString() {
  return 'MessagePart.subtask(id: $id, sessionID: $sessionID, messageID: $messageID, prompt: $prompt, description: $description, agent: $agent, model: $model, command: $command)';
}


}

/// @nodoc
abstract mixin class $SubtaskPartCopyWith<$Res> implements $MessagePartCopyWith<$Res> {
  factory $SubtaskPartCopyWith(SubtaskPart value, $Res Function(SubtaskPart) _then) = _$SubtaskPartCopyWithImpl;
@override @useResult
$Res call({
 String id, String sessionID, String messageID, String prompt, String description, String agent, ModelRef? model, String? command
});


$ModelRefCopyWith<$Res>? get model;

}
/// @nodoc
class _$SubtaskPartCopyWithImpl<$Res>
    implements $SubtaskPartCopyWith<$Res> {
  _$SubtaskPartCopyWithImpl(this._self, this._then);

  final SubtaskPart _self;
  final $Res Function(SubtaskPart) _then;

/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sessionID = null,Object? messageID = null,Object? prompt = null,Object? description = null,Object? agent = null,Object? model = freezed,Object? command = freezed,}) {
  return _then(SubtaskPart(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionID: null == sessionID ? _self.sessionID : sessionID // ignore: cast_nullable_to_non_nullable
as String,messageID: null == messageID ? _self.messageID : messageID // ignore: cast_nullable_to_non_nullable
as String,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,agent: null == agent ? _self.agent : agent // ignore: cast_nullable_to_non_nullable
as String,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as ModelRef?,command: freezed == command ? _self.command : command // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ModelRefCopyWith<$Res>? get model {
    if (_self.model == null) {
    return null;
  }

  return $ModelRefCopyWith<$Res>(_self.model!, (value) {
    return _then(_self.copyWith(model: value));
  });
}
}

// dart format on
