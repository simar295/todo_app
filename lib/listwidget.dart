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
              backgroundColor: Color.fromARGB(255, 252, 66, 97),
              foregroundColor: Colors.white,
              icon: Icons.delete_forever_sharp,
              label: 'delete',
            ),
          ],
        ),
        
        child: Material(
          color: Colors.yellow.shade400,
          borderRadius: BorderRadius.circular(10),
          elevation: 2,
          shadowColor: Colors.white,
          child: ListTile(
            title: Text(
              widget.getlist[0].toString(),
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            leading: Checkbox(
              value: widget.getlist[1],
              onChanged: (value) {
                changecheck(value);
              },
              activeColor: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
