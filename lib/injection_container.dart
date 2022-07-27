// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:nasa/application/apod/apod_cubit.dart';
import 'package:nasa/application/apods/apods_cubit.dart';
import 'package:nasa/application/favorites/favorites_cubit.dart';
import 'package:nasa/application/home/home_cubit.dart';
import 'package:nasa/application/theme/theme_cubit.dart';
import 'package:nasa/domain/apod/repositories/apod_repository.dart';
import 'package:nasa/domain/apod/usecases/get_favorites.dart';
import 'package:nasa/domain/projects/repositories/projects_repository.dart';
import 'package:nasa/domain/projects/usecases/get_projects.dart';
import 'package:nasa/domain/user/usecases/remove_favorite.dart';
import 'package:nasa/infrastructure/apod/repositories/apod_repository_imp.dart';
import 'package:nasa/infrastructure/projects/repositories/projects_repository_imp.dart';

import 'application/auth/auth_bloc.dart';
import 'application/notification/notification_cubit.dart';
import 'application/projects/projects_cubit.dart';
import 'application/user/user_bloc.dart';
import 'domain/apod/usecases/get_apod.dart';
import 'domain/apod/usecases/get_apods.dart';
import 'domain/auth/repositories/firebase_auth_repository.dart';
import 'domain/auth/usecases/login_email.dart';
import 'domain/auth/usecases/login_google.dart';
import 'domain/auth/usecases/logout.dart';
import 'domain/auth/usecases/register.dart';
import 'domain/auth/usecases/get_firebase_user.dart';
import 'domain/user/repositories/user_repository.dart';
import 'domain/user/usecases/add_favorite.dart';
import 'domain/user/usecases/create_user.dart';
import 'domain/user/usecases/get_user.dart';
import 'domain/user/usecases/update_user.dart';
import 'infrastructure/auth/repositories/firebase_auth_repository_imp.dart';
import 'infrastructure/user/repositories/user_repository_imp.dart';
import 'network/network_info.dart';

final sl = GetIt.instance;

void init() {
  sl.allowReassignment = true;
  //Usecases

  //AUTH
  // sl.registerLazySingleton(() => LoginWithEmail(sl()));
  // sl.registerLazySingleton(() => LoginWithGoogle(sl()));
  // sl.registerLazySingleton(() => Logout(sl()));
  // sl.registerLazySingleton(() => Register(sl()));
  // sl.registerLazySingleton(() => GetFirebaseUser(sl()));

  //USER
  // sl.registerLazySingleton(() => CreateUser(sl()));
  // sl.registerLazySingleton(() => GetUser(sl()));
  // sl.registerLazySingleton(() => UpdateUser(sl()));
  // sl.registerLazySingleton(() => AddFavorite(sl()));
  // sl.registerLazySingleton(() => RemoveFavorite(sl()));

  //APOD
  sl.registerLazySingleton(() => GetApods(sl()));
  sl.registerLazySingleton(() => GetApod(sl()));
  sl.registerLazySingleton(() => GetFavorites(sl()));

  //PROJECTS
  sl.registerLazySingleton(() => GetProjects(sl()));

  //Repositories

  //AUTH
  // sl.registerLazySingleton<FirebaseAuthRepository>(() =>
  //     FirebaseAuthRepositoryImp(
  //         firebaseAuth: sl(),
  //         googleSignIn: sl(),
  //         //facebookAuth: sl(),
  //         networkInfo: sl()));

  //User
  // sl.registerLazySingleton<UserRepository>(
  //     () => UserRepositoryImp(database: sl(), networkInfo: sl()));

  //APOD
  sl.registerLazySingleton<ApodRepository>(
      () => ApodRepositoryImp(networkInfo: sl()));

  //Projects
  sl.registerLazySingleton<ProjectsRepository>(
      () => ProjectsRepositoryImp(networkInfo: sl()));

  // Firebase

  // sl.registerLazySingleton(() => FirebaseAuth.instance);
  // sl.registerLazySingleton(() => GoogleSignIn());
  // //sl.registerLazySingleton(() => FacebookAuth.instance);
  // sl.registerLazySingleton(() => FirebaseFirestore.instance);
  // sl.registerLazySingleton(() => FirebaseMessaging.instance);

  // Extra

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(sl()));
  sl.registerLazySingleton(() => Connectivity());

  //Bloc

  // sl.registerSingleton<AuthBloc>(AuthBloc(
  //     logout: sl(),
  //     getFirebaseUser: sl(),
  //     register: sl(),
  //     loginWithGoogle: sl(),
  //     loginWithEmail: sl()));

  // sl.registerSingleton<UserBloc>(UserBloc(
  //     updateUser: sl(),
  //     authBloc: sl(),
  //     createUser: sl(),
  //     getUser: sl(),
  //     addFavorite: sl(),
  //     removeFavorite: sl()));

  sl.registerSingleton<HomeCubit>(HomeCubit());

  sl.registerSingleton<ApodCubit>(ApodCubit(getApod: sl()));

  sl.registerSingleton(ApodsCubit(getApods: sl()));

  sl.registerSingleton<ProjectsCubit>(ProjectsCubit(getProjects: sl()));

  // sl.registerSingleton<NotificationCubit>(NotificationCubit(messaging: sl()));

  sl.registerSingleton<ThemeCubit>(ThemeCubit());
}
