import 'package:bloc/bloc.dart';
import 'package:clean_arch/core/constants/massages.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:clean_arch/core/constants/failures.dart';
import 'package:clean_arch/core/error/failures.dart';
import 'package:clean_arch/features/posts/domain/entities/post_entity.dart';
import 'package:clean_arch/features/posts/domain/usecases/add_post_usercase.dart';
import 'package:clean_arch/features/posts/domain/usecases/delete_post_usecase.dart';
import 'package:clean_arch/features/posts/domain/usecases/get_all_posts_usecase.dart';
import 'package:clean_arch/features/posts/domain/usecases/update_post_usercase.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostUsercase getAllPosts;
  final AddPostUsercase addPost;
  final DeletePostUsercase deletePost;
  final UpdatePostUsercase updatePost;

  PostsBloc({
    required this.getAllPosts,
    required this.addPost,
    required this.deletePost,
    required this.updatePost,
  }) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent || event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        
        final failureOrPosts = await getAllPosts();
        emit(_mapFailureOrPostState(failureOrPosts));
      } else if (event is AddPostEvent) {
        final failuerOrDoneMessage = await addPost(event.post);
        emit(_mapFailureOrAddDelelteUpdatePostState(
            failuerOrDoneMessage, ADD_SUCCESS_MESSAGE));
        emit(LoadingPostsState());
      } else if (event is DeletePostEvent) {
        final failuerOrDoneMessage = await deletePost(event.postId);
        emit(_mapFailureOrAddDelelteUpdatePostState(
            failuerOrDoneMessage, ADD_SUCCESS_MESSAGE));
        emit(LoadingPostsState());
      } else if (event is UpdatePostEvent) {
        final failuerOrDoneMessage = await updatePost(event.post);
        emit(_mapFailureOrAddDelelteUpdatePostState(
            failuerOrDoneMessage, ADD_SUCCESS_MESSAGE));
        emit(LoadingPostsState());
      }
    });
  }

  PostsState  _mapFailureOrPostState(Either<Failure, List<PostEntity>> either) {
    return either.fold(
        (failure) => ErrorPostsState(message: _mapFailureToMessage(failure)),
        (posts) => LoadedPostsState(posts: posts));
  }

  PostsState _mapFailureOrAddDelelteUpdatePostState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
        (failure) => ErrorPostsState(message: _mapFailureToMessage(failure)),
        (posts) => DoneMessageState(message: message));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FALIUER_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CHACHE_FALIURE_MESSAGE;
      case OffLineFailure:
        return OFFLINE_FALIURE_MESSAGE;
      default:
        return 'Unexpedted Error , Please try again leter .';
    }
  }
}
