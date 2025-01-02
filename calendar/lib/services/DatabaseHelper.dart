import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/Event.dart';

class DatabaseHelper
{
    static final DatabaseHelper _instance = DatabaseHelper._internal();
    factory DatabaseHelper() => _instance;

    static Database? _database;

    DatabaseHelper._internal();

    Future<Database> get database async
    {
        if (_database != null) return _database!;
        _database = await _initDatabase();
        return _database!;
    }

    Future<Database> _initDatabase() async
    {
        final path = join(await getDatabasesPath(), 'events.db');
        return openDatabase(
            path,
            onCreate: (db, version)
            {
                return db.execute(
                    '''
                    CREATE TABLE events(
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        date TEXT,
                        time TEXT,
                        location TEXT,
                        note TEXT
                    )
                    '''
                );
            },
            version: 1
        );
    }

    Future<int> insertEvent(Event event) async
    {
        final db = await database;
        return db.insert('events', event.toMap());
    }

    Future<int> updateEvent(Event event) async
    {
        final db = await database;
        return db.update(
            'events',
            event.toMap(),
            where: 'id = ?',
            whereArgs: [event.id]
        );
    }

    Future<List<Event>> getAllEvents() async
    {
        final db = await database;
        final List<Map<String, dynamic>> maps = await db.query('events');
        return List.generate(maps.length, (i) => Event.fromMap(maps[i]));
    }

    Future<int> deleteEvent(int id) async
    {
        final db = await database;
        return db.delete('events', where: 'id = ?', whereArgs: [id]);
    }
}
