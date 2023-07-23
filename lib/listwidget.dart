import 'dart:math';

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
    var col1 = Colors.primaries[Random().nextInt(Colors.primaries.length)];

    return Slidable(
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
            foregroundColor: const Color.fromARGB(255, 0, 0, 0),
            icon: Icons.delete_forever_sharp,
            label: 'delete', borderRadius: BorderRadius.circular(0),
          ),
        ],
      ),
      child: Material(
        /*for using shadow property*/
        borderRadius: BorderRadius.circular(10),
        elevation: 4,
        shadowColor: Color.fromARGB(255, 17, 17, 17),
        child: Container(
          width: 170,
          height: 150,
          decoration: BoxDecoration(
            /*    color: Colors.primaries[Random().nextInt(Colors.primaries.length)], //for generating random colors */
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(colors: [
              col1,
              col1.shade200
              /*    Colors.primaries[Random().nextInt(Colors.primaries.length)],
              Colors.primaries[Random().nextInt(Colors.primaries.length)], */

              /*   const Color.fromARGB(255, 64, 255, 128),
              Color.fromARGB(255, 132, 231, 170), */
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: GridTile(
            child: ListTile(
              title: Text(
                widget.getlist[0].toString(),
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 15),
              ),
              /*  subtitle: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                  overflow: TextOverflow.fade,
                  style: TextStyle(color: Colors.white),
                ), */

              trailing: Container(
                margin: EdgeInsets.only(right: 0),
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
