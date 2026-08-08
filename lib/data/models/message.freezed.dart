// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserTime {

 int get created;
/// Create a copy of UserTime
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserTimeCopyWith<UserTime> get copyWith => _$UserTimeCopyWithImpl<UserTime>(this as UserTime, _$identity);

  /// Serializes this UserTime to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserTime&&(identical(other.created, created) || other.created == created));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,created);

@override
String toString() {
  return 'UserTime(created: $created)';
}


}

/// @nodoc
abstract mixin class $UserTimeCopyWith<$Res>  {
  factory $UserTimeCopyWith(UserTime value, $Res Function(UserTime) _then) = _$UserTimeCopyWithImpl;
@useResult
$Res call({
 int created
});




}
/// @nodoc
class _$UserTimeCopyWithImpl<$Res>
    implements $UserTimeCopyWith<$Res> {
  _$UserTimeCopyWithImpl(this._self, this._then);

  final UserTime _self;
  final $Res Function(UserTime) _then;

/// Create a copy of UserTime
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? created = null,}) {
  return _then(_self.copyWith(
created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UserTime].
extension UserTimePatterns on UserTime {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserTime value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserTime() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserTime value)  $default,){
final _that = this;
switch (_that) {
case _UserTime():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserTime value)?  $default,){
final _that = this;
switch (_that) {
case _UserTime() when $default != null:
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
case _UserTime() when $default != null:
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
case _UserTime():
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
case _UserTime() when $default != null:
return $default(_that.created);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserTime implements UserTime {
  const _UserTime({required this.created});
  factory _UserTime.fromJson(Map<String, dynamic> json) => _$UserTimeFromJson(json);

@override final  int created;

/// Create a copy of UserTime
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserTimeCopyWith<_UserTime> get copyWith => __$UserTimeCopyWithImpl<_UserTime>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserTimeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserTime&&(identical(other.created, created) || other.created == created));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,created);

@override
String toString() {
  return 'UserTime(created: $created)';
}


}

/// @nodoc
abstract mixin class _$UserTimeCopyWith<$Res> implements $UserTimeCopyWith<$Res> {
  factory _$UserTimeCopyWith(_UserTime value, $Res Function(_UserTime) _then) = __$UserTimeCopyWithImpl;
@override @useResult
$Res call({
 int created
});




}
/// @nodoc
class __$UserTimeCopyWithImpl<$Res>
    implements _$UserTimeCopyWith<$Res> {
  __$UserTimeCopyWithImpl(this._self, this._then);

  final _UserTime _self;
  final $Res Function(_UserTime) _then;

/// Create a copy of UserTime
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? created = null,}) {
  return _then(_UserTime(
created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$AssistantTime {

 int get created; int? get completed;
/// Create a copy of AssistantTime
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssistantTimeCopyWith<AssistantTime> get copyWith => _$AssistantTimeCopyWithImpl<AssistantTime>(this as AssistantTime, _$identity);

  /// Serializes this AssistantTime to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssistantTime&&(identical(other.created, created) || other.created == created)&&(identical(other.completed, completed) || other.completed == completed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,created,completed);

@override
String toString() {
  return 'AssistantTime(created: $created, completed: $completed)';
}


}

/// @nodoc
abstract mixin class $AssistantTimeCopyWith<$Res>  {
  factory $AssistantTimeCopyWith(AssistantTime value, $Res Function(AssistantTime) _then) = _$AssistantTimeCopyWithImpl;
@useResult
$Res call({
 int created, int? completed
});




}
/// @nodoc
class _$AssistantTimeCopyWithImpl<$Res>
    implements $AssistantTimeCopyWith<$Res> {
  _$AssistantTimeCopyWithImpl(this._self, this._then);

  final AssistantTime _self;
  final $Res Function(AssistantTime) _then;

/// Create a copy of AssistantTime
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? created = null,Object? completed = freezed,}) {
  return _then(_self.copyWith(
created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as int,completed: freezed == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [AssistantTime].
extension AssistantTimePatterns on AssistantTime {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssistantTime value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssistantTime() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssistantTime value)  $default,){
final _that = this;
switch (_that) {
case _AssistantTime():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssistantTime value)?  $default,){
final _that = this;
switch (_that) {
case _AssistantTime() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int created,  int? completed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssistantTime() when $default != null:
return $default(_that.created,_that.completed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int created,  int? completed)  $default,) {final _that = this;
switch (_that) {
case _AssistantTime():
return $default(_that.created,_that.completed);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int created,  int? completed)?  $default,) {final _that = this;
switch (_that) {
case _AssistantTime() when $default != null:
return $default(_that.created,_that.completed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssistantTime implements AssistantTime {
  const _AssistantTime({required this.created, this.completed});
  factory _AssistantTime.fromJson(Map<String, dynamic> json) => _$AssistantTimeFromJson(json);

@override final  int created;
@override final  int? completed;

/// Create a copy of AssistantTime
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssistantTimeCopyWith<_AssistantTime> get copyWith => __$AssistantTimeCopyWithImpl<_AssistantTime>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssistantTimeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssistantTime&&(identical(other.created, created) || other.created == created)&&(identical(other.completed, completed) || other.completed == completed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,created,completed);

@override
String toString() {
  return 'AssistantTime(created: $created, completed: $completed)';
}


}

/// @nodoc
abstract mixin class _$AssistantTimeCopyWith<$Res> implements $AssistantTimeCopyWith<$Res> {
  factory _$AssistantTimeCopyWith(_AssistantTime value, $Res Function(_AssistantTime) _then) = __$AssistantTimeCopyWithImpl;
@override @useResult
$Res call({
 int created, int? completed
});




}
/// @nodoc
class __$AssistantTimeCopyWithImpl<$Res>
    implements _$AssistantTimeCopyWith<$Res> {
  __$AssistantTimeCopyWithImpl(this._self, this._then);

  final _AssistantTime _self;
  final $Res Function(_AssistantTime) _then;

/// Create a copy of AssistantTime
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? created = null,Object? completed = freezed,}) {
  return _then(_AssistantTime(
created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as int,completed: freezed == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$MessagePath {

 String get cwd; String get root;
/// Create a copy of MessagePath
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessagePathCopyWith<MessagePath> get copyWith => _$MessagePathCopyWithImpl<MessagePath>(this as MessagePath, _$identity);

  /// Serializes this MessagePath to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessagePath&&(identical(other.cwd, cwd) || other.cwd == cwd)&&(identical(other.root, root) || other.root == root));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cwd,root);

@override
String toString() {
  return 'MessagePath(cwd: $cwd, root: $root)';
}


}

/// @nodoc
abstract mixin class $MessagePathCopyWith<$Res>  {
  factory $MessagePathCopyWith(MessagePath value, $Res Function(MessagePath) _then) = _$MessagePathCopyWithImpl;
@useResult
$Res call({
 String cwd, String root
});




}
/// @nodoc
class _$MessagePathCopyWithImpl<$Res>
    implements $MessagePathCopyWith<$Res> {
  _$MessagePathCopyWithImpl(this._self, this._then);

  final MessagePath _self;
  final $Res Function(MessagePath) _then;

/// Create a copy of MessagePath
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cwd = null,Object? root = null,}) {
  return _then(_self.copyWith(
cwd: null == cwd ? _self.cwd : cwd // ignore: cast_nullable_to_non_nullable
as String,root: null == root ? _self.root : root // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MessagePath].
extension MessagePathPatterns on MessagePath {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessagePath value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessagePath() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessagePath value)  $default,){
final _that = this;
switch (_that) {
case _MessagePath():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessagePath value)?  $default,){
final _that = this;
switch (_that) {
case _MessagePath() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String cwd,  String root)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessagePath() when $default != null:
return $default(_that.cwd,_that.root);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String cwd,  String root)  $default,) {final _that = this;
switch (_that) {
case _MessagePath():
return $default(_that.cwd,_that.root);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String cwd,  String root)?  $default,) {final _that = this;
switch (_that) {
case _MessagePath() when $default != null:
return $default(_that.cwd,_that.root);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessagePath implements MessagePath {
  const _MessagePath({required this.cwd, required this.root});
  factory _MessagePath.fromJson(Map<String, dynamic> json) => _$MessagePathFromJson(json);

@override final  String cwd;
@override final  String root;

/// Create a copy of MessagePath
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessagePathCopyWith<_MessagePath> get copyWith => __$MessagePathCopyWithImpl<_MessagePath>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessagePathToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessagePath&&(identical(other.cwd, cwd) || other.cwd == cwd)&&(identical(other.root, root) || other.root == root));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cwd,root);

@override
String toString() {
  return 'MessagePath(cwd: $cwd, root: $root)';
}


}

/// @nodoc
abstract mixin class _$MessagePathCopyWith<$Res> implements $MessagePathCopyWith<$Res> {
  factory _$MessagePathCopyWith(_MessagePath value, $Res Function(_MessagePath) _then) = __$MessagePathCopyWithImpl;
@override @useResult
$Res call({
 String cwd, String root
});




}
/// @nodoc
class __$MessagePathCopyWithImpl<$Res>
    implements _$MessagePathCopyWith<$Res> {
  __$MessagePathCopyWithImpl(this._self, this._then);

  final _MessagePath _self;
  final $Res Function(_MessagePath) _then;

/// Create a copy of MessagePath
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cwd = null,Object? root = null,}) {
  return _then(_MessagePath(
cwd: null == cwd ? _self.cwd : cwd // ignore: cast_nullable_to_non_nullable
as String,root: null == root ? _self.root : root // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MessageSummary {

 String? get title; String? get body; List<dynamic> get diffs;
/// Create a copy of MessageSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageSummaryCopyWith<MessageSummary> get copyWith => _$MessageSummaryCopyWithImpl<MessageSummary>(this as MessageSummary, _$identity);

  /// Serializes this MessageSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageSummary&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&const DeepCollectionEquality().equals(other.diffs, diffs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,body,const DeepCollectionEquality().hash(diffs));

@override
String toString() {
  return 'MessageSummary(title: $title, body: $body, diffs: $diffs)';
}


}

/// @nodoc
abstract mixin class $MessageSummaryCopyWith<$Res>  {
  factory $MessageSummaryCopyWith(MessageSummary value, $Res Function(MessageSummary) _then) = _$MessageSummaryCopyWithImpl;
@useResult
$Res call({
 String? title, String? body, List<dynamic> diffs
});




}
/// @nodoc
class _$MessageSummaryCopyWithImpl<$Res>
    implements $MessageSummaryCopyWith<$Res> {
  _$MessageSummaryCopyWithImpl(this._self, this._then);

  final MessageSummary _self;
  final $Res Function(MessageSummary) _then;

/// Create a copy of MessageSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? body = freezed,Object? diffs = null,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,diffs: null == diffs ? _self.diffs : diffs // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageSummary].
extension MessageSummaryPatterns on MessageSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageSummary value)  $default,){
final _that = this;
switch (_that) {
case _MessageSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageSummary value)?  $default,){
final _that = this;
switch (_that) {
case _MessageSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? title,  String? body,  List<dynamic> diffs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageSummary() when $default != null:
return $default(_that.title,_that.body,_that.diffs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? title,  String? body,  List<dynamic> diffs)  $default,) {final _that = this;
switch (_that) {
case _MessageSummary():
return $default(_that.title,_that.body,_that.diffs);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? title,  String? body,  List<dynamic> diffs)?  $default,) {final _that = this;
switch (_that) {
case _MessageSummary() when $default != null:
return $default(_that.title,_that.body,_that.diffs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessageSummary implements MessageSummary {
  const _MessageSummary({this.title, this.body, required final  List<dynamic> diffs}): _diffs = diffs;
  factory _MessageSummary.fromJson(Map<String, dynamic> json) => _$MessageSummaryFromJson(json);

@override final  String? title;
@override final  String? body;
 final  List<dynamic> _diffs;
@override List<dynamic> get diffs {
  if (_diffs is EqualUnmodifiableListView) return _diffs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_diffs);
}


/// Create a copy of MessageSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageSummaryCopyWith<_MessageSummary> get copyWith => __$MessageSummaryCopyWithImpl<_MessageSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageSummary&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&const DeepCollectionEquality().equals(other._diffs, _diffs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,body,const DeepCollectionEquality().hash(_diffs));

@override
String toString() {
  return 'MessageSummary(title: $title, body: $body, diffs: $diffs)';
}


}

/// @nodoc
abstract mixin class _$MessageSummaryCopyWith<$Res> implements $MessageSummaryCopyWith<$Res> {
  factory _$MessageSummaryCopyWith(_MessageSummary value, $Res Function(_MessageSummary) _then) = __$MessageSummaryCopyWithImpl;
@override @useResult
$Res call({
 String? title, String? body, List<dynamic> diffs
});




}
/// @nodoc
class __$MessageSummaryCopyWithImpl<$Res>
    implements _$MessageSummaryCopyWith<$Res> {
  __$MessageSummaryCopyWithImpl(this._self, this._then);

  final _MessageSummary _self;
  final $Res Function(_MessageSummary) _then;

/// Create a copy of MessageSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? body = freezed,Object? diffs = null,}) {
  return _then(_MessageSummary(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,diffs: null == diffs ? _self._diffs : diffs // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}


}


/// @nodoc
mixin _$MessageError {

 String get name; Map<String, dynamic>? get data;
/// Create a copy of MessageError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageErrorCopyWith<MessageError> get copyWith => _$MessageErrorCopyWithImpl<MessageError>(this as MessageError, _$identity);

  /// Serializes this MessageError to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageError&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'MessageError(name: $name, data: $data)';
}


}

/// @nodoc
abstract mixin class $MessageErrorCopyWith<$Res>  {
  factory $MessageErrorCopyWith(MessageError value, $Res Function(MessageError) _then) = _$MessageErrorCopyWithImpl;
@useResult
$Res call({
 String name, Map<String, dynamic>? data
});




}
/// @nodoc
class _$MessageErrorCopyWithImpl<$Res>
    implements $MessageErrorCopyWith<$Res> {
  _$MessageErrorCopyWithImpl(this._self, this._then);

  final MessageError _self;
  final $Res Function(MessageError) _then;

/// Create a copy of MessageError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? data = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageError].
extension MessageErrorPatterns on MessageError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageError value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageError() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageError value)  $default,){
final _that = this;
switch (_that) {
case _MessageError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageError value)?  $default,){
final _that = this;
switch (_that) {
case _MessageError() when $default != null:
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
case _MessageError() when $default != null:
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
case _MessageError():
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
case _MessageError() when $default != null:
return $default(_that.name,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessageError extends MessageError {
  const _MessageError({required this.name, final  Map<String, dynamic>? data}): _data = data,super._();
  factory _MessageError.fromJson(Map<String, dynamic> json) => _$MessageErrorFromJson(json);

@override final  String name;
 final  Map<String, dynamic>? _data;
@override Map<String, dynamic>? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of MessageError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageErrorCopyWith<_MessageError> get copyWith => __$MessageErrorCopyWithImpl<_MessageError>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageErrorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageError&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'MessageError(name: $name, data: $data)';
}


}

/// @nodoc
abstract mixin class _$MessageErrorCopyWith<$Res> implements $MessageErrorCopyWith<$Res> {
  factory _$MessageErrorCopyWith(_MessageError value, $Res Function(_MessageError) _then) = __$MessageErrorCopyWithImpl;
@override @useResult
$Res call({
 String name, Map<String, dynamic>? data
});




}
/// @nodoc
class __$MessageErrorCopyWithImpl<$Res>
    implements _$MessageErrorCopyWith<$Res> {
  __$MessageErrorCopyWithImpl(this._self, this._then);

  final _MessageError _self;
  final $Res Function(_MessageError) _then;

/// Create a copy of MessageError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? data = freezed,}) {
  return _then(_MessageError(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

OutputFormat _$OutputFormatFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'text':
          return OutputFormatText.fromJson(
            json
          );
                case 'json_schema':
          return OutputFormatJsonSchema.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'OutputFormat',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$OutputFormat {



  /// Serializes this OutputFormat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutputFormat);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OutputFormat()';
}


}

/// @nodoc
class $OutputFormatCopyWith<$Res>  {
$OutputFormatCopyWith(OutputFormat _, $Res Function(OutputFormat) __);
}


/// Adds pattern-matching-related methods to [OutputFormat].
extension OutputFormatPatterns on OutputFormat {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OutputFormatText value)?  text,TResult Function( OutputFormatJsonSchema value)?  jsonSchema,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OutputFormatText() when text != null:
return text(_that);case OutputFormatJsonSchema() when jsonSchema != null:
return jsonSchema(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OutputFormatText value)  text,required TResult Function( OutputFormatJsonSchema value)  jsonSchema,}){
final _that = this;
switch (_that) {
case OutputFormatText():
return text(_that);case OutputFormatJsonSchema():
return jsonSchema(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OutputFormatText value)?  text,TResult? Function( OutputFormatJsonSchema value)?  jsonSchema,}){
final _that = this;
switch (_that) {
case OutputFormatText() when text != null:
return text(_that);case OutputFormatJsonSchema() when jsonSchema != null:
return jsonSchema(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  text,TResult Function( Map<String, dynamic> schema,  int retryCount)?  jsonSchema,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OutputFormatText() when text != null:
return text();case OutputFormatJsonSchema() when jsonSchema != null:
return jsonSchema(_that.schema,_that.retryCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  text,required TResult Function( Map<String, dynamic> schema,  int retryCount)  jsonSchema,}) {final _that = this;
switch (_that) {
case OutputFormatText():
return text();case OutputFormatJsonSchema():
return jsonSchema(_that.schema,_that.retryCount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  text,TResult? Function( Map<String, dynamic> schema,  int retryCount)?  jsonSchema,}) {final _that = this;
switch (_that) {
case OutputFormatText() when text != null:
return text();case OutputFormatJsonSchema() when jsonSchema != null:
return jsonSchema(_that.schema,_that.retryCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class OutputFormatText implements OutputFormat {
  const OutputFormatText({final  String? $type}): $type = $type ?? 'text';
  factory OutputFormatText.fromJson(Map<String, dynamic> json) => _$OutputFormatTextFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$OutputFormatTextToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutputFormatText);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OutputFormat.text()';
}


}




/// @nodoc
@JsonSerializable()

class OutputFormatJsonSchema implements OutputFormat {
  const OutputFormatJsonSchema({required final  Map<String, dynamic> schema, required this.retryCount, final  String? $type}): _schema = schema,$type = $type ?? 'json_schema';
  factory OutputFormatJsonSchema.fromJson(Map<String, dynamic> json) => _$OutputFormatJsonSchemaFromJson(json);

 final  Map<String, dynamic> _schema;
 Map<String, dynamic> get schema {
  if (_schema is EqualUnmodifiableMapView) return _schema;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_schema);
}

 final  int retryCount;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of OutputFormat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OutputFormatJsonSchemaCopyWith<OutputFormatJsonSchema> get copyWith => _$OutputFormatJsonSchemaCopyWithImpl<OutputFormatJsonSchema>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OutputFormatJsonSchemaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutputFormatJsonSchema&&const DeepCollectionEquality().equals(other._schema, _schema)&&(identical(other.retryCount, retryCount) || other.retryCount == retryCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_schema),retryCount);

@override
String toString() {
  return 'OutputFormat.jsonSchema(schema: $schema, retryCount: $retryCount)';
}


}

/// @nodoc
abstract mixin class $OutputFormatJsonSchemaCopyWith<$Res> implements $OutputFormatCopyWith<$Res> {
  factory $OutputFormatJsonSchemaCopyWith(OutputFormatJsonSchema value, $Res Function(OutputFormatJsonSchema) _then) = _$OutputFormatJsonSchemaCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> schema, int retryCount
});




}
/// @nodoc
class _$OutputFormatJsonSchemaCopyWithImpl<$Res>
    implements $OutputFormatJsonSchemaCopyWith<$Res> {
  _$OutputFormatJsonSchemaCopyWithImpl(this._self, this._then);

  final OutputFormatJsonSchema _self;
  final $Res Function(OutputFormatJsonSchema) _then;

/// Create a copy of OutputFormat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? schema = null,Object? retryCount = null,}) {
  return _then(OutputFormatJsonSchema(
schema: null == schema ? _self._schema : schema // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,retryCount: null == retryCount ? _self.retryCount : retryCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

Message _$MessageFromJson(
  Map<String, dynamic> json
) {
        switch (json['role']) {
                  case 'user':
          return UserMessage.fromJson(
            json
          );
                case 'assistant':
          return AssistantMessage.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'role',
  'Message',
  'Invalid union type "${json['role']}"!'
);
        }
      
}

/// @nodoc
mixin _$Message {

 String get id; String get sessionID; Object get time; String get agent;
/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageCopyWith<Message> get copyWith => _$MessageCopyWithImpl<Message>(this as Message, _$identity);

  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Message&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionID, sessionID) || other.sessionID == sessionID)&&const DeepCollectionEquality().equals(other.time, time)&&(identical(other.agent, agent) || other.agent == agent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sessionID,const DeepCollectionEquality().hash(time),agent);

@override
String toString() {
  return 'Message(id: $id, sessionID: $sessionID, time: $time, agent: $agent)';
}


}

/// @nodoc
abstract mixin class $MessageCopyWith<$Res>  {
  factory $MessageCopyWith(Message value, $Res Function(Message) _then) = _$MessageCopyWithImpl;
@useResult
$Res call({
 String id, String sessionID, String agent
});




}
/// @nodoc
class _$MessageCopyWithImpl<$Res>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._self, this._then);

  final Message _self;
  final $Res Function(Message) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sessionID = null,Object? agent = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionID: null == sessionID ? _self.sessionID : sessionID // ignore: cast_nullable_to_non_nullable
as String,agent: null == agent ? _self.agent : agent // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Message].
extension MessagePatterns on Message {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UserMessage value)?  user,TResult Function( AssistantMessage value)?  assistant,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UserMessage() when user != null:
return user(_that);case AssistantMessage() when assistant != null:
return assistant(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UserMessage value)  user,required TResult Function( AssistantMessage value)  assistant,}){
final _that = this;
switch (_that) {
case UserMessage():
return user(_that);case AssistantMessage():
return assistant(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UserMessage value)?  user,TResult? Function( AssistantMessage value)?  assistant,}){
final _that = this;
switch (_that) {
case UserMessage() when user != null:
return user(_that);case AssistantMessage() when assistant != null:
return assistant(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String id,  String sessionID,  UserTime time,  String agent,  ModelRef model,  OutputFormat? format,  MessageSummary? summary,  String? system,  Map<String, bool>? tools)?  user,TResult Function( String id,  String sessionID,  AssistantTime time,  String parentID,  String modelID,  String providerID,  String mode,  String agent,  MessagePath path,  double cost,  Tokens tokens,  MessageError? error,  String? finish,  String? variant,  dynamic structured)?  assistant,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UserMessage() when user != null:
return user(_that.id,_that.sessionID,_that.time,_that.agent,_that.model,_that.format,_that.summary,_that.system,_that.tools);case AssistantMessage() when assistant != null:
return assistant(_that.id,_that.sessionID,_that.time,_that.parentID,_that.modelID,_that.providerID,_that.mode,_that.agent,_that.path,_that.cost,_that.tokens,_that.error,_that.finish,_that.variant,_that.structured);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String id,  String sessionID,  UserTime time,  String agent,  ModelRef model,  OutputFormat? format,  MessageSummary? summary,  String? system,  Map<String, bool>? tools)  user,required TResult Function( String id,  String sessionID,  AssistantTime time,  String parentID,  String modelID,  String providerID,  String mode,  String agent,  MessagePath path,  double cost,  Tokens tokens,  MessageError? error,  String? finish,  String? variant,  dynamic structured)  assistant,}) {final _that = this;
switch (_that) {
case UserMessage():
return user(_that.id,_that.sessionID,_that.time,_that.agent,_that.model,_that.format,_that.summary,_that.system,_that.tools);case AssistantMessage():
return assistant(_that.id,_that.sessionID,_that.time,_that.parentID,_that.modelID,_that.providerID,_that.mode,_that.agent,_that.path,_that.cost,_that.tokens,_that.error,_that.finish,_that.variant,_that.structured);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String id,  String sessionID,  UserTime time,  String agent,  ModelRef model,  OutputFormat? format,  MessageSummary? summary,  String? system,  Map<String, bool>? tools)?  user,TResult? Function( String id,  String sessionID,  AssistantTime time,  String parentID,  String modelID,  String providerID,  String mode,  String agent,  MessagePath path,  double cost,  Tokens tokens,  MessageError? error,  String? finish,  String? variant,  dynamic structured)?  assistant,}) {final _that = this;
switch (_that) {
case UserMessage() when user != null:
return user(_that.id,_that.sessionID,_that.time,_that.agent,_that.model,_that.format,_that.summary,_that.system,_that.tools);case AssistantMessage() when assistant != null:
return assistant(_that.id,_that.sessionID,_that.time,_that.parentID,_that.modelID,_that.providerID,_that.mode,_that.agent,_that.path,_that.cost,_that.tokens,_that.error,_that.finish,_that.variant,_that.structured);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class UserMessage implements Message {
  const UserMessage({required this.id, required this.sessionID, required this.time, required this.agent, required this.model, this.format, this.summary, this.system, final  Map<String, bool>? tools, final  String? $type}): _tools = tools,$type = $type ?? 'user';
  factory UserMessage.fromJson(Map<String, dynamic> json) => _$UserMessageFromJson(json);

@override final  String id;
@override final  String sessionID;
@override final  UserTime time;
@override final  String agent;
 final  ModelRef model;
 final  OutputFormat? format;
 final  MessageSummary? summary;
 final  String? system;
 final  Map<String, bool>? _tools;
 Map<String, bool>? get tools {
  final value = _tools;
  if (value == null) return null;
  if (_tools is EqualUnmodifiableMapView) return _tools;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


@JsonKey(name: 'role')
final String $type;


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserMessageCopyWith<UserMessage> get copyWith => _$UserMessageCopyWithImpl<UserMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionID, sessionID) || other.sessionID == sessionID)&&(identical(other.time, time) || other.time == time)&&(identical(other.agent, agent) || other.agent == agent)&&(identical(other.model, model) || other.model == model)&&(identical(other.format, format) || other.format == format)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.system, system) || other.system == system)&&const DeepCollectionEquality().equals(other._tools, _tools));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sessionID,time,agent,model,format,summary,system,const DeepCollectionEquality().hash(_tools));

@override
String toString() {
  return 'Message.user(id: $id, sessionID: $sessionID, time: $time, agent: $agent, model: $model, format: $format, summary: $summary, system: $system, tools: $tools)';
}


}

/// @nodoc
abstract mixin class $UserMessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $UserMessageCopyWith(UserMessage value, $Res Function(UserMessage) _then) = _$UserMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String sessionID, UserTime time, String agent, ModelRef model, OutputFormat? format, MessageSummary? summary, String? system, Map<String, bool>? tools
});


$UserTimeCopyWith<$Res> get time;$ModelRefCopyWith<$Res> get model;$OutputFormatCopyWith<$Res>? get format;$MessageSummaryCopyWith<$Res>? get summary;

}
/// @nodoc
class _$UserMessageCopyWithImpl<$Res>
    implements $UserMessageCopyWith<$Res> {
  _$UserMessageCopyWithImpl(this._self, this._then);

  final UserMessage _self;
  final $Res Function(UserMessage) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sessionID = null,Object? time = null,Object? agent = null,Object? model = null,Object? format = freezed,Object? summary = freezed,Object? system = freezed,Object? tools = freezed,}) {
  return _then(UserMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionID: null == sessionID ? _self.sessionID : sessionID // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as UserTime,agent: null == agent ? _self.agent : agent // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as ModelRef,format: freezed == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as OutputFormat?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as MessageSummary?,system: freezed == system ? _self.system : system // ignore: cast_nullable_to_non_nullable
as String?,tools: freezed == tools ? _self._tools : tools // ignore: cast_nullable_to_non_nullable
as Map<String, bool>?,
  ));
}

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserTimeCopyWith<$Res> get time {
  
  return $UserTimeCopyWith<$Res>(_self.time, (value) {
    return _then(_self.copyWith(time: value));
  });
}/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ModelRefCopyWith<$Res> get model {
  
  return $ModelRefCopyWith<$Res>(_self.model, (value) {
    return _then(_self.copyWith(model: value));
  });
}/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OutputFormatCopyWith<$Res>? get format {
    if (_self.format == null) {
    return null;
  }

  return $OutputFormatCopyWith<$Res>(_self.format!, (value) {
    return _then(_self.copyWith(format: value));
  });
}/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageSummaryCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $MessageSummaryCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class AssistantMessage implements Message {
  const AssistantMessage({required this.id, required this.sessionID, required this.time, required this.parentID, required this.modelID, required this.providerID, required this.mode, required this.agent, required this.path, required this.cost, required this.tokens, this.error, this.finish, this.variant, this.structured, final  String? $type}): $type = $type ?? 'assistant';
  factory AssistantMessage.fromJson(Map<String, dynamic> json) => _$AssistantMessageFromJson(json);

@override final  String id;
@override final  String sessionID;
@override final  AssistantTime time;
 final  String parentID;
 final  String modelID;
 final  String providerID;
 final  String mode;
@override final  String agent;
 final  MessagePath path;
 final  double cost;
 final  Tokens tokens;
 final  MessageError? error;
 final  String? finish;
 final  String? variant;
 final  dynamic structured;

@JsonKey(name: 'role')
final String $type;


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssistantMessageCopyWith<AssistantMessage> get copyWith => _$AssistantMessageCopyWithImpl<AssistantMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssistantMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssistantMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionID, sessionID) || other.sessionID == sessionID)&&(identical(other.time, time) || other.time == time)&&(identical(other.parentID, parentID) || other.parentID == parentID)&&(identical(other.modelID, modelID) || other.modelID == modelID)&&(identical(other.providerID, providerID) || other.providerID == providerID)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.agent, agent) || other.agent == agent)&&(identical(other.path, path) || other.path == path)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.tokens, tokens) || other.tokens == tokens)&&(identical(other.error, error) || other.error == error)&&(identical(other.finish, finish) || other.finish == finish)&&(identical(other.variant, variant) || other.variant == variant)&&const DeepCollectionEquality().equals(other.structured, structured));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sessionID,time,parentID,modelID,providerID,mode,agent,path,cost,tokens,error,finish,variant,const DeepCollectionEquality().hash(structured));

