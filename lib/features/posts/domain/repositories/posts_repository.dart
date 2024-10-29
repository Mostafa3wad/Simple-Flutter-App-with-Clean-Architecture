import 'package:clean_arch/core/error/failures.dart';
import 'package:clean_arch/features/posts/domain/entities/post_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PostRepository {
  Future<Either<Failure, List<PostEntity>>> getAllPost();
  Future<Either<Failure, Unit>> deletePost(int id);
  Future<Either<Failure, Unit>> updatePost(PostEntity newPost);
  Future<Either<Failure, Unit>> addPost(PostEntity newPost);
}
