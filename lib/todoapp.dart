import 'package:flutter/material.dart';
import 'package:todo_app/dialogwidget.dart';
import 'package:todo_app/listwidget.dart';

class todoapp extends StatefulWidget {
  const todoapp({
    super.key,
  });

  @override
  State<todoapp> createState() => _todoappState();
}

final givecontroller = TextEditingController();

class _todoappState extends State<todoapp> {
  final List mytodo = [
    ["mywork", false],
    ["exercise", true],
  ];
  void submitdata() {
    if (givecontroller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 1000),
          content: Text(
            "Task is empty",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
    } else {
      setState(() {
        mytodo.add([givecontroller.text, false]);
      });
      Navigator.of(context).pop();
    }
  }

  void heredeletetask(int index) {
    print("object");
    setState(() {
      mytodo.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    /*   final getprovider = ref.watch(giveprovider); */

    void createtask() {
      showDialog(
          context: context,
          builder: (context) {
            return dialogbox(
              getlist2: mytodo,
              getcontroller: givecontroller,
              onsave: submitdata,
            );
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
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
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
          itemBuilder: (context, index) => listwidget(
            getlist: mytodo[index],
            deletetask: () {
              heredeletetask(index);
            },
          ),
        ),
      ),
    );
  }
}
