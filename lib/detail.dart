// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, no_logic_in_create_state, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strapi_demo_project/constant.dart';
import 'package:strapi_demo_project/main.dart';
import 'package:strapi_demo_project/user.dart';
import 'package:http/http.dart' as http;

class Mydetails extends StatefulWidget {
  User user;

  Mydetails({required this.user});

  @override
  State<Mydetails> createState() => _MydetailsState(user: this.user);
}

class _MydetailsState extends State<Mydetails> {
  User user;

  _MydetailsState({required this.user});



  void edit() {
    print(user.id);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Home(
          0,
           user.id!.toInt(),
        ),
      ),
    );
  }

  void delete() async {

    var url1 = Uri.parse('${ConstantApi().base_url}/${this.user.id}');
    print(user.id);
   var demo = await http.delete(
       url1);
    print(demo.body);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Home(1, 0)));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(user.name.toString()),
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(19.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(19.0),
                  child: Text("Id:" + user.id.toString(),
                      style: TextStyle(fontSize: 20)),
                ),
                Padding(
                  padding: const EdgeInsets.all(19.0),
                  child: Text(
                    "Name:" + user.name.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(19.0),
                  child: Text(
                    "Email:" + user.email.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Row(
                  children: [
                    MaterialButton(
                      onPressed: edit,
                      child: Text("Edit"),
                      color: Colors.blue,
                      textColor: Colors.white,
                    ),
                    Spacer(),
                    MaterialButton(
                      onPressed: delete,
                      child: Text("Delete"),
                      color: Colors.blue,
                      textColor: Colors.white,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
