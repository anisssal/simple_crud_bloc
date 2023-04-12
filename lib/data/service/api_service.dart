import 'package:simple_crud_bloc/utils/contants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

import '../models/post_model.dart';

part 'api_service.g.dart';


@RestApi(baseUrl: Constant.baseUrl )
abstract class ApiService {
  factory ApiService(Dio dio) {
    dio.options = BaseOptions(
        receiveTimeout: 10000,
        connectTimeout: 10000,
        contentType: 'application/json',
        headers: {
          'Accept': 'application/json',
        });
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    return _ApiService(dio,);
  }

  @GET('/posts')
  Future<List<PostModel>> getPosts();

  @POST('/posts')
  Future<PostModel> submitPost({ @Body()required PostModel model});

  @PUT('/posts/{id}')
  Future<PostModel> updatePost({@Body() required PostModel model, @Path('id')required int postId});

  @DELETE('/posts/{id}')
  Future<void> deletePosts({@Path('id') required int postId});

}
