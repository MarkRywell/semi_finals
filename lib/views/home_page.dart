import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:semi_finals/models/todo.dart';
import 'package:semi_finals/views/todo_form.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  List todos = [];
  late AnimationController animationController;
  late var colorTween;

  Future <dynamic> fetchData (String link) async {

    var url = Uri.parse(link);

    var response = await http.get(url);

    if(response.statusCode == 200) {

      var jsonResponse = convert.jsonDecode(response.body);

      return jsonResponse.isNotEmpty ?
        List.generate(jsonResponse.length, (i){

          return Todo(
              id: jsonResponse[i]['id'],
              userId: jsonResponse[i]['userId'],
              title: jsonResponse[i]['title'],
              completed: jsonResponse[i]['completed'],
          );

        }) : [];

    }
    else {
      Exception("Error with a status code: ${response.statusCode}");
    }
  }

  status (bool completed) {
    return completed == true ?
    const Icon(Icons.check_circle_outline_rounded, color: Colors.green) :
    const Icon(Icons.check_circle_outline_rounded);
  }

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2)
    );
    colorTween = animationController.drive(
      ColorTween(
        begin: Colors.grey,
        end: Colors.indigo
      ));
    animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do")
      ),
      body: FutureBuilder(
        future: fetchData('https://jsonplaceholder.typicode.com/todos'),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasError) {
              return const Center(
                child: Text("Error Fetching Data",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ))
              );
            }
            if (snapshot.hasData) {

              todos.isEmpty ? todos = snapshot.data! : null;

              return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {

                    final todo = todos[index];

                    return ListTile(
                      title: Text(todo.title),
                      leading: (status(todo.completed)),
                    );
                  }
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(
              valueColor: colorTween,
            )
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Todo newTodo = await Navigator.push(
              context,
          MaterialPageRoute(builder: (context) => TodoForm(listLength: todos.length)));
        },
        child: const Icon(Icons.add_task)
      ),
    );
  }
}
