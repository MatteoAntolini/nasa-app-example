import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final int? id;
  final String? title;
  final String? status;
  final String? startDate;
  final String? endDate;
  final String? description;
  final String? benefits;

  Project(
      {required this.id,
      required this.title,
      required this.status,
      required this.startDate,
      required this.endDate,
      required this.description,
      required this.benefits});

  @override
  List<Object?> get props =>
      [id, title, status, startDate, endDate, description, benefits];
}
