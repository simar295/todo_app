import 'dart:ffi';

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
final givecontroller2 = TextEditingController();

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
        mytodo.add([
          item.value['data'],
          item.value['description'],
          item.value['value'],
        ]);
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
    }
    if (givecontroller2.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 1000),
          content: Text(
            "Description is empty",
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
          "description": givecontroller2.text,
          "value": false,
        }),
      );

      if (!context.mounted) {
        return;
      }
      Navigator.of(context).pop();
      setState(() {
        mytodo.add([givecontroller.text, givecontroller2.text, false]);
        givecontroller.clear();
        givecontroller2.clear();
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

/////////////////////////////////////////////////////////////////////////
  bool changecheck = false;
  void doupdatecheck(int index) async {
   
    final geturl = Uri.https(
        'todo-app-f7776-default-rtdb.firebaseio.com', "todo-data.json");
    final getresponse = await http.get(geturl);
    final Map listdata = json.decode(getresponse.body);

    final delurl = Uri.https('todo-app-f7776-default-rtdb.firebaseio.com',
        "todo-data/${listdata.keys.elementAt(index)}.json");
    final response = await http.patch(
      delurl,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode({
        "data": mytodo[index][0],
        "description": mytodo[index][1],
        "value": changecheck,
      }),
    );

       setState(() {
      changecheck = !changecheck;

    });
    
    if (!context.mounted) {
      return;
    }
  }

////////////////////////////////////////////////////////////////////////
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
              getcontroller2: givecontroller2,
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
              height: 80,
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
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 0),
          padding: EdgeInsets.all(10),
          itemCount: mytodo.length,
          itemBuilder: (context, index) => listwidget(
            updatecheck: () => doupdatecheck(index),
            getvalue: changecheck,
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
        backgroundColor: Color.fromARGB(255, 253, 253, 253),
        appBar: AppBar(
          flexibleSpace: Container(
            width: double.infinity,
            height: 180,
            child: Image.asset('assets/gif3.gif'),
          ),

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
                  RichText(
                    text: const TextSpan(children: [
                      TextSpan(
                          text: "TO-",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: "DO",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.greenAccent))
                    ]),
                  ),
                  const Icon(
                    Icons.circle_notifications,
                    size: 30,
                    color: Color(0xFF46E69E),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Container(
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      suffixIcon: const Icon(
                        Icons.settings_outlined,
                        color: Color(0xFF46E69E),
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xFF46E69E),
                      ),
                      label: const Text(
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
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: createtask,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: const Column(
                    children: [
                      /*  Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 6, color: Colors.pinkAccent),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: double.infinity,
                        child: Image.asset(
                          'assets/abstract.jpg',
                          fit: BoxFit.fill,
                        ),
                        height: 140,
                      ), */
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.8, 0.8, 0.8, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Alloted Tasks",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 116, 116, 116)),
                            ),
                            Icon(Icons.notes),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                content,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
