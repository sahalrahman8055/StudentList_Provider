
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student_app/model/data_model.dart';

class StudentDbProvider extends ChangeNotifier {
  List<StudentModel> _studentList = [];

  List<StudentModel> get studentList => _studentList;

  Future<void> addStudent(StudentModel value) async {
    final studentDB = await Hive.openBox<StudentModel>("student_db");
    await studentDB.add(value);
    _studentList.add(value);
    notifyListeners();
  }

  Future<void> getAllStudents() async {
    final studentDB = await Hive.openBox<StudentModel>("student_db");
    _studentList.clear();
    _studentList.addAll(studentDB.values);
    notifyListeners();
  }

  Future<void> deleteStudent(index) async {
    final studentDB = await Hive.openBox<StudentModel>("student_db");
    await studentDB.deleteAt(index);
    getAllStudents();
  }

  Future<void> update(index, updation) async {
    final studentDB = await Hive.openBox<StudentModel>("student_db");
    studentDB.putAt(index, updation);
    _studentList[index] = updation;
    notifyListeners();
  }
}

