import 'package:clean_arch/features/posts/presentation/bloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatButton(),
    );
  }

  Widget _buildFloatButton() => FloatingActionButton(
        backgroundColor: Colors.green[800],
        onPressed: () {},
        child: const Icon(Icons.add, size: 35, color: Colors.white),
      );

  // Body
  Widget _buildBody() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
          if (state is LoadingPostsState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedPostsState) {
            return ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    minVerticalPadding: 14,
                    onTap: () {},
                    title: Text(
                      state.posts[index].title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      state.posts[index].body,
                    ),
                  );
                });
          } else if (state is ErrorPostsState) {
            return const Center(child: Text('Error'));
          } else {
            return const Center(child: Text('Erfror'));
          }
        }),
      ); 
  AppBar _buildAppbar() => AppBar(
        backgroundColor: Colors.green[800],
        title: const Text(
          'Posts Page',
          style: TextStyle(color: Colors.white),
        ),
      );
}
