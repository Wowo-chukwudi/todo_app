import 'package:flutter/material.dart';
import 'package:todo_app/database/db.dart';

import '../models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  TextEditingController titleControl = TextEditingController();
  TextEditingController noteControl = TextEditingController();
  TextEditingController dateControl = TextEditingController();
  TextEditingController timeControl = TextEditingController();

  List<TodoModel> _todos = [];
  List<Map<String, dynamic>> getList = [];
  bool isLoading = true;
  bool isDone = false;

  List<TodoModel> get todos =>
      _todos.where((todo) => todo.isDone == false).toList();

  void showList() async {
    getList = await SQLHelper.getItems();
  }

  void refreshTodoList() async {
    final data = await SQLHelper.getItems();
    getList = data;
    isLoading = false;
    notifyListeners();
  }

  addItem(String title, String? note, String? date, String? time,
      bool? isDone) async {
    await SQLHelper.createItem(title, note, date, time, isDone);
    titleControl.text = '';
    noteControl.text = '';
    dateControl.text = '';
    timeControl.text = '';
    isDone = false;
    refreshTodoList();
  }

  updateItem(int? id, String title, String? note, String? date, String? time,
      bool? isDone) async {
    await SQLHelper.updateItem(id, title, note, date, time, isDone);

    titleControl.text = '';
    noteControl.text = '';
    dateControl.text = '';
    timeControl.text = '';
    isDone = false;
    refreshTodoList();
  }

  deleteItem(int id) async {
    await SQLHelper.deleteItem(id);

    refreshTodoList();
  }
}


// TodoModel(createdTime: DateTime.now(), title: 'Share the app'),
//     TodoModel(
//         title: 'Food for the day',
//         createdTime: DateTime.now(),
//         date: '08-06-2023',
//         time: '6:56PM',
//         note:
//             '- Breakfast: Egg and Tea\n- Lunch: Swallow and soup\n- Dinner: Ogi and Fish'),
//     TodoModel(
//         title: 'Read book',
//         createdTime: DateTime.now(),
//         date: '12-06-2023',
//         time: '3:56PM',
//         note: '''Flutter apperentice'''),