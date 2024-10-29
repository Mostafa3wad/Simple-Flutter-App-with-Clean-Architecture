import 'package:clean_arch/features/posts/presentation/bloc/posts_bloc.dart';
import 'package:clean_arch/features/posts/presentation/pages/posts_page.dart';
import 'package:clean_arch/injection_contaoner.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
    ],
    child: const MaterialApp(
      home: PostsPage(),
    ),
  ));
}
