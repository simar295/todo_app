import 'package:flutter/material.dart';
import 'package:todo_app/dialogwidget.dart';

import 'package:todo_app/listwidget.dart';

class todoapp extends StatefulWidget {
  const todoapp({super.key});

  @override
  State<todoapp> createState() => _todoappState();
}

class _todoappState extends State<todoapp> {
  @override
  Widget build(BuildContext context) {
    List mytodo = [
      ["mywork", false],
      ["exercise", true]
    ];

    void createtask() {
      showDialog(
          context: context,
          builder: (context) {
            return dialogbox();
          });
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.yellow.shade300,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          toolbarHeight: 105,
          title: Text(
            "TO DO ",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          backgroundColor: Colors.yellow.shade500,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.black,
          onPressed: createtask,
        ),
        body: ListView.builder(
          itemCount: mytodo.length,
          itemBuilder: (context, index) => listwidget(getlist: mytodo[index]),
        ),
      ),
    );
  }
}