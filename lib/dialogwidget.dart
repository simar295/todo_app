import 'package:flutter/material.dart';

class dialogbox extends StatelessWidget {
  const dialogbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: const AlertDialog(
        elevation: 2,
        shadowColor: Colors.yellow,
        backgroundColor: Colors.black,
        title: TextField(
          decoration: InputDecoration(
            label: Text("add task"),
            filled: true, //<-- SEE HERE
            fillColor: Color.fromARGB(255, 252, 252, 252), //<-- SEE HERE
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: null,
                child: Text(
                  "cancel",
                  style: TextStyle(color: Colors.black),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.amberAccent),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: null,
                child: Text(
                  "save",
                  style: TextStyle(color: Colors.black),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.amberAccent),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
