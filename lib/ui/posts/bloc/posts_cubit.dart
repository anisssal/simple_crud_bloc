
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_crud_bloc/data/models/post_model.dart';
import 'package:simple_crud_bloc/data/repositories/post_repository.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostRepository _repo ;

  PostsCubit({required PostRepository repository})
      : _repo = repository , super(const PostsState(status: PostsStatus.initial, posts: []));

  void init() {
    getPosts();
  }

  Future<void> getPosts() async {
    emit(state.copyWith(status: PostsStatus.loading));

    final result = await _repo.getPosts();
    if (result.data != null) {
      emit(state.copyWith(
          posts: result.data, status: PostsStatus.success));
    } else if (result.getException != null) {
      emit(state.copyWith(
        errorMessage: result.getException!.getErrorMessage(),
        status: PostsStatus.failure,
      ));
    }
  }
}

class PostsState extends Equatable {
  final PostsStatus status;

  final List<PostModel> posts;
  final String? errorMessage;

  const PostsState(
      {required this.status,required this.posts, this.errorMessage});

  PostsState copyWith({
    PostsStatus? status,
    List<PostModel>? posts,
    String? errorMessage,
  }) {
    return PostsState(
        status: status ?? this.status,
        posts: posts ?? this.posts,
        errorMessage: errorMessage);
  }

  @override
  List<Object?> get props => [status, posts, errorMessage];
}

enum PostsStatus { initial, success, loading, failure }

extension PostsStatusX on PostsStatus {
  bool get isInitial => this == PostsStatus.initial;

  bool get isLoading => this == PostsStatus.loading;

  bool get isSuccess => this == PostsStatus.success;

  bool get isFailure => this == PostsStatus.failure;
}