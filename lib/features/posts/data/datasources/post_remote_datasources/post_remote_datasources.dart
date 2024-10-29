import 'dart:convert';
import 'package:clean_arch/core/constants/url.dart';
import 'package:clean_arch/core/error/exception.dart';
import 'package:clean_arch/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSources {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost(int postId);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> addPost(PostModel postModel);
}

class PostRemoteDataSourcesImpl implements PostRemoteDataSources {
  final http.Client client;

  PostRemoteDataSourcesImpl(this.client);

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(Uri.parse('$BASE_URL/posts/'),
        headers: {'Content-Type': 'application/json'});
      print('object');
    if (response.statusCode == 200) {
      print('object');
      final List decodeJson = json.decode(response.body) as List;
      final List<PostModel> postModels = decodeJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final response = await client.post(Uri.parse(BASE_URL + '/posts/'),
        body: postModel.toMap());

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
      Uri.parse('$BASE_URL/posts/$postId'),
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final response = await client.patch(Uri.parse('$BASE_URL/posts/${postModel.id}'),
        body: postModel.toMap());
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
