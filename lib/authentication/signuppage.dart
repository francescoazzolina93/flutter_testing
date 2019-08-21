import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/authentication/loginpage.dart';

class SignUpTest extends StatefulWidget{
  SignUpTest({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpTestState createState() => _SignUpTestState();
}

class _SignUpTestState extends State<SignUpTest>{
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
                    textColor: Colors.red,
                    style: FlutterLogoStyle.horizontal,
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
                                        "Register",
                                        textAlign: TextAlign.center),
                                    onPressed: (){
                                      signUp();
                                    }
                                )
                            )
                          ],

                        )),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }

  Future<void>signUp() async{
    final formState = _formKey.currentState;
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try {
        FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder:(BuildContext context) => LoginTestPage() ));
      }catch(e){
        print(e.message);
      }
    }

  }
}

