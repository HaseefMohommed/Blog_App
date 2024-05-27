// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database? _database;

  Future<Database> get database async {
    _database ??= await createDatabase();
    return _database!;
  }

  Future<Database> createDatabase() async {
    var docDir = await getApplicationDocumentsDirectory();
    String path = join(docDir.path, "BlogDB.db");
    var database = await openDatabase(
      path,
      version: 1, 
      onCreate: initDB,
    );
    return database;
  }

  void initDB(Database database, int version) async {
    
    await database.execute('''
      CREATE TABLE Blogs (
        id TEXT PRIMARY KEY,
        poster_id TEXT,
        title TEXT,
        content TEXT,
        image_url TEXT, 
        topics TEXT,
        updated_at TEXT,
        poster_name TEXT
      )
    ''');
  }
}
