// part of 'auth_bloc.dart';




// abstract class AuthState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class AuthInitial extends AuthState {}

// class AuthLoading extends AuthState {}

// class AuthCompleted extends AuthState {
//   final FirebaseUser user;

//   AuthCompleted({required this.user});

//   @override
//   List<Object> get props => [user];
// }

// class AuthError extends AuthState {
//   final int code;
//   final String? message;

//   AuthError({required this.code, this.message});

//   @override
//   List<Object?> get props => [code, message];
// }

// class RegisterLoading extends AuthState {}

// class RegisterCompleted extends AuthState {
//   final FirebaseUser user;
//   final Map<String, dynamic> data;

//   RegisterCompleted({required this.user, required this.data});

//   @override
//   List<Object> get props => [user, data];
// }

// class RegisterError extends AuthState {
//   final int code;
//   final String? message;

//   RegisterError({required this.code, this.message});

//   @override
//   List<Object?> get props => [code, message];
// }

// class LogoutLoading extends AuthState {}

// class LogoutCompleted extends AuthState {}

// class LogoutError extends AuthState {
//   final int code;
//   final String? message;

//   LogoutError({required this.code, this.message});

//   @override
//   List<Object?> get props => [code, message];
// }
