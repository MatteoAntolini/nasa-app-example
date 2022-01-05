import 'package:equatable/equatable.dart';
import 'package:nasa/domain/notification/entities/notification.dart';

abstract class NotificationState extends Equatable {
  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationReceived extends NotificationState {
  final LocalNotification notification;

  NotificationReceived({required this.notification});

  @override
  List<Object> get props => [notification];
}
