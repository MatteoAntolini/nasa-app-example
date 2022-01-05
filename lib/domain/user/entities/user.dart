import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String? email;
  final List? favorites;

  User({required this.id, required this.email, required this.favorites});

  Map<String, dynamic> toMap() {
    return {"id": id, "email": email, "favorites": favorites};
  }

  @override
  List<Object?> get props => [id, email, favorites];
}
