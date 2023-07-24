import 'package:flutter/material.dart';
import 'package:todo_app/searchbar.dart';
import 'package:todo_app/titlerow.dart';

class appbartitle extends StatelessWidget {
  const appbartitle({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titlerow(),
          SizedBox(
            height: 20,
          ),
          searchbar(),
        ],
      ) ;
  }
}