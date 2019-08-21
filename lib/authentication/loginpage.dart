import 'package:flutter/material.dart';
import 'package:flutter_login/authentication/signuppage.dart';
import 'package:flutter_login/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginTestPage extends StatefulWidget{
  LoginTestPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginTestPageState createState() => _LoginTestPageState();
}

class _LoginTestPageState extends State<LoginTestPage>{
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlutterLogo(
                    size: 200.0,
                    colors: Colors.red,
                  ),

                  Container(
                    child: Form(
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(left: 80.0, right: 80.0),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 70.0),
                                  Theme(
                                    data: ThemeData(
                                      primaryColor: Colors.red,
                                      primaryColorDark: Colors.red,
                                      hintColor: Colors.grey,
                                    ),
                                    child: Column(
                                      children: <Widget>[
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
                                          keyboardType: TextInputType.emailAddress,
                                          validator: (input){
                                            if(input.isEmpty){
                                              return "Inserire un'email";
                                            }
                                          },
                                          onSaved: (input) => _email = input,
                                        ),
                                        SizedBox(height: 20.0),
                                        TextFormField(
                                          decoration: InputDecoration(
                                              hintText: "Password",
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(30.0)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(30.0),
                                                  borderSide: BorderSide(color: Colors.red)
                                              )
                                          ),
                                          keyboardType: TextInputType.text,
                                          obscureText: true,
                                          validator: (input){
                                            if(input.length < 6){
                                              return "La password deve essere lunga almeno 6 caratteri";
                                            }
                                          },
                                          onSaved: (input) => _password = input,
                                        ),
                                      ],
                                    )
                                  ),

                                ],
                              ),
                            ),

                            Padding(
                                padding: const EdgeInsets.only(top: 50.0)),
                            Material(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.red,
                              child: MaterialButton(
                                  height: 50.0,
                                  minWidth: 100.0,
                                  textColor: Colors.black,
                                  elevation: 6.0,
                                  child: Text(
                                    "Login",
                                    textAlign: TextAlign.center),
                                  onPressed: (){
                                    _AlertTest(context);
                                    signIn();
                                  }
                                  )
                            ),

                            Padding(
                                padding: const EdgeInsets.only(top: 50.0)),
                            Material(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.red,
                                child: MaterialButton(
                                    height: 50.0,
                                    minWidth: 100.0,
                                    textColor: Colors.black,
                                    elevation: 6.0,
                                    child: Text(
                                        "Sign up",
                                        textAlign: TextAlign.center),
                                    onPressed: (){
                                      signUp();
                                    }
                                )
                            )
                          ],
                        )
                    ),
                  ),
                ],
              )
            ],
        ),
      )
    );
  }

  Future<void>signIn() async{
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try {
        FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder:(BuildContext context) => HomePageMenu() ));
      }catch(e){
        print(e.message);
      }
    }

  }

  Future<void>signUp() async{
    Navigator.of(context).push(MaterialPageRoute(
        builder:(BuildContext context) => SignUpTest() ));

  }
}


Future<void> _AlertTest(BuildContext context) async{
  return showDialog(
    context: context,
    barrierDismissible: false, // must tap to close
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Logged in"),
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
                  child: Text("You are now logged in"),
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
            child: Text(
                "OK"),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => HomePageMenu() ));
            },
          )
        ],
      );
    }
  );
}