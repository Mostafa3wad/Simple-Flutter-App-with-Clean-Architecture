part of 'posts_bloc.dart';

sealed class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class GetAllPostsEvent extends PostsEvent {}

class RefreshPostsEvent extends PostsEvent {}

class AddPostEvent extends PostsEvent {
  final PostEntity post;
  const AddPostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class DeletePostEvent extends PostsEvent {
  final int postId;
  const DeletePostEvent({required this.postId});
  @override
  List<Object> get props => [postId];
}

class UpdatePostEvent extends PostsEvent {
  final PostEntity post;
  const UpdatePostEvent({required this.post});

  @override
  List<Object> get props => [post];
}
