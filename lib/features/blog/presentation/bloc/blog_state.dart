part of 'blog_bloc.dart';

abstract class BlogState {}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogFailure extends BlogState {
  final String error;
  BlogFailure({required this.error});
}

class BlogUploadSuccess extends BlogState {}

class BlogsDisplaySuccess extends BlogState {
  final List<Blog> blogs;
  BlogsDisplaySuccess({required this.blogs});
}

class BlogDeleteSuccess extends BlogState{}
