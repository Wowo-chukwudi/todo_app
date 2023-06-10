import 'package:flutter/material.dart';
import 'package:todo_app/database/db.dart';
import 'package:todo_app/provider/todo_provider.dart';
import 'package:todo_app/screens/new_todo.dart';
import 'package:todo_app/widgets/todo_card.dart';
import 'package:todo_app/widgets/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final todoprovider = TodoProvider();

  getTodoList() async {
    final data = await SQLHelper.getItems();
    setState(() {
      todoprovider.getList = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTodoList();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const TodoList(),
      Container(),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'MY TODO',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.5,
        shadowColor: Colors.grey.shade300,
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.purple,
          selectedItemColor: Colors.white,
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.checklist), label: 'To-dos'),
            BottomNavigationBarItem(
                icon: Icon(Icons.check), label: 'Completed'),
          ]),
      body: tabs[selectedIndex],
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('New TODO'),
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewTodo()));
        },
      ),
    );
  }
}
