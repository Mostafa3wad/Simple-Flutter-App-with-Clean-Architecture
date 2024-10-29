import 'package:clean_arch/core/error/failures.dart';
import 'package:clean_arch/features/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class DeletePostUsercase {
  final PostRepository repository;

  DeletePostUsercase({required this.repository});
  Future<Either<Failure, Unit>> call(int id) async =>await repository.deletePost(id);
}
