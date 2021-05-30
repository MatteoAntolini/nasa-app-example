import 'package:equatable/equatable.dart';

class Apod extends Equatable {
  final String? date;
  final String? title;
  final String? explanation;
  final String? copyright;
  final String? hdurl;

  Apod(
      {required this.date,
      required this.title,
      required this.explanation,
      required this.copyright,
      required this.hdurl});

  @override
  List<Object?> get props => [date, title, explanation, copyright, hdurl];
}
