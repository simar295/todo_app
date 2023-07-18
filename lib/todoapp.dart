import 'package:flutter/material.dart';
import 'package:todo_app/dialogwidget.dart';
import 'package:todo_app/listwidget.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class todoapp extends StatefulWidget {
  const todoapp({
    super.key,
  });

  @override
  State<todoapp> createState() => _todoappState();
}

final givecontroller = TextEditingController();

class _todoappState extends State<todoapp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadscreen();
  }

  //firebase getting requests
  void loadscreen() async {
    final geturl = Uri.https(
        'todo-app-f7776-default-rtdb.firebaseio.com', "todo-data.json");
    final getresponse = await http.get(geturl);

    print(getresponse.statusCode);

    final Map listdata = json.decode(getresponse.body);
    for (final item in listdata.entries) {
      setState(() {
        mytodo.add([item.value['data'], false]);
      });
    }
  }

  List newtodo = [];
  List mytodo = [
    /*  ["mywork", false],
    ["exercise", true],  */
  ];

  void submitdata() async {
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
      //firebase sending data
      final url = Uri.https(
          'todo-app-f7776-default-rtdb.firebaseio.com', "todo-data.json");
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "data": givecontroller.text,
        }),
      );

      if (!context.mounted) {
        return;
      }
      Navigator.of(context).pop();
      setState(() {
        mytodo.add([givecontroller.text, false]);
      });
    }
  }

  void heredeletetask(int index) async {
    setState(() {
      mytodo.removeAt(index);
    });



    final geturl = Uri.https(
        'todo-app-f7776-default-rtdb.firebaseio.com', "todo-data.json");
    final getresponse = await http.get(geturl);

    final Map listdata = json.decode(getresponse.body);
    
    final delurl = Uri.https('todo-app-f7776-default-rtdb.firebaseio.com',
        "todo-data/${listdata.keys.elementAt(index)}.json");
    http.delete(delurl);
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

//displaying conditional content on main screen
    Widget content;

    if (mytodo.isEmpty) {
      content = const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.black, strokeWidth: 10),
            SizedBox(
              height: 40,
            ),
            Text("start adding tasks",style: TextStyle(fontWeight: FontWeight.bold),),
          ],
        ),
      );
    } else {
      content = ListView.builder(
        itemCount: mytodo.length,
        itemBuilder: (context, index) => listwidget(
          getlist: mytodo[index],
          deletetask: () {
            heredeletetask(index);
          },
        ),
      );
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
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
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
          body: content),
    );
  }
}
