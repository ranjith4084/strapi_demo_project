// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_final_fields, no_logic_in_create_state, use_key_in_widget_constructors, unnecessary_this, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:strapi_demo_project/form.dart';
import 'package:strapi_demo_project/list.dart';

void main() {
  runApp(
    Home(0, 0),
  );
}

class Home extends StatefulWidget {
  int state;
  int id;

  Home(this.state, this.id);

  @override
  _HomeState createState() => _HomeState(this.state, this.id);
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  Widget? _body;
  String? _title;
  int state;
  int id;

  _HomeState(this.state, this.id);

  void _onTap(index) {
    changeview(index);
  }

  void changeview(index) {

    _currentIndex = index;
    setState(() {
      switch (index) {
        case 0:
          {
            _title = "Form";
            _body = MyForm(this.id);
            break;
          }
        case 1:
          {
            _title = "List";
            _body = MyList();
            break;
          }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeview(state);
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Tittle"),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.abc),
              label: "Add",
            ),
            BottomNavigationBarItem(
              label: "View",
              icon: Icon(Icons.table_chart),
            ),
          ],
          currentIndex: _currentIndex,
          onTap: _onTap,
        ),
        body: _body,
      ),
    );
  }
}
