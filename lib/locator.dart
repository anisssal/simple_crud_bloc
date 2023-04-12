import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_crud_bloc/data/service/api_service.dart';

import 'data/repositories/post_repository.dart';

GetIt locator = GetIt.instance;

void setupLocator(){

  //inject network
  locator.registerSingleton(Dio());
  locator.registerSingleton(ApiService(locator<Dio>()));
  locator.registerSingleton(PostRepository(apiClient: locator<ApiService>()));



}