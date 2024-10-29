import 'package:clean_arch/core/error/failures.dart';
import 'package:clean_arch/features/posts/domain/entities/post_entity.dart';
import 'package:clean_arch/features/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllPostUsercase {
  final PostRepository repository;

  GetAllPostUsercase(this.repository);

  Future<Either<Failure, List<PostEntity>>> call() async =>
      await repository.getAllPost();
}
