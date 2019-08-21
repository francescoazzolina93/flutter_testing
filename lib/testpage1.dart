import 'package:flutter/material.dart';

class TestPage1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("A Page With Some Container"),
      ),
      body: ListView(
          children: <Widget>[
            Container(
                height: 50,
                color: Colors.green[800],
                child: const Center(child: Text("Test Container 1"))
            ),
            Container(
                height: 50,
                color: Colors.blue[600],
                child: const Center(child: Text("Test Container 2"))
            ),
            Container(
                height: 50,
                color: Colors.black,
                child: const Center(child: Text("Test Container 3"))
            ),
          ]
      ),

    );

  }
}