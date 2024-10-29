import 'package:clean_arch/core/network/network_info.dart';
import 'package:clean_arch/features/posts/data/datasources/post_local_datasources/post_local_datasources.dart';
import 'package:clean_arch/features/posts/data/datasources/post_remote_datasources/post_remote_datasources.dart';
import 'package:clean_arch/features/posts/data/repositories/post_repository_impt.dart';
import 'package:clean_arch/features/posts/domain/repositories/posts_repository.dart';
import 'package:clean_arch/features/posts/domain/usecases/add_post_usercase.dart';
import 'package:clean_arch/features/posts/domain/usecases/delete_post_usecase.dart';
import 'package:clean_arch/features/posts/domain/usecases/get_all_posts_usecase.dart';
import 'package:clean_arch/features/posts/domain/usecases/update_post_usercase.dart';
import 'package:clean_arch/features/posts/presentation/bloc/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;
Future<void> init() async {
  //! features - Posts

  // bloc
  sl.registerFactory(() => PostsBloc( getAllPosts: sl(), addPost: sl(), deletePost: sl(), updatePost: sl()));

  //Usecase
  sl.registerLazySingleton(() => GetAllPostUsercase(sl()));
  sl.registerLazySingleton(() => AddPostUsercase(repository: sl()));
  sl.registerLazySingleton(() => DeletePostUsercase(repository: sl()));
  sl.registerLazySingleton(() => UpdatePostUsercase(repository: sl()));
  // repositories
  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(
        remoteDataSource: sl(),
        locaoDataSource: sl(),
        networkInfo: sl(),
      ));

// Datasources

  sl.registerLazySingleton<PostRemoteDataSources>(
      () => PostRemoteDataSourcesImpl(sl()));
  sl.registerLazySingleton<PostLocalDataSources>(
      () => PostLocalDataSourcesImpl(sl()));

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
