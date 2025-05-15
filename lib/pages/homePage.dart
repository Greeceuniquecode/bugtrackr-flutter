import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [_titletext(), dropdownMenu()],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titletext() {
    return Text(
      'Compliment Jar',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.cyanAccent.shade700,
        decoration: TextDecoration.underline,
        decorationColor: Colors.cyanAccent.shade700,
      ),
    );
  }

  Widget dropdownMenu() {
    List<String> menubuttons = [
      "Menu",
      "Home",
      "Contact Us",
      "About Us",
      "Compliments",
    ];
    return DropdownButton(
      value: menubuttons.first,
      onChanged: (_) {},
      underline: Container(height: 2 , color: Colors.cyanAccent.shade700),
      items:
          menubuttons.map((btn) {
            return DropdownMenuItem(
              value: btn, 
              child: Text(btn));
          }).toList(),
    );
  }
}
