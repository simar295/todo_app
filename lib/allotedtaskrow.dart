import 'package:flutter/material.dart';


class allotedtaskrow extends StatelessWidget {
  const allotedtaskrow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
                    );
  }
}
