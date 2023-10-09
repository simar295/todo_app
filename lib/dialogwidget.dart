import 'package:flutter/material.dart';

class dialogbox extends StatefulWidget {
  dialogbox(
      {super.key,
      required this.getlist2,
      required this.getcontroller,
      required this.getcontroller2,
      required this.onsave});

  final List getlist2;
  late final getcontroller;
  late final getcontroller2;
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
          shadowColor: const Color.fromARGB(255, 0, 0, 0),
          backgroundColor: Colors.black,
          title: Column(
            children: [
              TextField(
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.characters,
                controller: widget.getcontroller,
                decoration: const InputDecoration(
                  label: Text("add task"),
                  filled: true, //<-- SEE HERE
                  fillColor: Color.fromARGB(255, 252, 252, 252), //<-- SEE HERE
                ),
              ),
              SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                controller: widget.getcontroller2,
                decoration: const InputDecoration(
                  label: Text("Write Description"),
                  filled: true, //<-- SEE HERE
                  fillColor: Color.fromARGB(255, 252, 252, 252), //<-- SEE HERE
                ),
              ),
            ],
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
                    backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 255, 85, 136),
                    ),
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
                    backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 255, 85, 136),
                    ),
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
