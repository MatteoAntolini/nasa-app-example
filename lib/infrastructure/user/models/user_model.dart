import 'package:nasa/domain/user/entities/user.dart';

class UserModel extends User {
  UserModel(
      {required String? id,
      required String? email,
      required List? favorites})
      : super(id: id, email: email, favorites: favorites);

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
        id: data["id"], email: data["email"], favorites: data["favorites"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "email": email, "favorites": favorites};
  }
}
