// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Session {

 String get id; String get slug; String get projectID; String? get workspaceID; String get directory; String? get path; String? get parentID; SessionSummary? get summary; double? get cost; Tokens? get tokens; SessionShare? get share; String get title; String? get agent; SessionModel? get model; String get version; Map<String, dynamic>? get metadata; List<dynamic>? get permission; SessionRevert? get revert; SessionTime get time;
/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionCopyWith<Session> get copyWith => _$SessionCopyWithImpl<Session>(this as Session, _$identity);

  /// Serializes this Session to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Session&&(identical(other.id, id) || other.id == id)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.projectID, projectID) || other.projectID == projectID)&&(identical(other.workspaceID, workspaceID) || other.workspaceID == workspaceID)&&(identical(other.directory, directory) || other.directory == directory)&&(identical(other.path, path) || other.path == path)&&(identical(other.parentID, parentID) || other.parentID == parentID)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.tokens, tokens) || other.tokens == tokens)&&(identical(other.share, share) || other.share == share)&&(identical(other.title, title) || other.title == title)&&(identical(other.agent, agent) || other.agent == agent)&&(identical(other.model, model) || other.model == model)&&(identical(other.version, version) || other.version == version)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&const DeepCollectionEquality().equals(other.permission, permission)&&(identical(other.revert, revert) || other.revert == revert)&&(identical(other.time, time) || other.time == time));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,slug,projectID,workspaceID,directory,path,parentID,summary,cost,tokens,share,title,agent,model,version,const DeepCollectionEquality().hash(metadata),const DeepCollectionEquality().hash(permission),revert,time]);

@override
String toString() {
  return 'Session(id: $id, slug: $slug, projectID: $projectID, workspaceID: $workspaceID, directory: $directory, path: $path, parentID: $parentID, summary: $summary, cost: $cost, tokens: $tokens, share: $share, title: $title, agent: $agent, model: $model, version: $version, metadata: $metadata, permission: $permission, revert: $revert, time: $time)';
}


}

/// @nodoc
abstract mixin class $SessionCopyWith<$Res>  {
  factory $SessionCopyWith(Session value, $Res Function(Session) _then) = _$SessionCopyWithImpl;
@useResult
$Res call({
 String id, String slug, String projectID, String? workspaceID, String directory, String? path, String? parentID, SessionSummary? summary, double? cost, Tokens? tokens, SessionShare? share, String title, String? agent, SessionModel? model, String version, Map<String, dynamic>? metadata, List<dynamic>? permission, SessionRevert? revert, SessionTime time
});


$SessionSummaryCopyWith<$Res>? get summary;$TokensCopyWith<$Res>? get tokens;$SessionShareCopyWith<$Res>? get share;$SessionModelCopyWith<$Res>? get model;$SessionRevertCopyWith<$Res>? get revert;$SessionTimeCopyWith<$Res> get time;

}
/// @nodoc
class _$SessionCopyWithImpl<$Res>
    implements $SessionCopyWith<$Res> {
  _$SessionCopyWithImpl(this._self, this._then);

  final Session _self;
  final $Res Function(Session) _then;

/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? slug = null,Object? projectID = null,Object? workspaceID = freezed,Object? directory = null,Object? path = freezed,Object? parentID = freezed,Object? summary = freezed,Object? cost = freezed,Object? tokens = freezed,Object? share = freezed,Object? title = null,Object? agent = freezed,Object? model = freezed,Object? version = null,Object? metadata = freezed,Object? permission = freezed,Object? revert = freezed,Object? time = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,projectID: null == projectID ? _self.projectID : projectID // ignore: cast_nullable_to_non_nullable
as String,workspaceID: freezed == workspaceID ? _self.workspaceID : workspaceID // ignore: cast_nullable_to_non_nullable
as String?,directory: null == directory ? _self.directory : directory // ignore: cast_nullable_to_non_nullable
as String,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,parentID: freezed == parentID ? _self.parentID : parentID // ignore: cast_nullable_to_non_nullable
as String?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as SessionSummary?,cost: freezed == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double?,tokens: freezed == tokens ? _self.tokens : tokens // ignore: cast_nullable_to_non_nullable
as Tokens?,share: freezed == share ? _self.share : share // ignore: cast_nullable_to_non_nullable
as SessionShare?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,agent: freezed == agent ? _self.agent : agent // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as SessionModel?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,permission: freezed == permission ? _self.permission : permission // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,revert: freezed == revert ? _self.revert : revert // ignore: cast_nullable_to_non_nullable
as SessionRevert?,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as SessionTime,
  ));
}
/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionSummaryCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $SessionSummaryCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TokensCopyWith<$Res>? get tokens {
    if (_self.tokens == null) {
    return null;
  }

  return $TokensCopyWith<$Res>(_self.tokens!, (value) {
    return _then(_self.copyWith(tokens: value));
  });
}/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionShareCopyWith<$Res>? get share {
    if (_self.share == null) {
    return null;
  }

  return $SessionShareCopyWith<$Res>(_self.share!, (value) {
    return _then(_self.copyWith(share: value));
  });
}/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionModelCopyWith<$Res>? get model {
    if (_self.model == null) {
    return null;
  }

  return $SessionModelCopyWith<$Res>(_self.model!, (value) {
    return _then(_self.copyWith(model: value));
  });
}/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionRevertCopyWith<$Res>? get revert {
    if (_self.revert == null) {
    return null;
  }

  return $SessionRevertCopyWith<$Res>(_self.revert!, (value) {
    return _then(_self.copyWith(revert: value));
  });
}/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionTimeCopyWith<$Res> get time {
  
  return $SessionTimeCopyWith<$Res>(_self.time, (value) {
    return _then(_self.copyWith(time: value));
  });
}
}


/// Adds pattern-matching-related methods to [Session].
extension SessionPatterns on Session {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Session value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Session() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Session value)  $default,){
final _that = this;
switch (_that) {
case _Session():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Session value)?  $default,){
final _that = this;
switch (_that) {
case _Session() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String slug,  String projectID,  String? workspaceID,  String directory,  String? path,  String? parentID,  SessionSummary? summary,  double? cost,  Tokens? tokens,  SessionShare? share,  String title,  String? agent,  SessionModel? model,  String version,  Map<String, dynamic>? metadata,  List<dynamic>? permission,  SessionRevert? revert,  SessionTime time)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Session() when $default != null:
return $default(_that.id,_that.slug,_that.projectID,_that.workspaceID,_that.directory,_that.path,_that.parentID,_that.summary,_that.cost,_that.tokens,_that.share,_that.title,_that.agent,_that.model,_that.version,_that.metadata,_that.permission,_that.revert,_that.time);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String slug,  String projectID,  String? workspaceID,  String directory,  String? path,  String? parentID,  SessionSummary? summary,  double? cost,  Tokens? tokens,  SessionShare? share,  String title,  String? agent,  SessionModel? model,  String version,  Map<String, dynamic>? metadata,  List<dynamic>? permission,  SessionRevert? revert,  SessionTime time)  $default,) {final _that = this;
switch (_that) {
case _Session():
return $default(_that.id,_that.slug,_that.projectID,_that.workspaceID,_that.directory,_that.path,_that.parentID,_that.summary,_that.cost,_that.tokens,_that.share,_that.title,_that.agent,_that.model,_that.version,_that.metadata,_that.permission,_that.revert,_that.time);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String slug,  String projectID,  String? workspaceID,  String directory,  String? path,  String? parentID,  SessionSummary? summary,  double? cost,  Tokens? tokens,  SessionShare? share,  String title,  String? agent,  SessionModel? model,  String version,  Map<String, dynamic>? metadata,  List<dynamic>? permission,  SessionRevert? revert,  SessionTime time)?  $default,) {final _that = this;
switch (_that) {
case _Session() when $default != null:
return $default(_that.id,_that.slug,_that.projectID,_that.workspaceID,_that.directory,_that.path,_that.parentID,_that.summary,_that.cost,_that.tokens,_that.share,_that.title,_that.agent,_that.model,_that.version,_that.metadata,_that.permission,_that.revert,_that.time);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Session implements Session {
  const _Session({required this.id, required this.slug, required this.projectID, this.workspaceID, required this.directory, this.path, this.parentID, this.summary, this.cost, this.tokens, this.share, required this.title, this.agent, this.model, required this.version, final  Map<String, dynamic>? metadata, final  List<dynamic>? permission, this.revert, required this.time}): _metadata = metadata,_permission = permission;
  factory _Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);

@override final  String id;
@override final  String slug;
@override final  String projectID;
@override final  String? workspaceID;
@override final  String directory;
@override final  String? path;
@override final  String? parentID;
@override final  SessionSummary? summary;
@override final  double? cost;
@override final  Tokens? tokens;
@override final  SessionShare? share;
@override final  String title;
@override final  String? agent;
@override final  SessionModel? model;
@override final  String version;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<dynamic>? _permission;
@override List<dynamic>? get permission {
  final value = _permission;
  if (value == null) return null;
  if (_permission is EqualUnmodifiableListView) return _permission;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  SessionRevert? revert;
@override final  SessionTime time;

/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionCopyWith<_Session> get copyWith => __$SessionCopyWithImpl<_Session>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Session&&(identical(other.id, id) || other.id == id)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.projectID, projectID) || other.projectID == projectID)&&(identical(other.workspaceID, workspaceID) || other.workspaceID == workspaceID)&&(identical(other.directory, directory) || other.directory == directory)&&(identical(other.path, path) || other.path == path)&&(identical(other.parentID, parentID) || other.parentID == parentID)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.tokens, tokens) || other.tokens == tokens)&&(identical(other.share, share) || other.share == share)&&(identical(other.title, title) || other.title == title)&&(identical(other.agent, agent) || other.agent == agent)&&(identical(other.model, model) || other.model == model)&&(identical(other.version, version) || other.version == version)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&const DeepCollectionEquality().equals(other._permission, _permission)&&(identical(other.revert, revert) || other.revert == revert)&&(identical(other.time, time) || other.time == time));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,slug,projectID,workspaceID,directory,path,parentID,summary,cost,tokens,share,title,agent,model,version,const DeepCollectionEquality().hash(_metadata),const DeepCollectionEquality().hash(_permission),revert,time]);

