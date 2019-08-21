import 'package:flutter/material.dart';

class TestPage2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage('assets/images/montebianco.jpg');
    var image = new Image(image: assetsImage);
    return Scaffold(
      appBar: AppBar(
        title: Text("A Page With an Image"),
      ),
      body: Container(child: image),
    );
  }
}