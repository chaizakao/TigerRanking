import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
// Explicit
  final formKey = GlobalKey<FormState>();
  String user, password;

// Method
  Widget signInButtton() {
    return Container(
      child: RaisedButton(
        child: Text('Sign In'),
        onPressed: () {
          print('You Click SignIn');
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            
            print('user = $user, password = $password');


          }
        },
      ),
    );
  }

  Widget userText() {
    return Container(
      margin: EdgeInsets.only(left: 50.0, right: 50.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'user :',
          helperText: 'Type Your User',
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please Fill User in blank';
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
            return 'Plese Fill Password';
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
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[userText(), passwordText(), signInButtton()],
        ),
      ),
    );
  }
}
