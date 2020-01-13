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
        resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FlutterLogo(
                size: 200.0,
                colors: Colors.red,
              ),
              Container(
                padding: const EdgeInsets.only(left: 80.0, right: 80.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40.0),
                    Theme(
                        data: ThemeData(
                            primaryColor: Colors.red,
                            hintColor: Colors.grey,
                            textTheme: Theme.of(context).textTheme.apply(
                              bodyColor: Colors.white,
                            )
                        ),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              validator: (input){
                                if(input.isEmpty){
                                  return "Inserire un'email";
                                }
                                },
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
                              onSaved: (input) => _email = input,
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              validator: (input){
                                if(input.length < 6){
                                  return "La password deve essere lunga almeno 6 caratteri";
                                }
                                },
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
                              onSaved: (input) => _password = input,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 30.0)),
                            Material(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.red,
                                child: MaterialButton(
                                    height: 50.0,
                                    minWidth: 150.0,
                                    textColor: Colors.black,
                                    elevation: 6.0,
                                    child: Text(
                                        "Login",
                                        textAlign: TextAlign.center),
                                    onPressed: (){
                                      signIn();
                                    }
                                    )
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 20.0)),
                            Material(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.red,
                                child: MaterialButton(
                                    height: 50.0,
                                    minWidth: 150.0,
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
                  ],
                ),
              ),
            ],
          ),
        )
      )
    );
  }

  Future<void>signIn() async{
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try {
        AuthResult authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        FirebaseUser firebaseUser = authResult.user;
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder:(BuildContext context) => HomePageMenu() ));
      }catch(e){
        print(e.message);
        _alertTest(context);
      }
    }

  }

  Future<void>signUp() async{
    Navigator.of(context).push(MaterialPageRoute(
        builder:(BuildContext context) => SignUpTest() ));

  }
}


Future<void> _alertTest(BuildContext context) async{
  return showDialog(
    context: context,
    barrierDismissible: false, // must tap to close
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Error!"),
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
                  child: Text("Wrong Email or Password!"),
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
              Navigator.of(context).pop();
            },
          )
        ],
      );
    }
  );
}