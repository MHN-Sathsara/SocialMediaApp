import 'package:flutter/material.dart';
import '../controllers/post_controller.dart';
import '../models/post.dart';

class EditPostPage extends StatelessWidget {
  final Post post;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController;
  final TextEditingController bodyController;

  EditPostPage({required this.post})
      : titleController = TextEditingController(text: post.title),
        bodyController = TextEditingController(text: post.body);

  @override
  Widget build(BuildContext context) {
    final PostController postController = PostController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Post'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: bodyController,
                decoration: InputDecoration(labelText: 'Body'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the body content';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    postController.updatePost(
                      Post(
                        id: post.id,
                        userId: post.userId,
                        title: titleController.text,
                        body: bodyController.text,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
