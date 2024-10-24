import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart'as sql;

class SQLHelper{

  static Future<void> createtables(sql.Database database) async {
    await database.execute("""CREATE TABLE data(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      nombre TEXT,
      profesor TEXT,
      aula TEXT,
      horas INTEGER,
      grupo TEXT,
      createAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }
  static Future<sql.Database> db () async{
    return sql.openDatabase("database_name.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      await createtables(database); 
    });
  }
  static Future<int> createData(String nombre, String? profesor, String? aula, int? horas, String? grupo  ) async {
    final db = await SQLHelper.db();

    final data = {'nombre': nombre, 'profesor': profesor, 'aula': aula, 'horas': horas, 'grupo': grupo};
    final id = await db.insert('data', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await SQLHelper.db();
    return db.query('data', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getSingleData(int id) async {
    final db = await SQLHelper.db();
    return db.query('data', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future <int> updateData(int id, String nombre, String? profesor, String? aula, int? horas, String? grupo) async {
    final db = await SQLHelper.db();
    final data = {
      'nombre': nombre,
      'profesor': profesor,
      'aula': aula,
      'horas': horas,
      'grupo': grupo,
      'createAt': DateTime.now().toString()
    };
    final result = 
          await db.update('data', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteData(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("data", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}