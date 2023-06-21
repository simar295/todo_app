import 'package:flutter/material.dart';

class dialogbox extends StatefulWidget {
  dialogbox(
      {super.key,
      required this.getlist2,
      required this.getcontroller,
      required this.onsave});

  final List getlist2;
  final getcontroller;
  final VoidCallback onsave;

  @override
  State<dialogbox> createState() => _dialogboxState();
}

class _dialogboxState extends State<dialogbox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(100, 22, 44, 33),
      body: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(55)),
        child: AlertDialog(
          elevation: 2,
          shadowColor: Colors.yellow,
          backgroundColor: Colors.black,
          title: TextField(
            controller: widget.getcontroller,
            decoration: const InputDecoration(
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
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "cancel",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.amberAccent),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: widget.onsave,
                  child: Text(
                    "save",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.amberAccent),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/* final giveprovider = Provider<String>((ref) {
  return taskcontroller.text;
}); */
final taskcontroller = TextEditingController();
