import 'dart:io';

import 'package:blog_app/core/error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:blog_app/features/blog/data/models/blog_model.dart';

abstract class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blogModel);
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });
  Future<List<BlogModel>> getAllBlogs();
  Future<void> deleteBlogById(String id);
}

class BlogRemoteDataSourceImp extends BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImp({
    required this.supabaseClient,
  });

  @override
  Future<BlogModel> uploadBlog(BlogModel blogModel) async {
    try {
      final blogData = await supabaseClient
          .from('blogs')
          .insert(blogModel.toJson(isFromSupabase: true))
          .select();

      return BlogModel.fromJson(blogData.first, isFromSupabase: true);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(
            blog.id,
            image,
          );

      return supabaseClient.storage.from('blog_images').getPublicUrl(
            blog.id,
          );
    } on StorageException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final response = await supabaseClient
          .from('blogs')  
          .select('*, profiles (name)')
          // ignore: deprecated_member_use
          .execute();
      final dataList = response.data as List<dynamic>;
      final blogs = dataList.map((blog) {
        return BlogModel.fromJson(
          isFromSupabase: true,
          Map<String, dynamic>.from(blog),
        ).copyWith(
          posterName: blog['profiles']['name'],
        );
      }).toList();
      return blogs.cast<BlogModel>();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteBlogById(String id) async {
    try {
      // ignore: deprecated_member_use
      await supabaseClient.from('blogs').delete().eq('id', id).execute();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
