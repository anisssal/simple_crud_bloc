import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:simple_crud_bloc/data/models/post_model.dart';

import '../models/base/base_dto_model.dart';
import '../models/base/server_error.dart';
import '../service/api_service.dart';

class PostRepository {
  final ApiService _apiClient;

  PostRepository({
    required ApiService apiClient,
  }) : _apiClient = apiClient;

  Future<BaseDTOModel<List<PostModel>>> getPosts() async {
    try {
      List<PostModel> response = await _apiClient.getPosts();
      return BaseDTOModel()..data = response;
    } on DioError catch (error) {
      return BaseDTOModel()..setException(ServerError.withError(error: error));
    } catch (error, stacktrace) {
      if(kReleaseMode) {
        log("Error => $stacktrace");
      }
      return BaseDTOModel()..setException(ServerError.withError(error: error));
    }
  }

  Future<BaseDTOModel<PostModel>> savePost({
    required PostModel data,
  }) async {
    try {
      PostModel response = await _apiClient.submitPost(model: data);
      return BaseDTOModel()..data = response;
    } on DioError catch (error) {
      return BaseDTOModel()..setException(ServerError.withError(error: error));
    } catch (error, stacktrace) {
      if(kReleaseMode) {
        log("Error => $stacktrace");
      }
      return BaseDTOModel()..setException(ServerError.withError(error: error));
    }
  }

  Future<BaseDTOModel<PostModel>> updatePost({
    required PostModel data,
    required int postId,
  }) async {
    try {
      PostModel response = await _apiClient.updatePost(model: data,postId: postId);
      return BaseDTOModel()..data = response;
    } on DioError catch (error) {
      return BaseDTOModel()..setException(ServerError.withError(error: error));
    } catch (error, stacktrace) {
      if(kReleaseMode) {
        log("Error => $stacktrace");
      }
      return BaseDTOModel()..setException(ServerError.withError(error: error));
    }
  }

  Future<BaseDTOModel<bool>> deletePost({
    required int postId,
  }) async {
    try {
      await _apiClient.deletePosts(postId: postId);
      return BaseDTOModel()..data = true;
    } on DioError catch (error) {
      return BaseDTOModel()..setException(ServerError.withError(error: error));
    } catch (error, stacktrace) {
      if(kReleaseMode) {
        log("Error => $stacktrace");
      }
      return BaseDTOModel()..setException(ServerError.withError(error: error));
    }
  }
}
