import 'dart:io';

import 'package:flutter/services.dart';
import 'package:parent_app/models/student.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DigiLocalSql {


  Future<List<Student>> getAllStudents() async {
    // Construct the path to the app's writable database file:
    var dbDir = await getDatabasesPath();
    var dbPath = join(dbDir, "parent_app.db");

    // Delete any existing database:
    //await deleteDatabase(dbPath);

    ByteData data = await rootBundle.load("assets/sqlite/local_data_parent_app.db");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);
    var db = await openDatabase(dbPath);
    var res = await db.rawQuery("select * from student");
    List<Student> list =
        res.isNotEmpty ? res.map((c) => Student.fromMap(c)).toList() : [];
        // print(list.length);
    return list;
}
}