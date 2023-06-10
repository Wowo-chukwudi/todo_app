import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/provider/todo_provider.dart';
import 'package:todo_app/widgets/todo_card.dart';

import '../database/db.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    final todos = provider.getList;
    return todos.isEmpty
        ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.checklist_outlined,
                    size: 25,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'No Todos',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
          )
        : TodoCard(
            todoListt: provider.getList,
          );
  }
}
