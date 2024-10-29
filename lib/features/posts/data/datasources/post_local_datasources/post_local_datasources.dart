import 'dart:convert';
import 'package:clean_arch/core/error/exception.dart';
import 'package:clean_arch/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSources {
  Future<List<PostModel>> getCachedPosts();

  Future<Unit> chashPosts(List<PostModel> postModels);
}

class PostLocalDataSourcesImpl implements PostLocalDataSources {
  final SharedPreferences sharedPreferences;

  PostLocalDataSourcesImpl(this.sharedPreferences);

  @override
  Future<Unit> chashPosts(List<PostModel> postModels) async {
    List postModelsToJson = postModels
        .map<Map<String, dynamic>>((postModel) => postModel.toMap())
        .toList();

    sharedPreferences.setString("CASHED_POST", json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString('CASHED_POST');
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodeJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
