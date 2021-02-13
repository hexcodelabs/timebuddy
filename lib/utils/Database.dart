import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:timebuddy/modals/task.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), 'timebuddy.db'),
        onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE IF NOT EXISTS daily_tasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT,
            hour TEXT,
            half TEXT,
            task TEXT,
            color TEXT,
            previous TEXT,
            next TEXT
          )
        ''');
    }, version: 1);
  }

  addNewSchedule(List<Task> taskList, String date) async {
    final db = await database;
    debugPrint(taskList.length.toString());
    var res;
    // taskList.forEach((task) async {
    //   debugPrint(
    //       "${task.date}, ${task.hour}, ${task.half}, ${task.task}, ${task.color}");
    // });

    taskList.forEach((task) async {
      var search = await db.rawQuery('''
        SELECT * FROM daily_tasks WHERE hour=? AND half=? AND date=?
      ''', [task.hour, task.half, task.date]);
      debugPrint(res.toString());
      if (search.isNotEmpty) {
        debugPrint("up=" + task.id.toString());
        res = await db.rawUpdate('''
      UPDATE daily_tasks SET
        hour=?, 
        half=?, 
        task=?, 
        color=?,
        previous=?,
        next=?
      WHERE id=?
    ''', [
          task.hour,
          task.half,
          task.task,
          task.color,
          task.previous,
          task.next,
          task.id
        ]);
      } else {
        debugPrint("in=" + task.id.toString());
        res = await db.rawInsert('''
      INSERT INTO daily_tasks(
        date, hour, half, task, color,previous, next
      ) VALUES (?, ?, ?, ?, ?,?,?)
    ''', [
          task.date,
          task.hour,
          task.half,
          task.task,
          task.color,
          task.previous,
          task.next
        ]);
      }
    });
    debugPrint(res);
    return res;
  }

  Future<List<Map<String, dynamic>>> getSchedule(date) async {
    final db = await database;
    debugPrint(date);
    var res =
        await db.rawQuery("SELECT * FROM daily_tasks WHERE date=?", [date]);
    debugPrint("s" + res.isEmpty.toString());
    debugPrint(res.toString());
    if (res.isEmpty) {
      return null;
    } else {
      return res;
    }
  }
}
