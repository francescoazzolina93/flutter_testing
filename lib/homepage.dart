import 'package:flutter/material.dart';
import 'testpage1.dart';
import 'testpage2.dart';
import 'package:flutter_login/authentication/loginpage.dart';
import 'package:flutter_login/databasedisplay.dart';

class HomePageMenu extends StatefulWidget{
  HomePageMenu({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageMenuState createState() => _HomePageMenuState();
}

class _HomePageMenuState extends State<HomePageMenu>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                    accountEmail:Text("testing@email.com"),
                    accountName: Text("testing"),
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

      body: Row(
        children: <Widget>[
          Padding(padding: const EdgeInsets.only(left: 150.00)),
          Padding(padding: const EdgeInsets.only(top: 400.00)),
          Material(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.red,
              child: MaterialButton(
                height: 50.0,
                minWidth: 150.0,
                textColor: Colors.black,
                elevation: 6.0,
                child: Text(
                    "Display Database",
                    textAlign: TextAlign.center),
                onPressed: alertDisplay,
              )
          ),
          /*Column(
            children: <Widget>[
                Padding(padding: const EdgeInsets.only(top: 100.00)),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Colors.red)
                      )
                    ),
                  ),
            ],
          ),*/
        ],
      )


    );
  }

  Future<void>alertDisplay() async{
      try {
        _alertDisplayDialog(context);
      }catch(e){
        print(e.message);
      }
  }

  Future<void> _alertDisplayDialog(BuildContext context) async{
    return showDialog(
        context: context,
        barrierDismissible: false, // must tap to close
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Attention!"),
            backgroundColor: Colors.black,
            shape: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              gapPadding: 50.0,
            ),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Theme(
                    data: ThemeData(
                    ),
                    child: Text("On press will add 1000 to the car count"),
                  )
                ],
              ),
            ),

            actions: <Widget>[
              FlatButton(
                color: Colors.black,
                textColor: Colors.white,
                shape: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  gapPadding: 50.0,
                ),
                child: Text("OK"),
                onPressed: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) =>  DatabaseTest()));
                },
              )
            ],
          );
        }
    );
  }

}

