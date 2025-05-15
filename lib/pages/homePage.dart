import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
       child:  Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Compliment Jar',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyanAccent.shade700,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.cyanAccent.shade700,
                  ),
                ),
              ],
            ),
          ],
        ),
        ),
      ),
    );
  }
}
