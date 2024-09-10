// screens/home_screen.dart

import 'package:flutter/material.dart';
import '../models/post.dart';
import '../widgets/post_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Post> _posts = [
    Post(
      id: '1',
      title: 'First Post',
      content: 'This is the content of the first post.',
      author: 'User1',
      // comments: [
      //   Comment(
      //     id: '1',
      //     content: 'Hello world!',
      //     author: 'User2',
      //     timestamp: Timestamp.fromDate(DateTime.now().subtract(const Duration(hours: 3))),
      //   ),
      //   Comment(
      //     id: '2',
      //     content: 'Loram Ipsum',
      //     author: 'User3',
      //     timestamp: Timestamp.fromDate(DateTime.now().subtract(const Duration(hours: 3))),
      //   ),
      // ],
    ),
    Post(
      id: '2',
      title: 'What is this iphone?',
      imageUrl:
          'https://images.pexels.com/photos/699122/pexels-photo-699122.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      content:
          'The iPhone is a revolutionary smartphone developed by Apple Inc. It combines a sleek design with powerful features, including a high-resolution touchscreen, advanced camera capabilities, and access to millions of apps through the App Store. Since its introduction in 2007, the iPhone has continually evolved, offering improved performance, enhanced security features, and innovative technologies like Face ID and 5G connectivity. It remains one of the most popular and influential devices in the mobile industry.',
      author: 'Robbert',
    ),
    Post(
      id: '3',
      title: 'Bootstrap',
      imageUrl:
          'https://designmodo.com/wp-content/uploads/2021/03/bootstrap-5-layout.jpg',
      content:
          'Bootstrap is a popular open-source front-end framework developed by Twitter. It provides a comprehensive set of pre-built components, responsive grid system, and JavaScript plugins that simplify the process of creating responsive and mobile-first websites. With its extensive documentation and large community support, Bootstrap enables developers to quickly build attractive and consistent user interfaces across various devices and screen sizes.',
      author: 'RandomUser123',
    ),
    // Add more posts as needed
  ];

  void _addPost() {
    // Code to add a new post goes here
    // Update the _posts list and call setState()
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Not Reddit', style: TextStyle(color: Colors.red)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addPost,
          ),
        ],
      ),
      body: PostList(
        posts: _posts,
      ),
    );
  }
}
