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
          "value": false,
        }),
      );

      if (!context.mounted) {
        return;
      }
      Navigator.of(context).pop();
      setState(() {
        mytodo.add([givecontroller.text, false]);
        givecontroller.clear();
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
            Text(
              "start adding tasks",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    } else {
      content = Expanded(
        child: ListView.builder(
          itemCount: mytodo.length,
          itemBuilder: (context, index) => listwidget(
            getlist: mytodo[index],
            deletetask: () {
              heredeletetask(index);
            },
          ),
        ),
      );
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          /* actions: [
              Icon(
                Icons.circle_notifications,
                size: 40,
              )
            ], */
          elevation: 0,
          toolbarHeight: 135,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Welcome back ",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.circle_notifications, size: 30),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Container(
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      suffixIcon: Icon(
                        Icons.settings_outlined,
                        color: Color(0xFF46E69E),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xFF46E69E),
                      ),
                      label: Text(
                        "search Tasks",
                        style: TextStyle(fontSize: 10),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      /*  border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30), */
                    ),
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Color.fromARGB(255, 150, 164, 241),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.black,
          onPressed: createtask,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                content,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
