import 'package:nasa/domain/projects/entitites/project.dart';

class ProjectModel extends Project {
  ProjectModel({
    required int? id,
    required String? title,
    required String? status,
    required String? startDate,
    required String? endDate,
    required String? description,
    required String? benefits,
  }) : super(
            id: id,
            title: title,
            status: status,
            startDate: startDate,
            endDate: endDate,
            description: description,
            benefits: benefits);

  factory ProjectModel.fromMap(Map<String, dynamic> data) {
    return ProjectModel(
        id: data["projectId"],
        title: data["title"],
        status: data["releaseStatusString"],
        startDate: data["startDateString"],
        endDate: data["endDateString"],
        description: data["description"],
        benefits: data["benefits"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "status": status,
      "startDate": startDate,
      "endDate": endDate,
      "description": description,
      "benefits": benefits
    };
  }
}
