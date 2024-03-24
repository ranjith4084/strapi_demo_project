// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:strapi_demo_project/constant.dart';
import './user.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import './main.dart';
import 'dart:convert';

class MyForm extends StatefulWidget {
  int id;

  MyForm(this.id);

  @override
  _MyFormState createState() => _MyFormState(this.id);
}

class _MyFormState extends State<MyForm> {
  int id;

  _MyFormState(this.id);

  User user = User(0, '', '', '');


  Future save() async {
    if (user.id == 0) {
      await http.post(
        ConstantApi().base_url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "data": {
            'name': user.name.toString(),
            'email': user.email.toString(),
            'password': user.password.toString()
          }
        }),
      );
    } else {
      final apiUrl =
          '${ConstantApi().base_url}/${user.id}'; // Replace with your Strapi API URL and endpoint
      final headers = {
        'Content-Type': 'application/json',
        // Add any other headers if required (e.g., authorization token)
      };

      final dataToUpdate = {
        "data": {
          'name': user.name.toString(),
          'email': user.email.toString(),
          'password': user.password.toString()
        }
      };

      try {
        final response = await http.put(
          Uri.parse(apiUrl),
          headers: headers,
          body: jsonEncode(dataToUpdate),
        );

        if (response.statusCode == 200) {
          // Data updated successfully
        } else {
          // Handle error (e.g., server error, validation error, etc.)
          print('Error: ${response.statusCode}');
        }
      } catch (e) {
        // Handle any exceptions (e.g., network error)
        print('Error: $e');
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Home(1, 0),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (this.id != 0) {
      getOne();
    }
  }

  void getOne() async {
    var data = await http
        .get(Uri.parse("${ConstantApi().base_url}/${this.id}"));
    var u = json.decode(data.body);

    setState(() {
      user = User(
          u["data"]['id'],
          u["data"]["attributes"]['name'],
          u["data"]["attributes"]['email'],
          u["data"]["attributes"]['password']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          child: Padding(
        padding: EdgeInsets.all(19.0),
        child: Column(
          children: [
            Visibility(
              visible: false,
              child: TextField(
                  controller: TextEditingController(text: user.id.toString())),
            ),
            TextField(
              controller: TextEditingController(text: user.name),
              onChanged: (val) {
                user.name = val;
              },
              decoration:
                  InputDecoration(labelText: "Name", icon: Icon(Icons.person)),
            ),
            TextField(
              controller: TextEditingController(text: user.email),
              onChanged: (val) {
                user.email = val;
              },
              decoration:
                  InputDecoration(labelText: "Email", icon: Icon(Icons.person)),
            ),
            TextField(
              controller: TextEditingController(text: user.password),
              onChanged: (val) {
                user.password = val;
              },
              decoration: InputDecoration(
                  labelText: "Password", icon: Icon(Icons.vpn_key)),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(35, 20, 0, 0),
              child: MaterialButton(
                onPressed: save,
                minWidth: double.infinity,
                color: Colors.blue,
                textColor: Colors.white,
                child: Text("Save"),
              ),
            )
          ],
        ),
      )),
    );
  }
}
