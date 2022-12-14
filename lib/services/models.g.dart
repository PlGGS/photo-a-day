// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Projects _$ProjectsFromJson(Map<String, dynamic> json) => Projects(
      projects: (json['projects'] as List<dynamic>)
          .map((e) => Project.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProjectsToJson(Projects instance) => <String, dynamic>{
      'projects': instance.projects,
    };

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      type: $enumDecodeNullable(_$ProjectTypesEnumMap, json['type']) ??
          ProjectTypes.daily,
      hasBlurb: json['hasBlurb'] as bool? ?? true,
      usesTimedNotifications: json['usesTimedNotifications'] as bool? ?? true,
      usesRandomNotifications:
          json['usesRandomNotifications'] as bool? ?? false,
      timedNotifications: json['timedNotifications'] == null
          ? const []
          : Project._fromJson(json['timedNotifications'] as List<int>),
      startRandomNotifications: json['startRandomNotifications'] == null
          ? const []
          : Project._fromJson(json['startRandomNotifications'] as List<int>),
      endRandomNotifications: json['endRandomNotifications'] == null
          ? const []
          : Project._fromJson(json['endRandomNotifications'] as List<int>),
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': _$ProjectTypesEnumMap[instance.type]!,
      'hasBlurb': instance.hasBlurb,
      'usesTimedNotifications': instance.usesTimedNotifications,
      'usesRandomNotifications': instance.usesRandomNotifications,
      'timedNotifications': Project._toJson(instance.timedNotifications),
      'startRandomNotifications':
          Project._toJson(instance.startRandomNotifications),
      'endRandomNotifications':
          Project._toJson(instance.endRandomNotifications),
    };

const _$ProjectTypesEnumMap = {
  ProjectTypes.daily: 'daily',
  ProjectTypes.weekly: 'weekly',
  ProjectTypes.single: 'single',
};

Day _$DayFromJson(Map<String, dynamic> json) => Day(
      id: json['id'] as String? ?? '',
      dateTime: Day._fromJson(json['dateTime'] as int),
      imageUri: json['imageUri'] as String? ?? '',
      blurb: json['blurb'] as String? ?? '',
      cameraPerson:
          CameraPerson.fromJson(json['cameraPerson'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DayToJson(Day instance) => <String, dynamic>{
      'id': instance.id,
      'dateTime': Day._toJson(instance.dateTime),
      'imageUri': instance.imageUri,
      'blurb': instance.blurb,
      'cameraPerson': instance.cameraPerson,
    };

UniversalDay _$UniversalDayFromJson(Map<String, dynamic> json) => UniversalDay(
      dateTime: UniversalDay._fromJson(json['dateTime'] as int),
    );

Map<String, dynamic> _$UniversalDayToJson(UniversalDay instance) =>
    <String, dynamic>{
      'dateTime': UniversalDay._toJson(instance.dateTime),
    };

CameraPerson _$CameraPersonFromJson(Map<String, dynamic> json) => CameraPerson(
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
    );

Map<String, dynamic> _$CameraPersonToJson(CameraPerson instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };

Feature _$FeatureFromJson(Map<String, dynamic> json) => Feature(
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      imageUri: json['imageUri'] as String? ?? '',
    );

Map<String, dynamic> _$FeatureToJson(Feature instance) => <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'imageUri': instance.imageUri,
    };
