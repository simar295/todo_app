import 'package:flutter/material.dart';

class searchbar extends StatelessWidget {
  const searchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Container(
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      suffixIcon: const Icon(
                        Icons.settings_outlined,
                        color: Color(0xFF46E69E),
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xFF46E69E),
                      ),
                      label: const Text(
                        "search Tasks",
                        style: TextStyle(fontSize: 10),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      /*  border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30), */
                    ),
                  ),
                ),
              ) ;
  }
}