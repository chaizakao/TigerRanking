
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:tiger_ranking/screens/home.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String user, password;
  

  // Method
  Widget signInButton() {
    return Container(
      child: RaisedButton(
        child: Text('Sign In'),
        onPressed: () {
          print('You Click SignIn');
          if (formKey.currentState.validate()) {
            formKey.currentState.save();

            print('User = $user, Password = $password');
            // findData();
            _makePostRequest();
          }
        },
      ),
    );
  }



  Future<void> _makePostRequest() async {
  // set up POST request arguments
  String url = 'http://58.137.37.240/dd_backend/TGER/webservice/tiger_score.asmx/Login';
  Map<String, String> headers = {"Content-type": "application/json"};
  String json = '{"module" : "login","target" : "login","data" : {"username" : "$user","password" : "$password"}}';
  // make POST request
  Response response = await post(url, headers: headers, body: json);
  // check the status code for the result
  int statusCode = response.statusCode;
  // print('stautscode = $statusCode');
  // this API passes back the id of the new item added to the body
  var body = response.body;
  // print('body = $body');
  
  Map map = jsonDecode(body);
  Map objJSON = map['d'];
  int statusCodeInt = objJSON['statusCode'];
  // print('statusCode = $statusCodeInt');


  if (statusCodeInt == 401) {
    print('Login False');
    mySnackBar('Please Try Agains User or Password False');
  } else {
    print('Login False');
    MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context) => Home(map: map,));
    Navigator.of(context).pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);


  }

}

void mySnackBar(String message){

  SnackBar snackBar = SnackBar(content: Text(message),);
  scaffoldKey.currentState.showSnackBar(snackBar);

}


  Widget userText() {
    return Container(
      margin: EdgeInsets.only(left: 50.0, right: 50.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'User :',
          helperText: 'Type Your User',
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please Fill User in Blank';
          }else {
            return null;
          }
        },
        onSaved: (String value) {
          user = value;
        },
      ),
    );
  }

  Widget passwordText() {
    return Container(
      margin: EdgeInsets.only(left: 50.0, right: 50.0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password :',
          helperText: 'Type Your Password',
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please Fill Password in Blank';
          }
        },
        onSaved: (String value) {
          password = value;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: scaffoldKey,
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            userText(),
            passwordText(),
            signInButton(),
          ],
        ),
      ),
    );
  }
}