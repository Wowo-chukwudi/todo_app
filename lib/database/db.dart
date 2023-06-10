import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  static Future<void> createTables(Database database) async {
    await database.execute('''CREATE TABLE todoTable (
          id INTEGER PRIMARY KEY,
          title TEXT, 
          note TEXT, 
          date TEXT,
          time TEXT,
          done INTEGER,
          createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
          )''');
  }

  static Future<Database> db() async {
    return openDatabase(
      'todoTable.db',
      version: 1,
      onCreate: (db, version) async {
        await createTables(db);
      },
    );
  }

  //createItem
  static Future<int> createItem(String title, String? note, String? date,
      String? time, bool? done) async {
    final db = await SQLHelper.db(); //database connection

    final data = {
      'title': title,
      'note': note,
      'date': date,
      'time': time,
      'done': done,
    };

    final id = await db.insert('todoTable', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  //Retrieve all Items
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();

    return db.query('todoTable', orderBy: 'id');
  }

  //Retrieve 1 Item
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();

    return db.query('todoTable', where: 'id =? ', whereArgs: [id], limit: 1);
  }

  //Update
  static Future<int> updateItem(int? id, String title, String? note,
      String? date, String? time, bool? done) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'note': note,
      'date': date,
      'time': time,
      'done': done,
      'createdAt': DateTime.now().toString()
    };
    final result =
        await db.update('todoTable', data, where: 'id =? ', whereArgs: [id]);

    return result;
  }

  //Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();

    try {
      await db.delete('todoTable', where: 'id =? ', whereArgs: [id]);
    } catch (e) {
      debugPrint('Something went wrong: $e');
    }
  }
}
