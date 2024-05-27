import 'package:blog_app/core/database/database.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class BlogLocalDataSource {
  Future<void> uploadLocalBlogs({required List<BlogModel> blogs});
  Future<List<BlogModel>> loadBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  @override
  Future<List<BlogModel>> loadBlogs() async {
    final db = await DatabaseProvider.dbProvider.database;
    List<Map> maps = await db.query('Blogs');
    return maps
        .map((map) => BlogModel.fromJson(Map<String, dynamic>.from(map)))
        .toList();
  }

  @override
  Future<void> uploadLocalBlogs({required List<BlogModel> blogs}) async {
    final db = await DatabaseProvider.dbProvider.database;
  
    await db.delete('Blogs');
    for (var blog in blogs) {
      await db.insert('Blogs', blog.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }
}
