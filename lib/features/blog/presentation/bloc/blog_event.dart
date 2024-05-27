part of 'blog_bloc.dart';

abstract class BlogEvent {}

class BlogUpload extends BlogEvent {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  BlogUpload({
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });
}

class BlogRemoveBlog extends BlogEvent {
  final String blogId;
  BlogRemoveBlog({
    required this.blogId,
  });

  
}

class BlogFetchAllBlogs extends BlogEvent {}
