import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class HomeState extends Equatable {
  final Widget screen;

  HomeState({required this.screen});
}

class CurrentScreen extends HomeState {
  CurrentScreen({required Widget screen}) : super(screen: screen);

  @override
  List<Object> get props => [screen];
}
