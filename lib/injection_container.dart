import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:almanubis/features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

init() async {


  //Blocs
  sl.registerFactory(() => AuthBloc());

// Use cases
  /*sl.registerLazySingleton(() => Logout(authRepository: sl()));*/


//Repositories
  /*sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(chatDataSource: sl()));*/

  //DataSource
/*  sl.registerLazySingleton<JobDataSource>(() => JobDataSourceImpl(firebaseFirestore: sl()));*/

//Firebase
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);

  //SharedPreference
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}
