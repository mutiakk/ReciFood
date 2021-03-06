import 'dart:convert';

import 'package:cubaapi/screen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';

class RegistPage extends StatefulWidget {
  const RegistPage({Key? key}) : super(key: key);

  @override
  _RegistPageState createState() => _RegistPageState();
}

class _RegistPageState extends State<RegistPage> {
  bool _passHide = true;

  //controller
  final emailControl = TextEditingController();
  final passControl = TextEditingController();
  final passControl2 = TextEditingController();

  void _password() {
    setState(() {
      _passHide = !_passHide;
    });
  }

  void _regist() async {
    // bikin password 1 ama 2 sama (validate)

    //Ga boleh kosong
    if (emailControl.text.isNotEmpty &&
        passControl.text.isNotEmpty &&
        passControl2.text.isNotEmpty) {
      var response = await http.post(Env().postRegistCustomer(),
          body: jsonEncode({
            "username": emailControl.text,
            "password": passControl.text,
            "password_repeat": passControl2.text
          }),headers: {"Content-Type": "application/json"});
      if (response.statusCode == 201) {
        final body = jsonDecode(response.body);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Register Success')));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("register", body['message']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('unsucces')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Blank Value')));
    }

// if (emailControl.text.isNotEmpty && passControl.text.isNotEmpty) {
    //   SharedPreferences prefs= await SharedPreferences.getInstance();
    //   prefs.setBool('isUser', true);
    //
    //   Future.delayed(Duration(seconds: 2));
    //   if (emailControl.text == 'mancuy' && passControl.text == 'mancuy') {
    //     Navigator.pushReplacement(
    //         context, MaterialPageRoute(builder: (context) => HomePage()));
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(child:Center(
        child: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                color: Colors.blueAccent),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 50,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                child: formRegister(),
              )),
        ]),
      ),
        ));
  }

  Widget formRegister() {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.text,
          controller: emailControl,
          decoration: InputDecoration(
            labelText: 'Name',
            icon: Icon(Icons.person),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.lightGreen, width: 2)),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          keyboardType: TextInputType.text,
          obscureText: _passHide,
          controller: passControl,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              labelText: 'Password',
              icon: Icon(Icons.lock),
              suffixIcon: GestureDetector(
                child: Icon(
                  _passHide ? Icons.visibility_off : Icons.visibility,
                  color: _passHide ? Colors.grey : Colors.blueAccent,
                ),
                onTap: () {
                  _password();
                },
              )),
        ),
        SizedBox(height: 10),
        TextFormField(
          keyboardType: TextInputType.text,
          obscureText: _passHide,
          controller: passControl2,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              labelText: 'Password',
              icon: Icon(Icons.lock),
              suffixIcon: GestureDetector(
                child: Icon(
                  _passHide ? Icons.visibility_off : Icons.visibility,
                  color: _passHide ? Colors.grey : Colors.blueAccent,
                ),
                onTap: () {
                  _password();
                },
              )),
        ),
        SizedBox(
          height: 10,
        ),RaisedButton(
          onPressed: () {
            _regist();
          },
          child: Text("Register"),
        )
      ],
    );
  }
}
