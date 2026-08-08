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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Map<String, dynamic> input,  String raw)?  pending,TResult Function( Map<String, dynamic> input,  String? title,  Map<String, dynamic>? metadata,  ToolTimeStart time)?  running,TResult Function( Map<String, dynamic> input,  String output,  String title,  Map<String, dynamic> metadata,  ToolTimeFull time)?  completed,TResult Function( Map<String, dynamic> input,  String error,  Map<String, dynamic>? metadata,  ToolTimeFull time)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ToolStatePending() when pending != null:
return pending(_that.input,_that.raw);case ToolStateRunning() when running != null:
return running(_that.input,_that.title,_that.metadata,_that.time);case ToolStateCompleted() when completed != null:
return completed(_that.input,_that.output,_that.title,_that.metadata,_that.time);case ToolStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Map<String, dynamic> input,  String raw)  pending,required TResult Function( Map<String, dynamic> input,  String? title,  Map<String, dynamic>? metadata,  ToolTimeStart time)  running,required TResult Function( Map<String, dynamic> input,  String output,  String title,  Map<String, dynamic> metadata,  ToolTimeFull time)  completed,required TResult Function( Map<String, dynamic> input,  String error,  Map<String, dynamic>? metadata,  ToolTimeFull time)  error,}) {final _that = this;
switch (_that) {
case ToolStatePending():
return pending(_that.input,_that.raw);case ToolStateRunning():
return running(_that.input,_that.title,_that.metadata,_that.time);case ToolStateCompleted():
return completed(_that.input,_that.output,_that.title,_that.metadata,_that.time);case ToolStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Map<String, dynamic> input,  String raw)?  pending,TResult? Function( Map<String, dynamic> input,  String? title,  Map<String, dynamic>? metadata,  ToolTimeStart time)?  running,TResult? Function( Map<String, dynamic> input,  String output,  String title,  Map<String, dynamic> metadata,  ToolTimeFull time)?  completed,TResult? Function( Map<String, dynamic> input,  String error,  Map<String, dynamic>? metadata,  ToolTimeFull time)?  error,}) {final _that = this;
switch (_that) {
case ToolStatePending() when pending != null:
return pending(_that.input,_that.raw);case ToolStateRunning() when running != null:
return running(_that.input,_that.title,_that.metadata,_that.time);case ToolStateCompleted() when completed != null:
return completed(_that.input,_that.output,_that.title,_that.metadata,_that.time);case ToolStateError() when error != null:
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
  const ToolStateCompleted({required final  Map<String, dynamic> input, required this.output, required this.title, required final  Map<String, dynamic> metadata, required this.time, final  String? $type}): _input = input,_metadata = metadata,$type = $type ?? 'completed';
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToolStateCompleted&&const DeepCollectionEquality().equals(other._input, _input)&&(identical(other.output, output) || other.output == output)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.time, time) || other.time == time));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_input),output,title,const DeepCollectionEquality().hash(_metadata),time);

@override
String toString() {
  return 'ToolState.completed(input: $input, output: $output, title: $title, metadata: $metadata, time: $time)';
}


}

