import 'package:flutter/material.dart';

class titlerow extends StatelessWidget {
  const titlerow({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: const TextSpan(children: [
                      TextSpan(
                          text: "TO-",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: "DO",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.greenAccent))
                    ]),
                  ),
                  const Icon(
                    Icons.circle_notifications,
                    size: 30,
                    color: Color(0xFF46E69E),
                  ),
                ],
              ) ;
  }
}