import 'package:nasa/domain/auth/entities/firebase_user.dart';

class FirebaseUserModel extends FirebaseUser {
  FirebaseUserModel({required String? uid, required email, required name})
      : super(uid: uid, email: email, name: name);

  factory FirebaseUserModel.fromJson(Map<String, dynamic> data){

    return FirebaseUserModel(uid: data["uid"], email: data["email"], name: data["name"]);
  }

  Map<String, dynamic> toJson(){

    return {
      "uid" : uid,
      "email" : email,
      "name" : name
    };

  }
}
