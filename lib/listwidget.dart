import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';




class listwidget extends StatefulWidget {
  const listwidget(
      {super.key,
      required this.getlist,
      required this.deletetask,
      required this.updatecheck,
      required this.getvalue});

  final List getlist;
  final VoidCallback deletetask;
  final VoidCallback updatecheck;
  final bool getvalue;

  @override
  State<listwidget> createState() => _listwidgetState();
}

class _listwidgetState extends State<listwidget> {
  void changecheck() {
    setState(() {
      widget.getlist[2] = widget.getvalue;
    });
  }

  var col1 = Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  Widget build(BuildContext context) {
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
            foregroundColor: Color.fromARGB(255, 255, 52, 52),
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
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        widget.getlist[0].toString(),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Checkbox(
                        fillColor: MaterialStatePropertyAll(Colors.black),
                        value: widget.getlist[2],
                        onChanged: (value) {
                          changecheck();
                          widget.updatecheck();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  widget.getlist[1].toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )

              /*  ListTile(
              title:
              subtitle: 
              trailing:
            ), */
              ),
        ),
      ),
    );
  }
}
