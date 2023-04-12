import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_crud_bloc/data/models/base/base_dto_model.dart';
import 'package:simple_crud_bloc/data/models/post_model.dart';
import 'package:simple_crud_bloc/data/repositories/post_repository.dart';

class PostsInputCubit extends Cubit<PostsInputState> {
  final PostRepository _repo;

  PostsInputCubit({required PostRepository repository})
      : _repo = repository,
        super(const PostsInputState(
            status: PostsInputStatus.initial,
            isEditMode: false,
            deleteStatus: PostsInputStatus.initial));

  void init({PostModel? post}) {
    emit(state.copyWith(
        post: post ?? PostModel(), isEditMode: post != null ? true : false));
  }

  Future<void> submitPostInput() async {
    emit(state.copyWith(status: PostsInputStatus.loading));

    BaseDTOModel<PostModel> result;
    if (state.isEditMode) {
      result =
          await _repo.updatePost(data: state.post!, postId: state.post!.id!);
    } else {
      result = await _repo.savePost(
        data: state.post!,
      );
    }
    if (result.data != null) {
      emit(state.copyWith(status: PostsInputStatus.success));
    } else if (result.getException != null) {
      emit(state.copyWith(
        errorMessage: result.getException!.getErrorMessage(),
        status: PostsInputStatus.failure,
      ));
    }
  }

  void setPostTitle(String title) =>
      emit(state.copyWith(post: state.post!.copyWith(title: title)));

  void setPostBody(String body) =>
      emit(state.copyWith(post: state.post!.copyWith(body: body)));
}

class PostsInputState extends Equatable {
  final PostsInputStatus status;
  final PostsInputStatus deleteStatus;

  final PostModel? post;
  final String? errorMessage;
  final bool isEditMode;

  const PostsInputState(
      {required this.status,
      required this.deleteStatus,
      this.post,
      this.errorMessage,
      required this.isEditMode});

  PostsInputState copyWith({
    PostsInputStatus? status,
    PostModel? post,
    String? errorMessage,
    bool? isEditMode,
  }) {
    return PostsInputState(
        status: status ?? this.status,
        deleteStatus: deleteStatus ?? this.deleteStatus,
        post: post ?? this.post,
        isEditMode: isEditMode ?? this.isEditMode,
        errorMessage: errorMessage);
  }

  @override
  List<Object?> get props => [status, deleteStatus, post, errorMessage];
}

enum PostsInputStatus { initial, success, loading, failure }

extension PostsInputStatusX on PostsInputStatus {
  bool get isInitial => this == PostsInputStatus.initial;

  bool get isLoading => this == PostsInputStatus.loading;

  bool get isSuccess => this == PostsInputStatus.success;

  bool get isFailure => this == PostsInputStatus.failure;
}
