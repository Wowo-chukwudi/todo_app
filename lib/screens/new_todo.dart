import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/provider/todo_provider.dart';

class NewTodo extends StatefulWidget {
  int? id;
  NewTodo({super.key, this.id});

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    if (widget.id != null) {
      final existingItem =
          provider.getList.firstWhere((element) => element['id'] == widget.id);
      provider.titleControl.text = existingItem['title'];
      provider.noteControl.text = existingItem['note'];
      provider.dateControl.text = existingItem['date'];
      provider.timeControl.text = existingItem['time'];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new TODO'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              //title
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: provider.titleControl,
                  style: const TextStyle(
                      decoration: TextDecoration.none,
                      decorationThickness: 0.0),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 20),
                    labelText: 'Title',
                    labelStyle: const TextStyle(fontWeight: FontWeight.w700),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              //note
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 100,
                child: TextFormField(
                  controller: provider.noteControl,
                  maxLines: null,
                  minLines: 5,
                  //expands: true,
                  style: const TextStyle(
                      decoration: TextDecoration.none,
                      decorationThickness: 0.0),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 20, top: 20),
                    labelText: 'Write a note',
                    labelStyle: const TextStyle(fontWeight: FontWeight.w700),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              //note
              const SizedBox(
                height: 25,
              ),
              //datepicker

              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        controller: provider.dateControl,
                        style: const TextStyle(
                            decoration: TextDecoration.none,
                            decorationThickness: 0.0),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 20),
                          labelText: 'Date',
                          labelStyle:
                              const TextStyle(fontWeight: FontWeight.w700),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime
                                  .now(), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('dd-MM-yyyy').format(pickedDate);

                            setState(() {
                              provider.dateControl.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        controller: provider.timeControl,
                        style: const TextStyle(
                            decoration: TextDecoration.none,
                            decorationThickness: 0.0),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 20),
                          labelText: 'Time',
                          labelStyle:
                              const TextStyle(fontWeight: FontWeight.w700),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        readOnly: true,
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );

                          if (pickedTime != null) {
                            provider.timeControl.text =
                                pickedTime.format(context);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              //row of start and end time
              //colorpicker
              //save
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                  height: 60,
                  width: 150,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (widget.id == null) {
                          await provider.addItem(
                              provider.titleControl.text,
                              provider.noteControl.text,
                              provider.dateControl.text,
                              provider.timeControl.text,
                              provider.isDone);
                        }
                        if (widget.id != null) {
                          await provider.updateItem(
                              widget.id,
                              provider.titleControl.text,
                              provider.noteControl.text,
                              provider.dateControl.text,
                              provider.timeControl.text,
                              provider.isDone);
                        }
                        widget.id = null;

                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.purple),
                      child: Text(
                        widget.id == null ? 'SAVE' : 'UPDATE',
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w900),
                      ))),
              TextButton(
                  onPressed: () {
                    provider.titleControl.text = '';
                    provider.noteControl.text = '';
                    provider.dateControl.text = '';
                    provider.timeControl.text = '';
                    isDone = false;

                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
            ],
          ),
        ),
      ),
    );
  }
}