@override
String toString() {
  return 'Session(id: $id, slug: $slug, projectID: $projectID, workspaceID: $workspaceID, directory: $directory, path: $path, parentID: $parentID, summary: $summary, cost: $cost, tokens: $tokens, share: $share, title: $title, agent: $agent, model: $model, version: $version, metadata: $metadata, permission: $permission, revert: $revert, time: $time)';
}


}

/// @nodoc
abstract mixin class _$SessionCopyWith<$Res> implements $SessionCopyWith<$Res> {
  factory _$SessionCopyWith(_Session value, $Res Function(_Session) _then) = __$SessionCopyWithImpl;
@override @useResult
$Res call({
 String id, String slug, String projectID, String? workspaceID, String directory, String? path, String? parentID, SessionSummary? summary, double? cost, Tokens? tokens, SessionShare? share, String title, String? agent, SessionModel? model, String version, Map<String, dynamic>? metadata, List<dynamic>? permission, SessionRevert? revert, SessionTime time
});


@override $SessionSummaryCopyWith<$Res>? get summary;@override $TokensCopyWith<$Res>? get tokens;@override $SessionShareCopyWith<$Res>? get share;@override $SessionModelCopyWith<$Res>? get model;@override $SessionRevertCopyWith<$Res>? get revert;@override $SessionTimeCopyWith<$Res> get time;

}
/// @nodoc
class __$SessionCopyWithImpl<$Res>
    implements _$SessionCopyWith<$Res> {
  __$SessionCopyWithImpl(this._self, this._then);

  final _Session _self;
  final $Res Function(_Session) _then;

/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? slug = null,Object? projectID = null,Object? workspaceID = freezed,Object? directory = null,Object? path = freezed,Object? parentID = freezed,Object? summary = freezed,Object? cost = freezed,Object? tokens = freezed,Object? share = freezed,Object? title = null,Object? agent = freezed,Object? model = freezed,Object? version = null,Object? metadata = freezed,Object? permission = freezed,Object? revert = freezed,Object? time = null,}) {
  return _then(_Session(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,projectID: null == projectID ? _self.projectID : projectID // ignore: cast_nullable_to_non_nullable
as String,workspaceID: freezed == workspaceID ? _self.workspaceID : workspaceID // ignore: cast_nullable_to_non_nullable
as String?,directory: null == directory ? _self.directory : directory // ignore: cast_nullable_to_non_nullable
as String,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,parentID: freezed == parentID ? _self.parentID : parentID // ignore: cast_nullable_to_non_nullable
as String?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as SessionSummary?,cost: freezed == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as double?,tokens: freezed == tokens ? _self.tokens : tokens // ignore: cast_nullable_to_non_nullable
as Tokens?,share: freezed == share ? _self.share : share // ignore: cast_nullable_to_non_nullable
as SessionShare?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,agent: freezed == agent ? _self.agent : agent // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as SessionModel?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,permission: freezed == permission ? _self._permission : permission // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,revert: freezed == revert ? _self.revert : revert // ignore: cast_nullable_to_non_nullable
as SessionRevert?,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as SessionTime,
  ));
}

/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionSummaryCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $SessionSummaryCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TokensCopyWith<$Res>? get tokens {
    if (_self.tokens == null) {
    return null;
  }

  return $TokensCopyWith<$Res>(_self.tokens!, (value) {
    return _then(_self.copyWith(tokens: value));
  });
}/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionShareCopyWith<$Res>? get share {
    if (_self.share == null) {
    return null;
  }

  return $SessionShareCopyWith<$Res>(_self.share!, (value) {
    return _then(_self.copyWith(share: value));
  });
}/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionModelCopyWith<$Res>? get model {
    if (_self.model == null) {
    return null;
  }

  return $SessionModelCopyWith<$Res>(_self.model!, (value) {
    return _then(_self.copyWith(model: value));
  });
}/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionRevertCopyWith<$Res>? get revert {
    if (_self.revert == null) {
    return null;
  }

  return $SessionRevertCopyWith<$Res>(_self.revert!, (value) {
    return _then(_self.copyWith(revert: value));
  });
}/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionTimeCopyWith<$Res> get time {
  
  return $SessionTimeCopyWith<$Res>(_self.time, (value) {
    return _then(_self.copyWith(time: value));
  });
}
}


/// @nodoc
mixin _$SessionTime {

 int get created; int get updated; int? get compacting; int? get archived;
/// Create a copy of SessionTime
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionTimeCopyWith<SessionTime> get copyWith => _$SessionTimeCopyWithImpl<SessionTime>(this as SessionTime, _$identity);

  /// Serializes this SessionTime to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionTime&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.compacting, compacting) || other.compacting == compacting)&&(identical(other.archived, archived) || other.archived == archived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,created,updated,compacting,archived);

@override
String toString() {
  return 'SessionTime(created: $created, updated: $updated, compacting: $compacting, archived: $archived)';
}


}

