import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class listwidget extends StatefulWidget {
  const listwidget({super.key, required this.getlist});

  final List getlist;

  @override
  State<listwidget> createState() => _listwidgetState();
}

class _listwidgetState extends State<listwidget> {
  bool initial = true;

  void changecheck(bool? x) {
    setState(() {
      initial = x!;
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
              onPressed: (context) => null,
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
            ),
            leading: Checkbox(
              value: initial,
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