import 'package:clean_arch/core/error/exception.dart';
import 'package:clean_arch/core/error/failures.dart';
import 'package:clean_arch/core/network/network_info.dart';
import 'package:clean_arch/features/posts/data/datasources/post_local_datasources/post_local_datasources.dart';
import 'package:clean_arch/features/posts/data/datasources/post_remote_datasources/post_remote_datasources.dart';
import 'package:clean_arch/features/posts/data/models/post_model.dart';
import 'package:clean_arch/features/posts/domain/entities/post_entity.dart';
import 'package:clean_arch/features/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

typedef Future<Unit> DeleteOrAddOrUpdatePost();

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSources remoteDataSource;
  final PostLocalDataSources locaoDataSource;
  final NetworkInfo networkInfo;
  PostRepositoryImpl(
      {required this.remoteDataSource,
      required this.locaoDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPost() async {
    if (await networkInfo.isConncted) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        locaoDataSource.chashPosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await locaoDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(PostEntity newPost) async {
    final PostModel postModel =
        PostModel(id: newPost.id, title: newPost.title, body: newPost.body);
    return await _getMessage(() => remoteDataSource.addPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return await _getMessage(() => remoteDataSource.deletePost(id));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(PostEntity newPost) async {
    final PostModel postModel =
        PostModel(id: newPost.id, title: newPost.title, body: newPost.body);
    return await _getMessage(() => remoteDataSource.updatePost(postModel));
  }

  Future<Either<Failure, Unit>> _getMessage( 
      DeleteOrAddOrUpdatePost deleteOrAddOrUpdatePost) async {
    if (await networkInfo.isConncted) {
      try {
        await deleteOrAddOrUpdatePost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left((OffLineFailure()));
    }
  }
}
