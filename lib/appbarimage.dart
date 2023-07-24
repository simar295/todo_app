import 'package:flutter/material.dart';

class appbarimage extends StatelessWidget {
  const appbarimage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: double.infinity,
        height: 180,
        child: Image.asset('assets/gif3.gif'),
      ) ;
  }
}