import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_crud_bloc/data/service/api_service.dart';
import 'package:simple_crud_bloc/ui/post_input/bloc/post_input_cubit.dart';
import 'package:simple_crud_bloc/ui/posts/bloc/posts_cubit.dart';

import 'data/repositories/post_repository.dart';

GetIt locator = GetIt.instance;

void setupLocator(){

  //inject network
  locator.registerSingleton(Dio());
  locator.registerSingleton(ApiService(locator<Dio>()));
  locator.registerSingleton(PostRepository(apiClient: locator<ApiService>()));

  locator.registerFactory(() => PostsCubit(repository: locator<PostRepository>()));
  locator.registerFactory(() => PostsInputCubit(repository: locator<PostRepository>()));


}