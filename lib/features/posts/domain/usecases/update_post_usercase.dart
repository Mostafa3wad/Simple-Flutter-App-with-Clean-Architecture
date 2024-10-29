import 'package:clean_arch/core/error/failures.dart';
import 'package:clean_arch/features/posts/domain/entities/post_entity.dart';
import 'package:clean_arch/features/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class UpdatePostUsercase {
  final PostRepository repository;
  UpdatePostUsercase({required this.repository});
  
  Future<Either<Failure, Unit>> call(PostEntity newPost) async =>
      await repository.updatePost(newPost);
}
