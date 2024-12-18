
import 'package:flutter/foundation.dart';
import 'package:flutter_project_2/caching/models/news_modal.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  // create or open a new database
  static Future<Database> createDatabase() async {
    return await openDatabase(
      "hacker_news.db",
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE news (id INTEGER PRIMARY KEY,title TEXT, url TEXT, author VARCAR(255), updatedAt TEXT)');

        await db.execute(
            'CREATE TABLE saved_time (page_no INTEGER PRIMARY KEY, lastSavedTime DATETIME)');
      },
    );
  }

  // insert new news to the database
  static Future insertNews(NewsModal newsModal) async {
    var db = await createDatabase();

    return await db.insert(
        "news",
        {
          "id": newsModal.id,
          "title": newsModal.title,
          "url": newsModal.url,
          "author": newsModal.author,
          "updatedAt": newsModal.updatedAt
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // read latest 15 news from the local database
  static Future<List<Map<String, dynamic>>> getNews() async {
    var db = await createDatabase();
    return await db.query(
      "news",
      orderBy: 'updatedAt DESC',
      limit: 15,
    );
  }

  // get more data but in limit of 15
  static Future<List<Map<String, dynamic>>> getMoreNews(int lastNo) async {
    var db = await createDatabase();
    return await db.query("news",
        orderBy: 'updatedAt DESC', limit: 15, offset: lastNo);
  }

  // count the number of news inside database
  static Future<int?> getNewsCount() async {
    var db = await createDatabase();
    return Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM news"));
  }

  // delete all news from local database
  static Future deleteAllNews() async {
    var db = await createDatabase();
    return await db.delete("news");
  }

  // insert time after saving to the database
  static Future insertSaveTime(int pageNo) async {
    var db = await createDatabase();
    return await db.insert("saved_time",
        {"page_no": pageNo, "lastSavedTime": DateTime.now().toString()},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //  get the saved time of each page
  static Future<List<Map<String, dynamic>>> getSaveTime() async {
    var db = await createDatabase();
    var data = await db.query("saved_time");
    print(data);
    return data;
  }

  // delete the saved time table
  static Future deleteSavedTime() async {
    var db = await createDatabase();
    return await db.delete("saved_time");
  }
}