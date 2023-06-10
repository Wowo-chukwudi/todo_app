import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/provider/todo_provider.dart';
import 'package:todo_app/screens/new_todo.dart';

class TodoCard extends StatelessWidget {
  final List<Map<String, dynamic>> todoListt;
  const TodoCard({super.key, required this.todoListt});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    final todoList = todoListt;
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          final todos = todoList[index];

          return Card(
            elevation: 1.5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Slidable(
                startActionPane: ActionPane(
                  extentRatio: 0.3,
                  motion: SlidableAction(
                    onPressed: (_) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewTodo(
                            id: todos['id'],
                          ),
                        ),
                      );
                    },
                    icon: Icons.edit,
                    label: 'Edit',
                    backgroundColor: Colors.green,
                  ),
                  children: [
                    Icon(Icons.edit),
                  ],
                ),
                endActionPane: ActionPane(
                  extentRatio: 0.3,
                  motion: SlidableAction(
                    onPressed: (_) {
                      provider.deleteItem(todos['id']);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Todo successfully deleted')));
                    },
                    icon: Icons.delete,
                    label: 'Delete',
                    backgroundColor: Colors.red,
                  ),
                  children: [
                    Icon(Icons.edit),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, top: 12, bottom: 12),
                  child: Row(
                    children: [
                      Checkbox(
                        value: provider.isDone,
                        onChanged: (_) {},
                        checkColor: Colors.purple,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            todos['title'],
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                          if (todos['note'].isNotEmpty) Text(todos['note']),
                          const SizedBox(
                            height: 15,
                          ),
                          if (todos['date'].isNotEmpty ||
                              todos['time'].isNotEmpty)
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      size: 15,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(todos['date']),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.watch,
                                      size: 15,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(todos['time']),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
          ;
        });
  }
}
