import 'package:flutter/material.dart';


class TestPage2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var image = new Image(image: new AssetImage('assets/images/montebianco.jpg'));

    return Scaffold(
      appBar: AppBar(
        title: Text("A page with an image"),
      ),
      body:Container(child: image),
    );
  }
}