/// @nodoc
abstract mixin class $ToolStateCompletedCopyWith<$Res> implements $ToolStateCopyWith<$Res> {
  factory $ToolStateCompletedCopyWith(ToolStateCompleted value, $Res Function(ToolStateCompleted) _then) = _$ToolStateCompletedCopyWithImpl;
@override @useResult
$Res call({
 Map<String, dynamic> input, String output, String title, Map<String, dynamic> metadata, ToolTimeFull time
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
@override @pragma('vm:prefer-inline') $Res call({Object? input = null,Object? output = null,Object? title = null,Object? metadata = null,Object? time = null,}) {
  return _then(ToolStateCompleted(
input: null == input ? _self._input : input // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,output: null == output ? _self.output : output // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
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
        
          default:
            return OtherPart.fromJson(
  json
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TextPart value)?  text,TResult Function( ReasoningPart value)?  reasoning,TResult Function( ToolPart value)?  tool,TResult Function( StepStartPart value)?  stepStart,TResult Function( StepFinishPart value)?  stepFinish,TResult Function( OtherPart value)?  other,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TextPart() when text != null:
return text(_that);case ReasoningPart() when reasoning != null:
return reasoning(_that);case ToolPart() when tool != null:
return tool(_that);case StepStartPart() when stepStart != null:
return stepStart(_that);case StepFinishPart() when stepFinish != null:
return stepFinish(_that);case OtherPart() when other != null:
return other(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TextPart value)  text,required TResult Function( ReasoningPart value)  reasoning,required TResult Function( ToolPart value)  tool,required TResult Function( StepStartPart value)  stepStart,required TResult Function( StepFinishPart value)  stepFinish,required TResult Function( OtherPart value)  other,}){
final _that = this;
switch (_that) {
case TextPart():
return text(_that);case ReasoningPart():
return reasoning(_that);case ToolPart():
return tool(_that);case StepStartPart():
return stepStart(_that);case StepFinishPart():
return stepFinish(_that);case OtherPart():
return other(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TextPart value)?  text,TResult? Function( ReasoningPart value)?  reasoning,TResult? Function( ToolPart value)?  tool,TResult? Function( StepStartPart value)?  stepStart,TResult? Function( StepFinishPart value)?  stepFinish,TResult? Function( OtherPart value)?  other,}){
final _that = this;
switch (_that) {
case TextPart() when text != null:
return text(_that);case ReasoningPart() when reasoning != null:
return reasoning(_that);case ToolPart() when tool != null:
return tool(_that);case StepStartPart() when stepStart != null:
return stepStart(_that);case StepFinishPart() when stepFinish != null:
return stepFinish(_that);case OtherPart() when other != null:
return other(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String id,  String sessionID,  String messageID,  String text,  bool? synthetic,  bool? ignored,  PartTime? time,  Map<String, dynamic>? metadata)?  text,TResult Function( String id,  String sessionID,  String messageID,  String text,  Map<String, dynamic>? metadata,  PartTime time)?  reasoning,TResult Function( String id,  String sessionID,  String messageID,  String callID,  String tool,  ToolState state,  Map<String, dynamic>? metadata)?  tool,TResult Function( String id,  String sessionID,  String messageID,  String? snapshot)?  stepStart,TResult Function( String id,  String sessionID,  String messageID,  String reason,  String? snapshot,  double cost,  Tokens tokens)?  stepFinish,TResult Function( String id,  String sessionID,  String messageID,  String type)?  other,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TextPart() when text != null:
return text(_that.id,_that.sessionID,_that.messageID,_that.text,_that.synthetic,_that.ignored,_that.time,_that.metadata);case ReasoningPart() when reasoning != null:
return reasoning(_that.id,_that.sessionID,_that.messageID,_that.text,_that.metadata,_that.time);case ToolPart() when tool != null:
return tool(_that.id,_that.sessionID,_that.messageID,_that.callID,_that.tool,_that.state,_that.metadata);case StepStartPart() when stepStart != null:
return stepStart(_that.id,_that.sessionID,_that.messageID,_that.snapshot);case StepFinishPart() when stepFinish != null:
return stepFinish(_that.id,_that.sessionID,_that.messageID,_that.reason,_that.snapshot,_that.cost,_that.tokens);case OtherPart() when other != null:
return other(_that.id,_that.sessionID,_that.messageID,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String id,  String sessionID,  String messageID,  String text,  bool? synthetic,  bool? ignored,  PartTime? time,  Map<String, dynamic>? metadata)  text,required TResult Function( String id,  String sessionID,  String messageID,  String text,  Map<String, dynamic>? metadata,  PartTime time)  reasoning,required TResult Function( String id,  String sessionID,  String messageID,  String callID,  String tool,  ToolState state,  Map<String, dynamic>? metadata)  tool,required TResult Function( String id,  String sessionID,  String messageID,  String? snapshot)  stepStart,required TResult Function( String id,  String sessionID,  String messageID,  String reason,  String? snapshot,  double cost,  Tokens tokens)  stepFinish,required TResult Function( String id,  String sessionID,  String messageID,  String type)  other,}) {final _that = this;
switch (_that) {
case TextPart():
return text(_that.id,_that.sessionID,_that.messageID,_that.text,_that.synthetic,_that.ignored,_that.time,_that.metadata);case ReasoningPart():
return reasoning(_that.id,_that.sessionID,_that.messageID,_that.text,_that.metadata,_that.time);case ToolPart():
return tool(_that.id,_that.sessionID,_that.messageID,_that.callID,_that.tool,_that.state,_that.metadata);case StepStartPart():
return stepStart(_that.id,_that.sessionID,_that.messageID,_that.snapshot);case StepFinishPart():
return stepFinish(_that.id,_that.sessionID,_that.messageID,_that.reason,_that.snapshot,_that.cost,_that.tokens);case OtherPart():
return other(_that.id,_that.sessionID,_that.messageID,_that.type);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String id,  String sessionID,  String messageID,  String text,  bool? synthetic,  bool? ignored,  PartTime? time,  Map<String, dynamic>? metadata)?  text,TResult? Function( String id,  String sessionID,  String messageID,  String text,  Map<String, dynamic>? metadata,  PartTime time)?  reasoning,TResult? Function( String id,  String sessionID,  String messageID,  String callID,  String tool,  ToolState state,  Map<String, dynamic>? metadata)?  tool,TResult? Function( String id,  String sessionID,  String messageID,  String? snapshot)?  stepStart,TResult? Function( String id,  String sessionID,  String messageID,  String reason,  String? snapshot,  double cost,  Tokens tokens)?  stepFinish,TResult? Function( String id,  String sessionID,  String messageID,  String type)?  other,}) {final _that = this;
switch (_that) {
case TextPart() when text != null:
return text(_that.id,_that.sessionID,_that.messageID,_that.text,_that.synthetic,_that.ignored,_that.time,_that.metadata);case ReasoningPart() when reasoning != null:
return reasoning(_that.id,_that.sessionID,_that.messageID,_that.text,_that.metadata,_that.time);case ToolPart() when tool != null:
return tool(_that.id,_that.sessionID,_that.messageID,_that.callID,_that.tool,_that.state,_that.metadata);case StepStartPart() when stepStart != null:
return stepStart(_that.id,_that.sessionID,_that.messageID,_that.snapshot);case StepFinishPart() when stepFinish != null:
return stepFinish(_that.id,_that.sessionID,_that.messageID,_that.reason,_that.snapshot,_that.cost,_that.tokens);case OtherPart() when other != null:
return other(_that.id,_that.sessionID,_that.messageID,_that.type);case _:
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

class OtherPart implements MessagePart {
  const OtherPart({required this.id, required this.sessionID, required this.messageID, required this.type});
  factory OtherPart.fromJson(Map<String, dynamic> json) => _$OtherPartFromJson(json);

@override final  String id;
@override final  String sessionID;
@override final  String messageID;
 final  String type;

/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtherPartCopyWith<OtherPart> get copyWith => _$OtherPartCopyWithImpl<OtherPart>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OtherPartToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtherPart&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionID, sessionID) || other.sessionID == sessionID)&&(identical(other.messageID, messageID) || other.messageID == messageID)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sessionID,messageID,type);

@override
String toString() {
  return 'MessagePart.other(id: $id, sessionID: $sessionID, messageID: $messageID, type: $type)';
}


}

/// @nodoc
abstract mixin class $OtherPartCopyWith<$Res> implements $MessagePartCopyWith<$Res> {
  factory $OtherPartCopyWith(OtherPart value, $Res Function(OtherPart) _then) = _$OtherPartCopyWithImpl;
@override @useResult
$Res call({
 String id, String sessionID, String messageID, String type
});




}
/// @nodoc
class _$OtherPartCopyWithImpl<$Res>
    implements $OtherPartCopyWith<$Res> {
  _$OtherPartCopyWithImpl(this._self, this._then);

  final OtherPart _self;
  final $Res Function(OtherPart) _then;

/// Create a copy of MessagePart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sessionID = null,Object? messageID = null,Object? type = null,}) {
  return _then(OtherPart(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionID: null == sessionID ? _self.sessionID : sessionID // ignore: cast_nullable_to_non_nullable
as String,messageID: null == messageID ? _self.messageID : messageID // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
