import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add To do")
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(

          ),
        ),
      )
    );
  }
}
