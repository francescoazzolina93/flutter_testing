import 'package:flutter/material.dart';
import 'testpage1.dart';
import 'testpage2.dart';
import 'package:flutter_login/authentication/loginpage.dart';

class HomePageMenu extends StatefulWidget{
  HomePageMenu({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageMenuState createState() => _HomePageMenuState();
}

class _HomePageMenuState extends State<HomePageMenu>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text("Menu Testing"),
      ),

      drawer: Drawer(
        child: SafeArea(
            child: ListView(
                padding: const EdgeInsets.all(8.0),

                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountEmail:Text("fra.azzolina@gmail.com"),
                    accountName: Text("Fracesco Azzolina"),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.red,
                      child: Text(
                        "FA",
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                    otherAccountsPictures: <Widget>[
                      Material(
                        borderRadius: BorderRadius.circular(100.0),
                        child: MaterialButton(
                          height: 20,
                          minWidth: 20,
                          padding: const EdgeInsets.all(0.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.black,
                            child: Text(
                              "AC",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          onPressed: (){
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder:(BuildContext context) => LoginTestPage() ));
                            },
                        ),
                      ),

                      Material(
                        borderRadius: BorderRadius.circular(100.0),
                        child: MaterialButton(
                          height: 20,
                          minWidth: 20,
                          padding: const EdgeInsets.all(0.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.black,
                            child: Text(
                              "GA",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          onPressed: (){
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder:(BuildContext context) => LoginTestPage() ));
                          },
                        ),
                      ),
                    ],
                  ),

                  ListTile(
                    title: Text("Line Test 1"),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: (){
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => TestPage1()));
                    },
                  ),
                  ListTile(
                    title: Text("Line Test 2"),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: (){
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => TestPage2()));
                    },
                  ),

                ]
            )
        ),
      ),
    );
  }
}



