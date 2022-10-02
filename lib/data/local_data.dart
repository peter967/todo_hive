import 'dart:io';

import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class ToDoData {
  List toDoList = [];

  final _myBox = Hive.box('mybox');
  void createInitialData() {
    toDoList = [];
  }

  void getData() {
    toDoList = _myBox.get('TODOLIST');
  }

  void updateData() {
    _myBox.put('TODOLIST', toDoList);
  }
}