@override
String toString() {
  return 'Message.assistant(id: $id, sessionID: $sessionID, time: $time, parentID: $parentID, modelID: $modelID, providerID: $providerID, mode: $mode, agent: $agent, path: $path, cost: $cost, tokens: $tokens, error: $error, finish: $finish, variant: $variant, structured: $structured)';
}


}

/// @nodoc
abstract mixin class $AssistantMessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $AssistantMessageCopyWith(AssistantMessage value, $Res Function(AssistantMessage) _then) = _$AssistantMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String sessionID, AssistantTime time, String parentID, String modelID, String providerID, String mode, String agent, MessagePath path, double cost, Tokens tokens, MessageError? error, String? finish, String? variant, dynamic structured
});


$AssistantTimeCopyWith<$Res> get time;$MessagePathCopyWith<$Res> get path;$TokensCopyWith<$Res> get tokens;$MessageErrorCopyWith<$Res>? get error;

}
/// @nodoc
class _$AssistantMessageCopyWithImpl<$Res>
    implements $AssistantMessageCopyWith<$Res> {
  _$AssistantMessageCopyWithImpl(this._self, this._then);

  final AssistantMessage _self;
  final $Res Function(AssistantMessage) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sessionID = null,Object? time = null,Object? parentID = null,Object? modelID = null,Object? providerID = null,Object? mode = null,Object? agent = null,Object? path = null,Object? cost = null,Object? tokens = null,Object? error = freezed,Object? finish = freezed,Object? variant = freezed,Object? structured = freezed,}) {
  return _then(AssistantMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionID: null == sessionID ? _self.sessionID : sessionID // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as AssistantTime,parentID: null == parentID ? _self.parentID : parentID // ignore: cast_nullable_to_non_nullable
as String,modelID: null == modelID ? _self.modelID : modelID // ignore: cast_nullable_to_non_nullable
as String,providerID: null == providerID ? _self.providerID : providerID // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,agent: null == agent ? _self.agent : agent // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as MessagePath,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double,tokens: null == tokens ? _self.tokens : tokens // ignore: cast_nullable_to_non_nullable
as Tokens,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as MessageError?,finish: freezed == finish ? _self.finish : finish // ignore: cast_nullable_to_non_nullable
as String?,variant: freezed == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as String?,structured: freezed == structured ? _self.structured : structured // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AssistantTimeCopyWith<$Res> get time {
  
  return $AssistantTimeCopyWith<$Res>(_self.time, (value) {
    return _then(_self.copyWith(time: value));
  });
}/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessagePathCopyWith<$Res> get path {
  
  return $MessagePathCopyWith<$Res>(_self.path, (value) {
    return _then(_self.copyWith(path: value));
  });
}/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TokensCopyWith<$Res> get tokens {
  
  return $TokensCopyWith<$Res>(_self.tokens, (value) {
    return _then(_self.copyWith(tokens: value));
  });
}/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageErrorCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $MessageErrorCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}


