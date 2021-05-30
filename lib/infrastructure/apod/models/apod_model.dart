import 'package:nasa/domain/apod/entities/apod.dart';

class ApodModel extends Apod {
  ApodModel(
      {required String? date,
      required String? title,
      required String? explanation,
      required String? copyright,
      required String? hdurl})
      : super(date: date, title: title, explanation: explanation, copyright: copyright, hdurl: hdurl);

  factory ApodModel.fromMap(Map<String, dynamic> data) {
    return ApodModel(
        date: data["date"],
        title: data["title"],
        explanation: data["explanation"],
        copyright: data["copyright"],
        hdurl: data["hdurl"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "date": date,
      "title": title,
      "explanation": explanation,
      "copyright" : copyright,
      "hdurl": hdurl
    };
  }
}