/// @nodoc
abstract mixin class $SessionTimeCopyWith<$Res>  {
  factory $SessionTimeCopyWith(SessionTime value, $Res Function(SessionTime) _then) = _$SessionTimeCopyWithImpl;
@useResult
$Res call({
 int created, int updated, int? compacting, int? archived
});




}
/// @nodoc
class _$SessionTimeCopyWithImpl<$Res>
    implements $SessionTimeCopyWith<$Res> {
  _$SessionTimeCopyWithImpl(this._self, this._then);

  final SessionTime _self;
  final $Res Function(SessionTime) _then;

/// Create a copy of SessionTime
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? created = null,Object? updated = null,Object? compacting = freezed,Object? archived = freezed,}) {
  return _then(_self.copyWith(
created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as int,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as int,compacting: freezed == compacting ? _self.compacting : compacting // ignore: cast_nullable_to_non_nullable
as int?,archived: freezed == archived ? _self.archived : archived // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionTime].
extension SessionTimePatterns on SessionTime {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionTime value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionTime() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionTime value)  $default,){
final _that = this;
switch (_that) {
case _SessionTime():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionTime value)?  $default,){
final _that = this;
switch (_that) {
case _SessionTime() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int created,  int updated,  int? compacting,  int? archived)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionTime() when $default != null:
return $default(_that.created,_that.updated,_that.compacting,_that.archived);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int created,  int updated,  int? compacting,  int? archived)  $default,) {final _that = this;
switch (_that) {
case _SessionTime():
return $default(_that.created,_that.updated,_that.compacting,_that.archived);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int created,  int updated,  int? compacting,  int? archived)?  $default,) {final _that = this;
switch (_that) {
case _SessionTime() when $default != null:
return $default(_that.created,_that.updated,_that.compacting,_that.archived);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionTime implements SessionTime {
  const _SessionTime({required this.created, required this.updated, this.compacting, this.archived});
  factory _SessionTime.fromJson(Map<String, dynamic> json) => _$SessionTimeFromJson(json);

@override final  int created;
@override final  int updated;
@override final  int? compacting;
@override final  int? archived;

/// Create a copy of SessionTime
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionTimeCopyWith<_SessionTime> get copyWith => __$SessionTimeCopyWithImpl<_SessionTime>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionTimeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionTime&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.compacting, compacting) || other.compacting == compacting)&&(identical(other.archived, archived) || other.archived == archived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,created,updated,compacting,archived);

@override
String toString() {
  return 'SessionTime(created: $created, updated: $updated, compacting: $compacting, archived: $archived)';
}


}

/// @nodoc
abstract mixin class _$SessionTimeCopyWith<$Res> implements $SessionTimeCopyWith<$Res> {
  factory _$SessionTimeCopyWith(_SessionTime value, $Res Function(_SessionTime) _then) = __$SessionTimeCopyWithImpl;
@override @useResult
$Res call({
 int created, int updated, int? compacting, int? archived
});




}
/// @nodoc
class __$SessionTimeCopyWithImpl<$Res>
    implements _$SessionTimeCopyWith<$Res> {
  __$SessionTimeCopyWithImpl(this._self, this._then);

  final _SessionTime _self;
  final $Res Function(_SessionTime) _then;

/// Create a copy of SessionTime
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? created = null,Object? updated = null,Object? compacting = freezed,Object? archived = freezed,}) {
  return _then(_SessionTime(
created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as int,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as int,compacting: freezed == compacting ? _self.compacting : compacting // ignore: cast_nullable_to_non_nullable
as int?,archived: freezed == archived ? _self.archived : archived // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$CacheTokens {

 double get read; double get write;
/// Create a copy of CacheTokens
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CacheTokensCopyWith<CacheTokens> get copyWith => _$CacheTokensCopyWithImpl<CacheTokens>(this as CacheTokens, _$identity);

  /// Serializes this CacheTokens to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CacheTokens&&(identical(other.read, read) || other.read == read)&&(identical(other.write, write) || other.write == write));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,read,write);

@override
String toString() {
  return 'CacheTokens(read: $read, write: $write)';
}


}

/// @nodoc
abstract mixin class $CacheTokensCopyWith<$Res>  {
  factory $CacheTokensCopyWith(CacheTokens value, $Res Function(CacheTokens) _then) = _$CacheTokensCopyWithImpl;
@useResult
$Res call({
 double read, double write
});




}
/// @nodoc
class _$CacheTokensCopyWithImpl<$Res>
    implements $CacheTokensCopyWith<$Res> {
  _$CacheTokensCopyWithImpl(this._self, this._then);

  final CacheTokens _self;
  final $Res Function(CacheTokens) _then;

/// Create a copy of CacheTokens
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? read = null,Object? write = null,}) {
  return _then(_self.copyWith(
read: null == read ? _self.read : read // ignore: cast_nullable_to_non_nullable
as double,write: null == write ? _self.write : write // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CacheTokens].
extension CacheTokensPatterns on CacheTokens {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CacheTokens value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CacheTokens() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CacheTokens value)  $default,){
final _that = this;
switch (_that) {
case _CacheTokens():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CacheTokens value)?  $default,){
final _that = this;
switch (_that) {
case _CacheTokens() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double read,  double write)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CacheTokens() when $default != null:
return $default(_that.read,_that.write);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double read,  double write)  $default,) {final _that = this;
switch (_that) {
case _CacheTokens():
return $default(_that.read,_that.write);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double read,  double write)?  $default,) {final _that = this;
switch (_that) {
case _CacheTokens() when $default != null:
return $default(_that.read,_that.write);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CacheTokens implements CacheTokens {
  const _CacheTokens({required this.read, required this.write});
  factory _CacheTokens.fromJson(Map<String, dynamic> json) => _$CacheTokensFromJson(json);

@override final  double read;
@override final  double write;

/// Create a copy of CacheTokens
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CacheTokensCopyWith<_CacheTokens> get copyWith => __$CacheTokensCopyWithImpl<_CacheTokens>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CacheTokensToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CacheTokens&&(identical(other.read, read) || other.read == read)&&(identical(other.write, write) || other.write == write));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,read,write);

@override
String toString() {
  return 'CacheTokens(read: $read, write: $write)';
}


}

/// @nodoc
abstract mixin class _$CacheTokensCopyWith<$Res> implements $CacheTokensCopyWith<$Res> {
  factory _$CacheTokensCopyWith(_CacheTokens value, $Res Function(_CacheTokens) _then) = __$CacheTokensCopyWithImpl;
@override @useResult
$Res call({
 double read, double write
});




}
/// @nodoc
class __$CacheTokensCopyWithImpl<$Res>
    implements _$CacheTokensCopyWith<$Res> {
  __$CacheTokensCopyWithImpl(this._self, this._then);

  final _CacheTokens _self;
  final $Res Function(_CacheTokens) _then;

/// Create a copy of CacheTokens
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? read = null,Object? write = null,}) {
  return _then(_CacheTokens(
read: null == read ? _self.read : read // ignore: cast_nullable_to_non_nullable
as double,write: null == write ? _self.write : write // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$Tokens {

 double? get total; double get input; double get output; double get reasoning; CacheTokens get cache;
/// Create a copy of Tokens
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokensCopyWith<Tokens> get copyWith => _$TokensCopyWithImpl<Tokens>(this as Tokens, _$identity);

  /// Serializes this Tokens to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Tokens&&(identical(other.total, total) || other.total == total)&&(identical(other.input, input) || other.input == input)&&(identical(other.output, output) || other.output == output)&&(identical(other.reasoning, reasoning) || other.reasoning == reasoning)&&(identical(other.cache, cache) || other.cache == cache));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,total,input,output,reasoning,cache);

@override
String toString() {
  return 'Tokens(total: $total, input: $input, output: $output, reasoning: $reasoning, cache: $cache)';
}


}

/// @nodoc
abstract mixin class $TokensCopyWith<$Res>  {
  factory $TokensCopyWith(Tokens value, $Res Function(Tokens) _then) = _$TokensCopyWithImpl;
@useResult
$Res call({
 double? total, double input, double output, double reasoning, CacheTokens cache
});


$CacheTokensCopyWith<$Res> get cache;

}
/// @nodoc
class _$TokensCopyWithImpl<$Res>
    implements $TokensCopyWith<$Res> {
  _$TokensCopyWithImpl(this._self, this._then);

  final Tokens _self;
  final $Res Function(Tokens) _then;

/// Create a copy of Tokens
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? total = freezed,Object? input = null,Object? output = null,Object? reasoning = null,Object? cache = null,}) {
  return _then(_self.copyWith(
total: freezed == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double?,input: null == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as double,output: null == output ? _self.output : output // ignore: cast_nullable_to_non_nullable
as double,reasoning: null == reasoning ? _self.reasoning : reasoning // ignore: cast_nullable_to_non_nullable
as double,cache: null == cache ? _self.cache : cache // ignore: cast_nullable_to_non_nullable
as CacheTokens,
  ));
}
/// Create a copy of Tokens
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CacheTokensCopyWith<$Res> get cache {
  
  return $CacheTokensCopyWith<$Res>(_self.cache, (value) {
    return _then(_self.copyWith(cache: value));
  });
}
}


/// Adds pattern-matching-related methods to [Tokens].
extension TokensPatterns on Tokens {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Tokens value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Tokens() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Tokens value)  $default,){
final _that = this;
switch (_that) {
case _Tokens():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Tokens value)?  $default,){
final _that = this;
switch (_that) {
case _Tokens() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? total,  double input,  double output,  double reasoning,  CacheTokens cache)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Tokens() when $default != null:
return $default(_that.total,_that.input,_that.output,_that.reasoning,_that.cache);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? total,  double input,  double output,  double reasoning,  CacheTokens cache)  $default,) {final _that = this;
switch (_that) {
case _Tokens():
return $default(_that.total,_that.input,_that.output,_that.reasoning,_that.cache);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? total,  double input,  double output,  double reasoning,  CacheTokens cache)?  $default,) {final _that = this;
switch (_that) {
case _Tokens() when $default != null:
return $default(_that.total,_that.input,_that.output,_that.reasoning,_that.cache);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Tokens implements Tokens {
  const _Tokens({this.total, required this.input, required this.output, required this.reasoning, required this.cache});
  factory _Tokens.fromJson(Map<String, dynamic> json) => _$TokensFromJson(json);

@override final  double? total;
@override final  double input;
@override final  double output;
@override final  double reasoning;
@override final  CacheTokens cache;

/// Create a copy of Tokens
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokensCopyWith<_Tokens> get copyWith => __$TokensCopyWithImpl<_Tokens>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TokensToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Tokens&&(identical(other.total, total) || other.total == total)&&(identical(other.input, input) || other.input == input)&&(identical(other.output, output) || other.output == output)&&(identical(other.reasoning, reasoning) || other.reasoning == reasoning)&&(identical(other.cache, cache) || other.cache == cache));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,total,input,output,reasoning,cache);

@override
String toString() {
  return 'Tokens(total: $total, input: $input, output: $output, reasoning: $reasoning, cache: $cache)';
}


}

