import 'package:flutter/material.dart';

class AddPost extends StatelessWidget {
  const AddPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(),
          TextField(),
          
        ],
      );

  AppBar _buildAppbar() => AppBar(
        backgroundColor: Colors.green[800],
        title: const Text(
          'Posts Page',
          style: TextStyle(color: Colors.white),
        ),
      );
}
