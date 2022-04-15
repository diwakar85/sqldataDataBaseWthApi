import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../modelClass/apiModel.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper dbHelper = DBHelper._();

  static const table ='Post';
  static const id = 'id';
  static const title = 'title';
  static const body = 'body';

  Database? db;

  Future<Database?> initDB() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'student.db');

    if (db != null) {
      return db;
    } else {
      db = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) {
          String query =
              "CREATE TABLE IF NOT EXISTS $table($id INTEGER PRIMARY KEY AUTOINCREMENT , $title TEXT , $body TEXT)";
          return db.execute(query);
        },
      );
      return db;
    }
  }

  Future<int> insert(Post data) async {
    db = await initDB();

    String query = "INSERT or IGNORE INTO $table($id, $title ,$body) VALUES(?, ?, ?)";

    List args = [
      data.id,
      data.title,
      data.body,
    ];
    return await db!.rawInsert(query, args);
  }

  Future<int> insertPost(Post post) async {
    db = await initDB();
    String query = "INSERT INTO $table($id, $title ,$body) VALUES(?, ?, ?)";
    List args = [
      post.id,
      post.title,
      post.body,
    ];
    return await db!.rawInsert(query, args);
  }

  Future<List<Post>> fetchAllData() async {
    db = await initDB();
    String query = "SELECT * FROM $table";
    List response = await db!.rawQuery(query);
    return response.map((e) => Post.formJson(e)).toList();
  }

  Future<List<Post>> fetchSearchedData(String val) async {
    db = await initDB();

    String query = "SELECT * FROM $table WHERE title LIKE '%$val%'";

    List response = await db!.rawQuery(query);

    return response.map((e) => Post.formJson(e)).toList();
  }
}
