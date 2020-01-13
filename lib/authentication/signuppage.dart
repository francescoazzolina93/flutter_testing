import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/authentication/loginpage.dart';

class SignUpTest extends StatefulWidget{
  SignUpTest({Key key, this.title}) : super(key: key);

  final String title;

  @override
  SignUpTestState createState() => SignUpTestState();

}

class SignUpTestState extends State<SignUpTest>{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password ;
  static String _username;

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.black,
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(
                size: 200.0,
                textColor: Colors.red,
                style: FlutterLogoStyle.stacked,
                colors: Colors.red,
              ),
              Container(
                padding: const EdgeInsets.only(left: 80.0, right: 80.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 70.0),
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
                            SizedBox(height: 20.0),

                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Account Name",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: BorderSide(color: Colors.red)
                                  )
                              ),
                              keyboardType: TextInputType.text,
                              validator: (input){
                                if(input.isEmpty){
                                  return "Inserire un nome utente";
                                }
                              },
                              onSaved: (input) =>_username = input,
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
                                        "Register",
                                        textAlign: TextAlign.center),
                                    onPressed: signUp,
                                )
                            )
                          ],
                        )
                    ),
                  ],
                ),
              ),
            ],
          )
        )
    );
  }

  Future<void>signUp() async{
    final formState = _formKey.currentState;
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        _alertSignUp(context);
      }catch(e){
        print(e.message);
      }
    }
  }

  Future<void> _alertSignUp(BuildContext context) async{
    return showDialog(
        context: context,
        barrierDismissible: false, // must tap to close
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Registered!"),
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
                    child: Text("You are now registered!"),
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
                      builder:(BuildContext context) => LoginTestPage() ));
                },
              )
            ],
          );
        }
    );
  }
  static String getUser(){ //DA SISTEMARE
    return _username;
  }
}