/// @nodoc
mixin _$MessageWithParts {

 Message get info; List<MessagePart> get parts;
/// Create a copy of MessageWithParts
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageWithPartsCopyWith<MessageWithParts> get copyWith => _$MessageWithPartsCopyWithImpl<MessageWithParts>(this as MessageWithParts, _$identity);

  /// Serializes this MessageWithParts to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageWithParts&&(identical(other.info, info) || other.info == info)&&const DeepCollectionEquality().equals(other.parts, parts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,info,const DeepCollectionEquality().hash(parts));

@override
String toString() {
  return 'MessageWithParts(info: $info, parts: $parts)';
}


}

/// @nodoc
abstract mixin class $MessageWithPartsCopyWith<$Res>  {
  factory $MessageWithPartsCopyWith(MessageWithParts value, $Res Function(MessageWithParts) _then) = _$MessageWithPartsCopyWithImpl;
@useResult
$Res call({
 Message info, List<MessagePart> parts
});


$MessageCopyWith<$Res> get info;

}
/// @nodoc
class _$MessageWithPartsCopyWithImpl<$Res>
    implements $MessageWithPartsCopyWith<$Res> {
  _$MessageWithPartsCopyWithImpl(this._self, this._then);

  final MessageWithParts _self;
  final $Res Function(MessageWithParts) _then;

/// Create a copy of MessageWithParts
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? info = null,Object? parts = null,}) {
  return _then(_self.copyWith(
info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as Message,parts: null == parts ? _self.parts : parts // ignore: cast_nullable_to_non_nullable
as List<MessagePart>,
  ));
}
/// Create a copy of MessageWithParts
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageCopyWith<$Res> get info {
  
  return $MessageCopyWith<$Res>(_self.info, (value) {
    return _then(_self.copyWith(info: value));
  });
}
}


