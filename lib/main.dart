import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/todoapp.dart';


void main() {
  runApp(myapp());
}

class myapp extends StatelessWidget {
  const myapp({super.key});


 
@override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          textTheme: TextTheme(
            titleLarge: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
            bodyLarge: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
            bodySmall: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
            titleSmall: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
            titleMedium: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
            bodyMedium: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          ),
        ),
        home: todoapp());
  }
}

