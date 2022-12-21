import 'dart:math';

import 'package:flutter/material.dart';
import 'package:semi_finals/models/todo.dart';

class TodoForm extends StatefulWidget {

  final int listLength;

  const TodoForm({
    Key? key,
    required this.listLength
  }) : super(key: key);

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {

  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  int randomId = Random().nextInt(2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add To do")
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: TextFormField(
              controller: titleController,
              maxLines: 5,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                labelText: "Title",
                border: const OutlineInputBorder(),
                suffix: IconButton(
                  onPressed: () {
                    if(formKey.currentState!.validate()) {
                      Todo newTodo = Todo(
                        id: widget.listLength + 1,
                        userId: randomId,
                        title: titleController.text,
                        completed: false
                      );

                      Navigator.pop(context, newTodo);
                    }
                  },
                  icon: const Icon(Icons.check_circle_outline_rounded),
                )
              ),
              validator: (value) {
                return value == null || value.isEmpty ? "Enter title" : null;
              },
            )
          ),
        ),
      )
    );
  }
}