/// Adds pattern-matching-related methods to [MessageWithParts].
extension MessageWithPartsPatterns on MessageWithParts {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageWithParts value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageWithParts() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageWithParts value)  $default,){
final _that = this;
switch (_that) {
case _MessageWithParts():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageWithParts value)?  $default,){
final _that = this;
switch (_that) {
case _MessageWithParts() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Message info,  List<MessagePart> parts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageWithParts() when $default != null:
return $default(_that.info,_that.parts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Message info,  List<MessagePart> parts)  $default,) {final _that = this;
switch (_that) {
case _MessageWithParts():
return $default(_that.info,_that.parts);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Message info,  List<MessagePart> parts)?  $default,) {final _that = this;
switch (_that) {
case _MessageWithParts() when $default != null:
return $default(_that.info,_that.parts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessageWithParts implements MessageWithParts {
  const _MessageWithParts({required this.info, required final  List<MessagePart> parts}): _parts = parts;
  factory _MessageWithParts.fromJson(Map<String, dynamic> json) => _$MessageWithPartsFromJson(json);

@override final  Message info;
 final  List<MessagePart> _parts;
@override List<MessagePart> get parts {
  if (_parts is EqualUnmodifiableListView) return _parts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_parts);
}


/// Create a copy of MessageWithParts
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageWithPartsCopyWith<_MessageWithParts> get copyWith => __$MessageWithPartsCopyWithImpl<_MessageWithParts>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageWithPartsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageWithParts&&(identical(other.info, info) || other.info == info)&&const DeepCollectionEquality().equals(other._parts, _parts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,info,const DeepCollectionEquality().hash(_parts));

@override
String toString() {
  return 'MessageWithParts(info: $info, parts: $parts)';
}


}

/// @nodoc
abstract mixin class _$MessageWithPartsCopyWith<$Res> implements $MessageWithPartsCopyWith<$Res> {
  factory _$MessageWithPartsCopyWith(_MessageWithParts value, $Res Function(_MessageWithParts) _then) = __$MessageWithPartsCopyWithImpl;
@override @useResult
$Res call({
 Message info, List<MessagePart> parts
});


@override $MessageCopyWith<$Res> get info;

}
/// @nodoc
class __$MessageWithPartsCopyWithImpl<$Res>
    implements _$MessageWithPartsCopyWith<$Res> {
  __$MessageWithPartsCopyWithImpl(this._self, this._then);

  final _MessageWithParts _self;
  final $Res Function(_MessageWithParts) _then;

/// Create a copy of MessageWithParts
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? info = null,Object? parts = null,}) {
  return _then(_MessageWithParts(
info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as Message,parts: null == parts ? _self._parts : parts // ignore: cast_nullable_to_non_nullable
as List<MessagePart>,
  ));
}

/// Create a copy of MessageWithParts
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageCopyWith<$Res> get info {
  
  return $MessageCopyWith<$Res>(_self.info, (value) {
    return _then(_self.copyWith(info: value));
  });
}
}

// dart format on
