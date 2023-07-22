import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class listwidget extends StatefulWidget {
  const listwidget(
      {super.key, required this.getlist, required this.deletetask});

  final List getlist;
  final VoidCallback deletetask;

  @override
  State<listwidget> createState() => _listwidgetState();
}

class _listwidgetState extends State<listwidget> {
  void changecheck(bool? x) {
    setState(() {
      widget.getlist[1] = !widget.getlist[1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.yellow.shade400),
      child: Slidable(
        direction: Axis.horizontal,
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              // An action can be bigger than the others.

              onPressed: (context) {
                widget.deletetask();
              },
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
              foregroundColor: Colors.white,
              icon: Icons.delete_forever_sharp,
              label: 'delete', borderRadius: BorderRadius.circular(0),
            ),
          ],
        ),
        child: Material(
          color: Color.fromARGB(255, 255, 85, 136),
          borderRadius: BorderRadius.circular(10),
          elevation: 4,
          shadowColor: Color.fromARGB(255, 17, 17, 17),
          child: Container(
            height: 140,
            child: ListTile(
              title: Text(
                widget.getlist[0].toString(),
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 20),
              ),
              subtitle: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                overflow: TextOverflow.fade,
                style: TextStyle(color: Colors.white),
              ),
              leading: Container(
                margin: EdgeInsets.only(right: 2),
                child: Checkbox(
                  value: widget.getlist[1],
                  onChanged: (value) {
                    changecheck(value);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
