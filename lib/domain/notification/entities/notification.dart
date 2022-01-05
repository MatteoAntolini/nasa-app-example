import 'dart:convert';

import 'package:equatable/equatable.dart';

class LocalNotification extends Equatable {
  final String? type;
  final Map? data;
  LocalNotification({
    this.type,
    this.data,
  });

  LocalNotification copyWith({
    String? type,
    Map? data,
  }) {
    return LocalNotification(
      type: type ?? this.type,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'data': data,
    };
  }

  factory LocalNotification.fromMap(Map<String, dynamic>? map) {
    return LocalNotification(
      type: map!['type'],
      data: Map.from(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalNotification.fromJson(String source) =>
      LocalNotification.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [type, data];
}
