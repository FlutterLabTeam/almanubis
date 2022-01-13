import 'package:almanubis/features/auth/domain/usecases/save_user_logged.dart';
import 'package:almanubis/features/new_group/data/data_sources/new_group_data_source.dart';
import 'package:almanubis/features/new_group/data/repositories/new_group_repository_impl.dart';
import 'package:almanubis/features/new_group/domain/repositories/new_group_repository.dart';
import 'package:almanubis/features/new_group/domain/use_cases/get_all_user.dart';
import 'package:almanubis/features/new_group/presentation/bloc/new_group_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:almanubis/features/auth/domain/usecases/login_email.dart';
import 'package:almanubis/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:almanubis/features/auth/domain/usecases/get_user_data.dart';
import 'package:almanubis/features/auth/data/datasources/auth_data_source.dart';
import 'package:almanubis/features/auth/domain/repositories/auth_repository.dart';
import 'package:almanubis/features/new_user/domain/use_cases/register_email.dart';
import 'package:almanubis/features/new_user/presentation/bloc/new_user_bloc.dart';
import 'package:almanubis/features/auth/domain/usecases/validate_user_logged.dart';
import 'package:almanubis/features/new_user/domain/use_cases/register_user_db.dart';
import 'package:almanubis/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:almanubis/features/new_user/data/data_sources/new_user_data_source.dart';
import 'package:almanubis/features/new_user/domain/repositories/new_user_repository.dart';
import 'package:almanubis/features/new_user/data/repositories/new_user_repository_impl.dart';

final sl = GetIt.instance;

init() async {
  //Blocs
  sl.registerFactory(() => AuthBloc(
        loginEmail: sl(),
        getUserData: sl(),
        saveUserLogged: sl(),
        validateUserLogged: sl(),
      ));
  sl.registerFactory(() => NewUserBloc(
        registerEmail: sl(),
        registerUserDb: sl(),
      ));
  sl.registerFactory(() => NewGroupBloc(
    getAllUser: sl(),
  ));

// Use cases
  sl.registerLazySingleton(() => LoginEmail(authRepository: sl()));
  sl.registerLazySingleton(() => GetUserData(authRepository: sl()));
  sl.registerLazySingleton(() => GetAllUser(newGroupRepository: sl()));
  sl.registerLazySingleton(() => SaveUserLogged(authRepository: sl()));
  sl.registerLazySingleton(() => RegisterEmail(newUserRepository: sl()));
  sl.registerLazySingleton(() => RegisterUserDb(newUserRepository: sl()));
  sl.registerLazySingleton(() => ValidateUserLogged(authRepository: sl()));

//Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(authDataSource: sl()));
  sl.registerLazySingleton<NewUserRepository>(() => NewUserRepositoryImpl(newUserDataSource: sl()));
  sl.registerLazySingleton<NewGroupRepository>(() => NewGroupRepositoryImpl(newGroupDataSource: sl()));

  //DataSource
  sl.registerLazySingleton<NewUserDataSource>(() => NewUserDataSourceImpl(firestore: sl(),firebaseAuth: sl()));
  sl.registerLazySingleton<NewGroupDataSource>(() => NewGroupDataSourceImpl(firestore: sl(),firebaseAuth: sl()));
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl(firestore: sl(),firebaseAuth: sl(), sharedPreferences: sl()));

//Firebase
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  //SharedPreference
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}