/// @nodoc
abstract mixin class _$TokensCopyWith<$Res> implements $TokensCopyWith<$Res> {
  factory _$TokensCopyWith(_Tokens value, $Res Function(_Tokens) _then) = __$TokensCopyWithImpl;
@override @useResult
$Res call({
 double? total, double input, double output, double reasoning, CacheTokens cache
});


@override $CacheTokensCopyWith<$Res> get cache;

}
/// @nodoc
class __$TokensCopyWithImpl<$Res>
    implements _$TokensCopyWith<$Res> {
  __$TokensCopyWithImpl(this._self, this._then);

  final _Tokens _self;
  final $Res Function(_Tokens) _then;

/// Create a copy of Tokens
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? total = freezed,Object? input = null,Object? output = null,Object? reasoning = null,Object? cache = null,}) {
  return _then(_Tokens(
total: freezed == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double?,input: null == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as double,output: null == output ? _self.output : output // ignore: cast_nullable_to_non_nullable
as double,reasoning: null == reasoning ? _self.reasoning : reasoning // ignore: cast_nullable_to_non_nullable
as double,cache: null == cache ? _self.cache : cache // ignore: cast_nullable_to_non_nullable
as CacheTokens,
  ));
}

/// Create a copy of Tokens
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CacheTokensCopyWith<$Res> get cache {
  
  return $CacheTokensCopyWith<$Res>(_self.cache, (value) {
    return _then(_self.copyWith(cache: value));
  });
}
}


/// @nodoc
mixin _$SessionSummary {

 double get additions; double get deletions; double get files; List<dynamic>? get diffs;
/// Create a copy of SessionSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionSummaryCopyWith<SessionSummary> get copyWith => _$SessionSummaryCopyWithImpl<SessionSummary>(this as SessionSummary, _$identity);

  /// Serializes this SessionSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionSummary&&(identical(other.additions, additions) || other.additions == additions)&&(identical(other.deletions, deletions) || other.deletions == deletions)&&(identical(other.files, files) || other.files == files)&&const DeepCollectionEquality().equals(other.diffs, diffs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,additions,deletions,files,const DeepCollectionEquality().hash(diffs));

@override
String toString() {
  return 'SessionSummary(additions: $additions, deletions: $deletions, files: $files, diffs: $diffs)';
}


}

