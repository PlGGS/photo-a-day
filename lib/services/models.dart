import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../widgets/pages/project/Project.dart';
part 'models.g.dart';

@JsonSerializable()
class Projects {
  List<Project> projects;

  Projects({
    required this.projects,
  });
  factory Projects.fromJson(Map<String, dynamic> json) =>
      _$ProjectsFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectsToJson(this);
}

@JsonSerializable()
class Project {
  String id;
  String name;
  String description;
  ProjectTypes type;
  bool hasBlurb;
  bool usesTimedNotifications;
  bool usesRandomNotifications;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  List<DateTime> timedNotifications;
  //random notifications have a user-defined range for when they can arrive
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  List<DateTime> startRandomNotifications;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  List<DateTime> endRandomNotifications;

  Project({
    this.id = '',
    this.name = '',
    this.description = '',
    this.type = ProjectTypes.daily,
    this.hasBlurb = true,
    this.usesTimedNotifications = true,
    this.usesRandomNotifications = false,
    this.timedNotifications = const [],
    this.startRandomNotifications = const [],
    this.endRandomNotifications = const [],
  });
  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  static List<DateTime> _fromJson(List<int> dtInts) {
    List<DateTime> dts = [];
    for (var dateTime in dtInts) {
      dts.add(DateTime.fromMillisecondsSinceEpoch(dateTime));
    }
    return dts;
  }

  static List<int> _toJson(List<DateTime> dts) {
    List<int> dtInts = [];
    for (var dt in dts) {
      dtInts.add(dt.millisecondsSinceEpoch);
    }
    return dtInts;
  }
}

///Class housing all relavent information for any given user day
@JsonSerializable()
class Day {
  String id;
  //https://stackoverflow.com/questions/55328064/how-to-convert-int-timestamp-to-datetime-in-json-serializable-flutter
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime dateTime;
  String imageUri;
  String blurb;
  CameraPerson cameraPerson;

  Day({
    this.id = '',
    required this.dateTime,
    this.imageUri = '',
    this.blurb = '',
    required this.cameraPerson,
  });
  factory Day.fromJson(Map<String, dynamic> json) => _$DayFromJson(json);
  Map<String, dynamic> toJson() => _$DayToJson(this);

  static DateTime _fromJson(int dtInt) =>
      DateTime.fromMillisecondsSinceEpoch(dtInt);
  static int _toJson(DateTime time) => time.millisecondsSinceEpoch;
}

@JsonSerializable()
class UniversalDay {
  //https://stackoverflow.com/questions/55328064/how-to-convert-int-timestamp-to-datetime-in-json-serializable-flutter
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime dateTime;
  //TODO Serialize info from all sources daily

  UniversalDay({
    required this.dateTime,
  });
  factory UniversalDay.fromJson(Map<String, dynamic> json) =>
      _$UniversalDayFromJson(json);
  Map<String, dynamic> toJson() => _$UniversalDayToJson(this);

  static DateTime _fromJson(int dtInt) =>
      DateTime.fromMillisecondsSinceEpoch(dtInt);
  static int _toJson(DateTime time) => time.millisecondsSinceEpoch;
}

@JsonSerializable()
class CameraPerson {
  final String firstName;
  final String lastName;

  CameraPerson({
    this.firstName = '',
    this.lastName = '',
  });
  factory CameraPerson.fromJson(Map<String, dynamic> json) =>
      _$CameraPersonFromJson(json);
  Map<String, dynamic> toJson() => _$CameraPersonToJson(this);
}

@JsonSerializable()
class Feature {
  String title;
  String subtitle;
  String imageUri;

  Feature({
    this.title = '',
    this.subtitle = '',
    this.imageUri = '',
  });
  factory Feature.fromJson(Map<String, dynamic> json) =>
      _$FeatureFromJson(json);
  Map<String, dynamic> toJson() => _$FeatureToJson(this);
}
