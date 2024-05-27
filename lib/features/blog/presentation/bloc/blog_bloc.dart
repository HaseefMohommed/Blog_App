import 'dart:io';

import 'package:blog_app/core/usecase/usercase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/delete_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  final DeleteBlog _deleteBlog;

  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAllBlogs,
    required DeleteBlog deleteBlog,
  })  : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        _deleteBlog = deleteBlog,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogFetchAllBlogs>(_onFetchAllBlogs);
    on<BlogRemoveBlog>(_onDeleteBlog);
  }

  void _onBlogUpload(
    BlogUpload event,
    Emitter<BlogState> emit,
  ) async {
    final response = await _uploadBlog(
      UploadBlogParams(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics,
      ),
    );

    response.fold(
      (faliure) => emit(
        BlogFailure(error: faliure.message),
      ),
      (blog) => emit(BlogUploadSuccess()),
    );
  }

  void _onFetchAllBlogs(
    BlogFetchAllBlogs event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _getAllBlogs(NoParams());

    res.fold(
      (faliure) => emit(BlogFailure(error: faliure.message)),
      (blogs) => emit(BlogsDisplaySuccess(blogs: blogs)),
    );
  }

  void _onDeleteBlog(
    BlogRemoveBlog event,
    Emitter<BlogState> emit,
  ) async {
    final response = await _deleteBlog(DeleteBlogParams(id: event.blogId));

    response.fold(
      (failure) => emit(BlogFailure(error: failure.message)),
      (_) => emit(BlogDeleteSuccess()),
    );
  }
}