/// @nodoc
abstract mixin class $SessionSummaryCopyWith<$Res>  {
  factory $SessionSummaryCopyWith(SessionSummary value, $Res Function(SessionSummary) _then) = _$SessionSummaryCopyWithImpl;
@useResult
$Res call({
 double additions, double deletions, double files, List<dynamic>? diffs
});




}
/// @nodoc
class _$SessionSummaryCopyWithImpl<$Res>
    implements $SessionSummaryCopyWith<$Res> {
  _$SessionSummaryCopyWithImpl(this._self, this._then);

  final SessionSummary _self;
  final $Res Function(SessionSummary) _then;

/// Create a copy of SessionSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? additions = null,Object? deletions = null,Object? files = null,Object? diffs = freezed,}) {
  return _then(_self.copyWith(
additions: null == additions ? _self.additions : additions // ignore: cast_nullable_to_non_nullable
as double,deletions: null == deletions ? _self.deletions : deletions // ignore: cast_nullable_to_non_nullable
as double,files: null == files ? _self.files : files // ignore: cast_nullable_to_non_nullable
as double,diffs: freezed == diffs ? _self.diffs : diffs // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionSummary].
extension SessionSummaryPatterns on SessionSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionSummary value)  $default,){
final _that = this;
switch (_that) {
case _SessionSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionSummary value)?  $default,){
final _that = this;
switch (_that) {
case _SessionSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double additions,  double deletions,  double files,  List<dynamic>? diffs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionSummary() when $default != null:
return $default(_that.additions,_that.deletions,_that.files,_that.diffs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double additions,  double deletions,  double files,  List<dynamic>? diffs)  $default,) {final _that = this;
switch (_that) {
case _SessionSummary():
return $default(_that.additions,_that.deletions,_that.files,_that.diffs);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double additions,  double deletions,  double files,  List<dynamic>? diffs)?  $default,) {final _that = this;
switch (_that) {
case _SessionSummary() when $default != null:
return $default(_that.additions,_that.deletions,_that.files,_that.diffs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionSummary implements SessionSummary {
  const _SessionSummary({required this.additions, required this.deletions, required this.files, final  List<dynamic>? diffs}): _diffs = diffs;
  factory _SessionSummary.fromJson(Map<String, dynamic> json) => _$SessionSummaryFromJson(json);

@override final  double additions;
@override final  double deletions;
@override final  double files;
 final  List<dynamic>? _diffs;
@override List<dynamic>? get diffs {
  final value = _diffs;
  if (value == null) return null;
  if (_diffs is EqualUnmodifiableListView) return _diffs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of SessionSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionSummaryCopyWith<_SessionSummary> get copyWith => __$SessionSummaryCopyWithImpl<_SessionSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionSummary&&(identical(other.additions, additions) || other.additions == additions)&&(identical(other.deletions, deletions) || other.deletions == deletions)&&(identical(other.files, files) || other.files == files)&&const DeepCollectionEquality().equals(other._diffs, _diffs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,additions,deletions,files,const DeepCollectionEquality().hash(_diffs));

@override
String toString() {
  return 'SessionSummary(additions: $additions, deletions: $deletions, files: $files, diffs: $diffs)';
}


}

/// @nodoc
abstract mixin class _$SessionSummaryCopyWith<$Res> implements $SessionSummaryCopyWith<$Res> {
  factory _$SessionSummaryCopyWith(_SessionSummary value, $Res Function(_SessionSummary) _then) = __$SessionSummaryCopyWithImpl;
@override @useResult
$Res call({
 double additions, double deletions, double files, List<dynamic>? diffs
});




}
/// @nodoc
class __$SessionSummaryCopyWithImpl<$Res>
    implements _$SessionSummaryCopyWith<$Res> {
  __$SessionSummaryCopyWithImpl(this._self, this._then);

  final _SessionSummary _self;
  final $Res Function(_SessionSummary) _then;

/// Create a copy of SessionSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? additions = null,Object? deletions = null,Object? files = null,Object? diffs = freezed,}) {
  return _then(_SessionSummary(
additions: null == additions ? _self.additions : additions // ignore: cast_nullable_to_non_nullable
as double,deletions: null == deletions ? _self.deletions : deletions // ignore: cast_nullable_to_non_nullable
as double,files: null == files ? _self.files : files // ignore: cast_nullable_to_non_nullable
as double,diffs: freezed == diffs ? _self._diffs : diffs // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,
  ));
}


}


/// @nodoc
mixin _$SessionShare {

 String get url;
/// Create a copy of SessionShare
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionShareCopyWith<SessionShare> get copyWith => _$SessionShareCopyWithImpl<SessionShare>(this as SessionShare, _$identity);

  /// Serializes this SessionShare to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionShare&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url);

@override
String toString() {
  return 'SessionShare(url: $url)';
}


}

/// @nodoc
abstract mixin class $SessionShareCopyWith<$Res>  {
  factory $SessionShareCopyWith(SessionShare value, $Res Function(SessionShare) _then) = _$SessionShareCopyWithImpl;
@useResult
$Res call({
 String url
});




}
/// @nodoc
class _$SessionShareCopyWithImpl<$Res>
    implements $SessionShareCopyWith<$Res> {
  _$SessionShareCopyWithImpl(this._self, this._then);

  final SessionShare _self;
  final $Res Function(SessionShare) _then;

/// Create a copy of SessionShare
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionShare].
extension SessionSharePatterns on SessionShare {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionShare value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionShare() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionShare value)  $default,){
final _that = this;
switch (_that) {
case _SessionShare():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionShare value)?  $default,){
final _that = this;
switch (_that) {
case _SessionShare() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionShare() when $default != null:
return $default(_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url)  $default,) {final _that = this;
switch (_that) {
case _SessionShare():
return $default(_that.url);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url)?  $default,) {final _that = this;
switch (_that) {
case _SessionShare() when $default != null:
return $default(_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionShare implements SessionShare {
  const _SessionShare({required this.url});
  factory _SessionShare.fromJson(Map<String, dynamic> json) => _$SessionShareFromJson(json);

@override final  String url;

/// Create a copy of SessionShare
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionShareCopyWith<_SessionShare> get copyWith => __$SessionShareCopyWithImpl<_SessionShare>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionShareToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionShare&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url);

@override
String toString() {
  return 'SessionShare(url: $url)';
}


}

/// @nodoc
abstract mixin class _$SessionShareCopyWith<$Res> implements $SessionShareCopyWith<$Res> {
  factory _$SessionShareCopyWith(_SessionShare value, $Res Function(_SessionShare) _then) = __$SessionShareCopyWithImpl;
@override @useResult
$Res call({
 String url
});




}
/// @nodoc
class __$SessionShareCopyWithImpl<$Res>
    implements _$SessionShareCopyWith<$Res> {
  __$SessionShareCopyWithImpl(this._self, this._then);

  final _SessionShare _self;
  final $Res Function(_SessionShare) _then;

/// Create a copy of SessionShare
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,}) {
  return _then(_SessionShare(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SessionRevert {

 String get messageID; String? get partID; String? get snapshot; String? get diff;
/// Create a copy of SessionRevert
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionRevertCopyWith<SessionRevert> get copyWith => _$SessionRevertCopyWithImpl<SessionRevert>(this as SessionRevert, _$identity);

  /// Serializes this SessionRevert to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionRevert&&(identical(other.messageID, messageID) || other.messageID == messageID)&&(identical(other.partID, partID) || other.partID == partID)&&(identical(other.snapshot, snapshot) || other.snapshot == snapshot)&&(identical(other.diff, diff) || other.diff == diff));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageID,partID,snapshot,diff);

@override
String toString() {
  return 'SessionRevert(messageID: $messageID, partID: $partID, snapshot: $snapshot, diff: $diff)';
}


}

/// @nodoc
abstract mixin class $SessionRevertCopyWith<$Res>  {
  factory $SessionRevertCopyWith(SessionRevert value, $Res Function(SessionRevert) _then) = _$SessionRevertCopyWithImpl;
@useResult
$Res call({
 String messageID, String? partID, String? snapshot, String? diff
});




}
/// @nodoc
class _$SessionRevertCopyWithImpl<$Res>
    implements $SessionRevertCopyWith<$Res> {
  _$SessionRevertCopyWithImpl(this._self, this._then);

  final SessionRevert _self;
  final $Res Function(SessionRevert) _then;

/// Create a copy of SessionRevert
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messageID = null,Object? partID = freezed,Object? snapshot = freezed,Object? diff = freezed,}) {
  return _then(_self.copyWith(
messageID: null == messageID ? _self.messageID : messageID // ignore: cast_nullable_to_non_nullable
as String,partID: freezed == partID ? _self.partID : partID // ignore: cast_nullable_to_non_nullable
as String?,snapshot: freezed == snapshot ? _self.snapshot : snapshot // ignore: cast_nullable_to_non_nullable
as String?,diff: freezed == diff ? _self.diff : diff // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionRevert].
extension SessionRevertPatterns on SessionRevert {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionRevert value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionRevert() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionRevert value)  $default,){
final _that = this;
switch (_that) {
case _SessionRevert():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionRevert value)?  $default,){
final _that = this;
switch (_that) {
case _SessionRevert() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String messageID,  String? partID,  String? snapshot,  String? diff)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionRevert() when $default != null:
return $default(_that.messageID,_that.partID,_that.snapshot,_that.diff);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String messageID,  String? partID,  String? snapshot,  String? diff)  $default,) {final _that = this;
switch (_that) {
case _SessionRevert():
return $default(_that.messageID,_that.partID,_that.snapshot,_that.diff);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String messageID,  String? partID,  String? snapshot,  String? diff)?  $default,) {final _that = this;
switch (_that) {
case _SessionRevert() when $default != null:
return $default(_that.messageID,_that.partID,_that.snapshot,_that.diff);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionRevert implements SessionRevert {
  const _SessionRevert({required this.messageID, this.partID, this.snapshot, this.diff});
  factory _SessionRevert.fromJson(Map<String, dynamic> json) => _$SessionRevertFromJson(json);

@override final  String messageID;
@override final  String? partID;
@override final  String? snapshot;
@override final  String? diff;

/// Create a copy of SessionRevert
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionRevertCopyWith<_SessionRevert> get copyWith => __$SessionRevertCopyWithImpl<_SessionRevert>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionRevertToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionRevert&&(identical(other.messageID, messageID) || other.messageID == messageID)&&(identical(other.partID, partID) || other.partID == partID)&&(identical(other.snapshot, snapshot) || other.snapshot == snapshot)&&(identical(other.diff, diff) || other.diff == diff));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageID,partID,snapshot,diff);

@override
String toString() {
  return 'SessionRevert(messageID: $messageID, partID: $partID, snapshot: $snapshot, diff: $diff)';
}


}

/// @nodoc
abstract mixin class _$SessionRevertCopyWith<$Res> implements $SessionRevertCopyWith<$Res> {
  factory _$SessionRevertCopyWith(_SessionRevert value, $Res Function(_SessionRevert) _then) = __$SessionRevertCopyWithImpl;
@override @useResult
$Res call({
 String messageID, String? partID, String? snapshot, String? diff
});




}
/// @nodoc
class __$SessionRevertCopyWithImpl<$Res>
    implements _$SessionRevertCopyWith<$Res> {
  __$SessionRevertCopyWithImpl(this._self, this._then);

  final _SessionRevert _self;
  final $Res Function(_SessionRevert) _then;

/// Create a copy of SessionRevert
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageID = null,Object? partID = freezed,Object? snapshot = freezed,Object? diff = freezed,}) {
  return _then(_SessionRevert(
messageID: null == messageID ? _self.messageID : messageID // ignore: cast_nullable_to_non_nullable
as String,partID: freezed == partID ? _self.partID : partID // ignore: cast_nullable_to_non_nullable
as String?,snapshot: freezed == snapshot ? _self.snapshot : snapshot // ignore: cast_nullable_to_non_nullable
as String?,diff: freezed == diff ? _self.diff : diff // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SessionModel {

 String get id; String get providerID; String? get variant;
/// Create a copy of SessionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionModelCopyWith<SessionModel> get copyWith => _$SessionModelCopyWithImpl<SessionModel>(this as SessionModel, _$identity);

  /// Serializes this SessionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.providerID, providerID) || other.providerID == providerID)&&(identical(other.variant, variant) || other.variant == variant));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,providerID,variant);

@override
String toString() {
  return 'SessionModel(id: $id, providerID: $providerID, variant: $variant)';
}


}

/// @nodoc
abstract mixin class $SessionModelCopyWith<$Res>  {
  factory $SessionModelCopyWith(SessionModel value, $Res Function(SessionModel) _then) = _$SessionModelCopyWithImpl;
@useResult
$Res call({
 String id, String providerID, String? variant
});




}
/// @nodoc
class _$SessionModelCopyWithImpl<$Res>
    implements $SessionModelCopyWith<$Res> {
  _$SessionModelCopyWithImpl(this._self, this._then);

  final SessionModel _self;
  final $Res Function(SessionModel) _then;

/// Create a copy of SessionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? providerID = null,Object? variant = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,providerID: null == providerID ? _self.providerID : providerID // ignore: cast_nullable_to_non_nullable
as String,variant: freezed == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionModel].
extension SessionModelPatterns on SessionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionModel value)  $default,){
final _that = this;
switch (_that) {
case _SessionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionModel value)?  $default,){
final _that = this;
switch (_that) {
case _SessionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String providerID,  String? variant)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionModel() when $default != null:
return $default(_that.id,_that.providerID,_that.variant);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String providerID,  String? variant)  $default,) {final _that = this;
switch (_that) {
case _SessionModel():
return $default(_that.id,_that.providerID,_that.variant);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String providerID,  String? variant)?  $default,) {final _that = this;
switch (_that) {
case _SessionModel() when $default != null:
return $default(_that.id,_that.providerID,_that.variant);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionModel implements SessionModel {
  const _SessionModel({required this.id, required this.providerID, this.variant});
  factory _SessionModel.fromJson(Map<String, dynamic> json) => _$SessionModelFromJson(json);

@override final  String id;
@override final  String providerID;
@override final  String? variant;

/// Create a copy of SessionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionModelCopyWith<_SessionModel> get copyWith => __$SessionModelCopyWithImpl<_SessionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.providerID, providerID) || other.providerID == providerID)&&(identical(other.variant, variant) || other.variant == variant));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,providerID,variant);

@override
String toString() {
  return 'SessionModel(id: $id, providerID: $providerID, variant: $variant)';
}


}

/// @nodoc
abstract mixin class _$SessionModelCopyWith<$Res> implements $SessionModelCopyWith<$Res> {
  factory _$SessionModelCopyWith(_SessionModel value, $Res Function(_SessionModel) _then) = __$SessionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String providerID, String? variant
});




}
/// @nodoc
class __$SessionModelCopyWithImpl<$Res>
    implements _$SessionModelCopyWith<$Res> {
  __$SessionModelCopyWithImpl(this._self, this._then);

  final _SessionModel _self;
  final $Res Function(_SessionModel) _then;

/// Create a copy of SessionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? providerID = null,Object? variant = freezed,}) {
  return _then(_SessionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,providerID: null == providerID ? _self.providerID : providerID // ignore: cast_nullable_to_non_nullable
as String,variant: freezed == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ModelRef {

 String get modelID; String get providerID; String? get variant;
/// Create a copy of ModelRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModelRefCopyWith<ModelRef> get copyWith => _$ModelRefCopyWithImpl<ModelRef>(this as ModelRef, _$identity);

  /// Serializes this ModelRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModelRef&&(identical(other.modelID, modelID) || other.modelID == modelID)&&(identical(other.providerID, providerID) || other.providerID == providerID)&&(identical(other.variant, variant) || other.variant == variant));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,modelID,providerID,variant);

@override
String toString() {
  return 'ModelRef(modelID: $modelID, providerID: $providerID, variant: $variant)';
}


}

/// @nodoc
abstract mixin class $ModelRefCopyWith<$Res>  {
  factory $ModelRefCopyWith(ModelRef value, $Res Function(ModelRef) _then) = _$ModelRefCopyWithImpl;
@useResult
$Res call({
 String modelID, String providerID, String? variant
});




}
/// @nodoc
class _$ModelRefCopyWithImpl<$Res>
    implements $ModelRefCopyWith<$Res> {
  _$ModelRefCopyWithImpl(this._self, this._then);

  final ModelRef _self;
  final $Res Function(ModelRef) _then;

/// Create a copy of ModelRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? modelID = null,Object? providerID = null,Object? variant = freezed,}) {
  return _then(_self.copyWith(
modelID: null == modelID ? _self.modelID : modelID // ignore: cast_nullable_to_non_nullable
as String,providerID: null == providerID ? _self.providerID : providerID // ignore: cast_nullable_to_non_nullable
as String,variant: freezed == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ModelRef].
extension ModelRefPatterns on ModelRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ModelRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ModelRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ModelRef value)  $default,){
final _that = this;
switch (_that) {
case _ModelRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ModelRef value)?  $default,){
final _that = this;
switch (_that) {
case _ModelRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String modelID,  String providerID,  String? variant)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ModelRef() when $default != null:
return $default(_that.modelID,_that.providerID,_that.variant);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String modelID,  String providerID,  String? variant)  $default,) {final _that = this;
switch (_that) {
case _ModelRef():
return $default(_that.modelID,_that.providerID,_that.variant);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String modelID,  String providerID,  String? variant)?  $default,) {final _that = this;
switch (_that) {
case _ModelRef() when $default != null:
return $default(_that.modelID,_that.providerID,_that.variant);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ModelRef implements ModelRef {
  const _ModelRef({required this.modelID, required this.providerID, this.variant});
  factory _ModelRef.fromJson(Map<String, dynamic> json) => _$ModelRefFromJson(json);

@override final  String modelID;
@override final  String providerID;
@override final  String? variant;

/// Create a copy of ModelRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ModelRefCopyWith<_ModelRef> get copyWith => __$ModelRefCopyWithImpl<_ModelRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ModelRefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ModelRef&&(identical(other.modelID, modelID) || other.modelID == modelID)&&(identical(other.providerID, providerID) || other.providerID == providerID)&&(identical(other.variant, variant) || other.variant == variant));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,modelID,providerID,variant);

@override
String toString() {
  return 'ModelRef(modelID: $modelID, providerID: $providerID, variant: $variant)';
}


}

/// @nodoc
abstract mixin class _$ModelRefCopyWith<$Res> implements $ModelRefCopyWith<$Res> {
  factory _$ModelRefCopyWith(_ModelRef value, $Res Function(_ModelRef) _then) = __$ModelRefCopyWithImpl;
@override @useResult
$Res call({
 String modelID, String providerID, String? variant
});




}
/// @nodoc
class __$ModelRefCopyWithImpl<$Res>
    implements _$ModelRefCopyWith<$Res> {
  __$ModelRefCopyWithImpl(this._self, this._then);

  final _ModelRef _self;
  final $Res Function(_ModelRef) _then;

/// Create a copy of ModelRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? modelID = null,Object? providerID = null,Object? variant = freezed,}) {
  return _then(_ModelRef(
modelID: null == modelID ? _self.modelID : modelID // ignore: cast_nullable_to_non_nullable
as String,providerID: null == providerID ? _self.providerID : providerID // ignore: cast_nullable_to_non_nullable
as String,variant: freezed == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RetryAction {

 String get reason; String get provider; String get title; String get message; String get label; String? get link;
/// Create a copy of RetryAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RetryActionCopyWith<RetryAction> get copyWith => _$RetryActionCopyWithImpl<RetryAction>(this as RetryAction, _$identity);

  /// Serializes this RetryAction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RetryAction&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.label, label) || other.label == label)&&(identical(other.link, link) || other.link == link));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reason,provider,title,message,label,link);

@override
String toString() {
  return 'RetryAction(reason: $reason, provider: $provider, title: $title, message: $message, label: $label, link: $link)';
}


}

/// @nodoc
abstract mixin class $RetryActionCopyWith<$Res>  {
  factory $RetryActionCopyWith(RetryAction value, $Res Function(RetryAction) _then) = _$RetryActionCopyWithImpl;
@useResult
$Res call({
 String reason, String provider, String title, String message, String label, String? link
});




}
/// @nodoc
class _$RetryActionCopyWithImpl<$Res>
    implements $RetryActionCopyWith<$Res> {
  _$RetryActionCopyWithImpl(this._self, this._then);

  final RetryAction _self;
  final $Res Function(RetryAction) _then;

/// Create a copy of RetryAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reason = null,Object? provider = null,Object? title = null,Object? message = null,Object? label = null,Object? link = freezed,}) {
  return _then(_self.copyWith(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RetryAction].
extension RetryActionPatterns on RetryAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RetryAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RetryAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RetryAction value)  $default,){
final _that = this;
switch (_that) {
case _RetryAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RetryAction value)?  $default,){
final _that = this;
switch (_that) {
case _RetryAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String reason,  String provider,  String title,  String message,  String label,  String? link)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RetryAction() when $default != null:
return $default(_that.reason,_that.provider,_that.title,_that.message,_that.label,_that.link);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String reason,  String provider,  String title,  String message,  String label,  String? link)  $default,) {final _that = this;
switch (_that) {
case _RetryAction():
return $default(_that.reason,_that.provider,_that.title,_that.message,_that.label,_that.link);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String reason,  String provider,  String title,  String message,  String label,  String? link)?  $default,) {final _that = this;
switch (_that) {
case _RetryAction() when $default != null:
return $default(_that.reason,_that.provider,_that.title,_that.message,_that.label,_that.link);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RetryAction implements RetryAction {
  const _RetryAction({required this.reason, required this.provider, required this.title, required this.message, required this.label, this.link});
  factory _RetryAction.fromJson(Map<String, dynamic> json) => _$RetryActionFromJson(json);

@override final  String reason;
@override final  String provider;
@override final  String title;
@override final  String message;
@override final  String label;
@override final  String? link;

/// Create a copy of RetryAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RetryActionCopyWith<_RetryAction> get copyWith => __$RetryActionCopyWithImpl<_RetryAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RetryActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RetryAction&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.label, label) || other.label == label)&&(identical(other.link, link) || other.link == link));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reason,provider,title,message,label,link);

@override
String toString() {
  return 'RetryAction(reason: $reason, provider: $provider, title: $title, message: $message, label: $label, link: $link)';
}


}

/// @nodoc
abstract mixin class _$RetryActionCopyWith<$Res> implements $RetryActionCopyWith<$Res> {
  factory _$RetryActionCopyWith(_RetryAction value, $Res Function(_RetryAction) _then) = __$RetryActionCopyWithImpl;
@override @useResult
$Res call({
 String reason, String provider, String title, String message, String label, String? link
});




}
/// @nodoc
class __$RetryActionCopyWithImpl<$Res>
    implements _$RetryActionCopyWith<$Res> {
  __$RetryActionCopyWithImpl(this._self, this._then);

  final _RetryAction _self;
  final $Res Function(_RetryAction) _then;

/// Create a copy of RetryAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reason = null,Object? provider = null,Object? title = null,Object? message = null,Object? label = null,Object? link = freezed,}) {
  return _then(_RetryAction(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

SessionStatus _$SessionStatusFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'idle':
          return SessionStatusIdle.fromJson(
            json
          );
                case 'busy':
          return SessionStatusBusy.fromJson(
            json
          );
                case 'retry':
          return SessionStatusRetry.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'SessionStatus',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$SessionStatus {



  /// Serializes this SessionStatus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionStatus);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionStatus()';
}


}

/// @nodoc
class $SessionStatusCopyWith<$Res>  {
$SessionStatusCopyWith(SessionStatus _, $Res Function(SessionStatus) __);
}


/// Adds pattern-matching-related methods to [SessionStatus].
extension SessionStatusPatterns on SessionStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SessionStatusIdle value)?  idle,TResult Function( SessionStatusBusy value)?  busy,TResult Function( SessionStatusRetry value)?  retry,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SessionStatusIdle() when idle != null:
return idle(_that);case SessionStatusBusy() when busy != null:
return busy(_that);case SessionStatusRetry() when retry != null:
return retry(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SessionStatusIdle value)  idle,required TResult Function( SessionStatusBusy value)  busy,required TResult Function( SessionStatusRetry value)  retry,}){
final _that = this;
switch (_that) {
case SessionStatusIdle():
return idle(_that);case SessionStatusBusy():
return busy(_that);case SessionStatusRetry():
return retry(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SessionStatusIdle value)?  idle,TResult? Function( SessionStatusBusy value)?  busy,TResult? Function( SessionStatusRetry value)?  retry,}){
final _that = this;
switch (_that) {
case SessionStatusIdle() when idle != null:
return idle(_that);case SessionStatusBusy() when busy != null:
return busy(_that);case SessionStatusRetry() when retry != null:
return retry(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  busy,TResult Function( int attempt,  String message,  RetryAction? action,  int next)?  retry,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SessionStatusIdle() when idle != null:
return idle();case SessionStatusBusy() when busy != null:
return busy();case SessionStatusRetry() when retry != null:
return retry(_that.attempt,_that.message,_that.action,_that.next);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  busy,required TResult Function( int attempt,  String message,  RetryAction? action,  int next)  retry,}) {final _that = this;
switch (_that) {
case SessionStatusIdle():
return idle();case SessionStatusBusy():
return busy();case SessionStatusRetry():
return retry(_that.attempt,_that.message,_that.action,_that.next);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  busy,TResult? Function( int attempt,  String message,  RetryAction? action,  int next)?  retry,}) {final _that = this;
switch (_that) {
case SessionStatusIdle() when idle != null:
return idle();case SessionStatusBusy() when busy != null:
return busy();case SessionStatusRetry() when retry != null:
return retry(_that.attempt,_that.message,_that.action,_that.next);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class SessionStatusIdle implements SessionStatus {
  const SessionStatusIdle({final  String? $type}): $type = $type ?? 'idle';
  factory SessionStatusIdle.fromJson(Map<String, dynamic> json) => _$SessionStatusIdleFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$SessionStatusIdleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionStatusIdle);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionStatus.idle()';
}


}




/// @nodoc
@JsonSerializable()

class SessionStatusBusy implements SessionStatus {
  const SessionStatusBusy({final  String? $type}): $type = $type ?? 'busy';
  factory SessionStatusBusy.fromJson(Map<String, dynamic> json) => _$SessionStatusBusyFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$SessionStatusBusyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionStatusBusy);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionStatus.busy()';
}


}




/// @nodoc
@JsonSerializable()

class SessionStatusRetry implements SessionStatus {
  const SessionStatusRetry({required this.attempt, required this.message, this.action, required this.next, final  String? $type}): $type = $type ?? 'retry';
  factory SessionStatusRetry.fromJson(Map<String, dynamic> json) => _$SessionStatusRetryFromJson(json);

 final  int attempt;
 final  String message;
 final  RetryAction? action;
 final  int next;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of SessionStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionStatusRetryCopyWith<SessionStatusRetry> get copyWith => _$SessionStatusRetryCopyWithImpl<SessionStatusRetry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionStatusRetryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionStatusRetry&&(identical(other.attempt, attempt) || other.attempt == attempt)&&(identical(other.message, message) || other.message == message)&&(identical(other.action, action) || other.action == action)&&(identical(other.next, next) || other.next == next));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,attempt,message,action,next);

@override
String toString() {
  return 'SessionStatus.retry(attempt: $attempt, message: $message, action: $action, next: $next)';
}


}

/// @nodoc
abstract mixin class $SessionStatusRetryCopyWith<$Res> implements $SessionStatusCopyWith<$Res> {
  factory $SessionStatusRetryCopyWith(SessionStatusRetry value, $Res Function(SessionStatusRetry) _then) = _$SessionStatusRetryCopyWithImpl;
@useResult
$Res call({
 int attempt, String message, RetryAction? action, int next
});


$RetryActionCopyWith<$Res>? get action;

}
/// @nodoc
class _$SessionStatusRetryCopyWithImpl<$Res>
    implements $SessionStatusRetryCopyWith<$Res> {
  _$SessionStatusRetryCopyWithImpl(this._self, this._then);

  final SessionStatusRetry _self;
  final $Res Function(SessionStatusRetry) _then;

/// Create a copy of SessionStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? attempt = null,Object? message = null,Object? action = freezed,Object? next = null,}) {
  return _then(SessionStatusRetry(
attempt: null == attempt ? _self.attempt : attempt // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,action: freezed == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as RetryAction?,next: null == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of SessionStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RetryActionCopyWith<$Res>? get action {
    if (_self.action == null) {
    return null;
  }

  return $RetryActionCopyWith<$Res>(_self.action!, (value) {
    return _then(_self.copyWith(action: value));
  });
}
}


/// @nodoc
mixin _$CreateSessionInput {

 String? get parentID; String? get title; String? get agent; SessionModel? get model; Map<String, dynamic>? get metadata; List<dynamic>? get permission; String? get workspaceID;
/// Create a copy of CreateSessionInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateSessionInputCopyWith<CreateSessionInput> get copyWith => _$CreateSessionInputCopyWithImpl<CreateSessionInput>(this as CreateSessionInput, _$identity);

  /// Serializes this CreateSessionInput to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateSessionInput&&(identical(other.parentID, parentID) || other.parentID == parentID)&&(identical(other.title, title) || other.title == title)&&(identical(other.agent, agent) || other.agent == agent)&&(identical(other.model, model) || other.model == model)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&const DeepCollectionEquality().equals(other.permission, permission)&&(identical(other.workspaceID, workspaceID) || other.workspaceID == workspaceID));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,parentID,title,agent,model,const DeepCollectionEquality().hash(metadata),const DeepCollectionEquality().hash(permission),workspaceID);

@override
String toString() {
  return 'CreateSessionInput(parentID: $parentID, title: $title, agent: $agent, model: $model, metadata: $metadata, permission: $permission, workspaceID: $workspaceID)';
}


}

/// @nodoc
abstract mixin class $CreateSessionInputCopyWith<$Res>  {
  factory $CreateSessionInputCopyWith(CreateSessionInput value, $Res Function(CreateSessionInput) _then) = _$CreateSessionInputCopyWithImpl;
@useResult
$Res call({
 String? parentID, String? title, String? agent, SessionModel? model, Map<String, dynamic>? metadata, List<dynamic>? permission, String? workspaceID
});


$SessionModelCopyWith<$Res>? get model;

}
/// @nodoc
class _$CreateSessionInputCopyWithImpl<$Res>
    implements $CreateSessionInputCopyWith<$Res> {
  _$CreateSessionInputCopyWithImpl(this._self, this._then);

  final CreateSessionInput _self;
  final $Res Function(CreateSessionInput) _then;

/// Create a copy of CreateSessionInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? parentID = freezed,Object? title = freezed,Object? agent = freezed,Object? model = freezed,Object? metadata = freezed,Object? permission = freezed,Object? workspaceID = freezed,}) {
  return _then(_self.copyWith(
parentID: freezed == parentID ? _self.parentID : parentID // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,agent: freezed == agent ? _self.agent : agent // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as SessionModel?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,permission: freezed == permission ? _self.permission : permission // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,workspaceID: freezed == workspaceID ? _self.workspaceID : workspaceID // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of CreateSessionInput
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionModelCopyWith<$Res>? get model {
    if (_self.model == null) {
    return null;
  }

  return $SessionModelCopyWith<$Res>(_self.model!, (value) {
    return _then(_self.copyWith(model: value));
  });
}
}


/// Adds pattern-matching-related methods to [CreateSessionInput].
extension CreateSessionInputPatterns on CreateSessionInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateSessionInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateSessionInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateSessionInput value)  $default,){
final _that = this;
switch (_that) {
case _CreateSessionInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateSessionInput value)?  $default,){
final _that = this;
switch (_that) {
case _CreateSessionInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? parentID,  String? title,  String? agent,  SessionModel? model,  Map<String, dynamic>? metadata,  List<dynamic>? permission,  String? workspaceID)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateSessionInput() when $default != null:
return $default(_that.parentID,_that.title,_that.agent,_that.model,_that.metadata,_that.permission,_that.workspaceID);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? parentID,  String? title,  String? agent,  SessionModel? model,  Map<String, dynamic>? metadata,  List<dynamic>? permission,  String? workspaceID)  $default,) {final _that = this;
switch (_that) {
case _CreateSessionInput():
return $default(_that.parentID,_that.title,_that.agent,_that.model,_that.metadata,_that.permission,_that.workspaceID);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? parentID,  String? title,  String? agent,  SessionModel? model,  Map<String, dynamic>? metadata,  List<dynamic>? permission,  String? workspaceID)?  $default,) {final _that = this;
switch (_that) {
case _CreateSessionInput() when $default != null:
return $default(_that.parentID,_that.title,_that.agent,_that.model,_that.metadata,_that.permission,_that.workspaceID);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateSessionInput implements CreateSessionInput {
  const _CreateSessionInput({this.parentID, this.title, this.agent, this.model, final  Map<String, dynamic>? metadata, final  List<dynamic>? permission, this.workspaceID}): _metadata = metadata,_permission = permission;
  factory _CreateSessionInput.fromJson(Map<String, dynamic> json) => _$CreateSessionInputFromJson(json);

@override final  String? parentID;
@override final  String? title;
@override final  String? agent;
@override final  SessionModel? model;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<dynamic>? _permission;
@override List<dynamic>? get permission {
  final value = _permission;
  if (value == null) return null;
  if (_permission is EqualUnmodifiableListView) return _permission;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? workspaceID;

/// Create a copy of CreateSessionInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateSessionInputCopyWith<_CreateSessionInput> get copyWith => __$CreateSessionInputCopyWithImpl<_CreateSessionInput>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateSessionInputToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateSessionInput&&(identical(other.parentID, parentID) || other.parentID == parentID)&&(identical(other.title, title) || other.title == title)&&(identical(other.agent, agent) || other.agent == agent)&&(identical(other.model, model) || other.model == model)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&const DeepCollectionEquality().equals(other._permission, _permission)&&(identical(other.workspaceID, workspaceID) || other.workspaceID == workspaceID));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,parentID,title,agent,model,const DeepCollectionEquality().hash(_metadata),const DeepCollectionEquality().hash(_permission),workspaceID);

@override
String toString() {
  return 'CreateSessionInput(parentID: $parentID, title: $title, agent: $agent, model: $model, metadata: $metadata, permission: $permission, workspaceID: $workspaceID)';
}


}

/// @nodoc
abstract mixin class _$CreateSessionInputCopyWith<$Res> implements $CreateSessionInputCopyWith<$Res> {
  factory _$CreateSessionInputCopyWith(_CreateSessionInput value, $Res Function(_CreateSessionInput) _then) = __$CreateSessionInputCopyWithImpl;
@override @useResult
$Res call({
 String? parentID, String? title, String? agent, SessionModel? model, Map<String, dynamic>? metadata, List<dynamic>? permission, String? workspaceID
});


@override $SessionModelCopyWith<$Res>? get model;

}
/// @nodoc
class __$CreateSessionInputCopyWithImpl<$Res>
    implements _$CreateSessionInputCopyWith<$Res> {
  __$CreateSessionInputCopyWithImpl(this._self, this._then);

  final _CreateSessionInput _self;
  final $Res Function(_CreateSessionInput) _then;

/// Create a copy of CreateSessionInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? parentID = freezed,Object? title = freezed,Object? agent = freezed,Object? model = freezed,Object? metadata = freezed,Object? permission = freezed,Object? workspaceID = freezed,}) {
  return _then(_CreateSessionInput(
parentID: freezed == parentID ? _self.parentID : parentID // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,agent: freezed == agent ? _self.agent : agent // ignore: cast_nullable_to_non_nullable
as String?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as SessionModel?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,permission: freezed == permission ? _self._permission : permission // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,workspaceID: freezed == workspaceID ? _self.workspaceID : workspaceID // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of CreateSessionInput
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionModelCopyWith<$Res>? get model {
    if (_self.model == null) {
    return null;
  }

  return $SessionModelCopyWith<$Res>(_self.model!, (value) {
    return _then(_self.copyWith(model: value));
  });
}
}

// dart format on
