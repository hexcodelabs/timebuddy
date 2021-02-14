import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:timebuddy/modals/priority.dart';
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
      await db.execute('''
          CREATE TABLE IF NOT EXISTS priorityList(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT,
            index int,
            priority TEXT
          )
        ''');
    }, version: 1);
  }

  addNewSchedule(List<Task> taskList, String date) async {
    final db = await database;

    var res;

    taskList.forEach((task) async {
      var search = await db.rawQuery('''
        SELECT * FROM daily_tasks WHERE hour=? AND half=? AND date=?
      ''', [task.hour, task.half, task.date]);

      if (search.isNotEmpty) {
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

    return res;
  }

  Future<List<Map<String, dynamic>>> getSchedule(date) async {
    final db = await database;

    var res =
        await db.rawQuery("SELECT * FROM daily_tasks WHERE date=?", [date]);

    if (res.isEmpty) {
      return null;
    } else {
      return res;
    }
  }

  addPriority(List<String> priorityList, String date) async {
    final db = await database;
    List<Priority> prioList = List<Priority>();
    int count = 0;
    priorityList.forEach((element) {
      debugPrint(count.toString());
      prioList.add(Priority(index: count, priority: element));
      count++;
    });

    var res;
    prioList.forEach((priority) async {
      var search = await db.rawQuery('''
        SELECT * FROM priorityList WHERE indexx=? AND date=?
      ''', [priority.index, date]);

      if (search.isNotEmpty) {
        res = await db.rawUpdate('''
      UPDATE priorityList SET
        priority=? 
      WHERE indexx=? AND date=?
    ''', [priority.priority, priority.index, date]);
      } else {
        res = await db.rawInsert('''
      INSERT INTO priorityList(
        date, indexx, priority
      ) VALUES (?, ?, ?)
    ''', [date, priority.index, priority.priority]);
      }
    });

    return res;
  }

  Future<List<Map<String, dynamic>>> getPriorities(date) async {
    final db = await database;
    var res =
        await db.rawQuery("SELECT * FROM priorityList WHERE date=?", [date]);
    debugPrint(res.toString());
    if (res.isEmpty) {
      return null;
    } else {
      return res;
    }
  }
}
