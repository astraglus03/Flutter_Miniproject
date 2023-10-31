import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database? _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    String? databasesPath = await getDatabasesPath();
    String path = join(databasesPath!, 'your_database_name.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    // Create your tables here
    await db.execute('''
      CREATE TABLE YourTableName (
        id INTEGER PRIMARY KEY,
        date TEXT,
        transportation TEXT,
        time TEXT,
        caltime TEXT,
        type TEXT,
        location TEXT,
        locationtext TEXT,
        currentLocation TEXT,
        distance TEXT,
        description TEXT
      )
    ''');
  }

  // Insert operation
  Future<int> insert(Map<String, dynamic> row) async {
    Database dbClient = await db;
    int id = await dbClient.insert('YourTableName', row);
    print('Inserted row id: $id'); // 삽입된 데이터의 ID를 출력
    return id;
  }
  Future<List<Map<String, dynamic>>> queryAll() async {
    Database dbClient = await db;
    return await dbClient.query('YourTableName');
  }


}
