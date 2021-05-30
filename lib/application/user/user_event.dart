import 'package:flutter/material.dart';

@immutable
abstract class UserEvent {}

class GetUserEvent extends UserEvent {
  final String? userId;

  GetUserEvent({required this.userId});
}

class CreateUserEvent extends UserEvent {
  final Map<String, dynamic>? data;

  CreateUserEvent({required this.data});
}

class UpdateUserEvent extends UserEvent {
  final String? userId;
  final Map? data;
  UpdateUserEvent({required this.userId, required this.data});
}

class AddFavoriteEvent extends UserEvent {
  final String? userId;
  final String? date;

  AddFavoriteEvent({required this.userId, required this.date});
}

class RemoveFavoriteEvent extends UserEvent {
  final String? userId;
  final String? date;

  RemoveFavoriteEvent({required this.userId, required this.date});
}
