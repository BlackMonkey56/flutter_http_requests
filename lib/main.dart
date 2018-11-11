import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String url = 'https://randomuser.me/api/';

  Future<String> makeRequest() async {
    var response = await http.get(Uri.encodeFull(url),
        headers: {"Accept": "application/json"});

    List data;

    var extractData = json.decode(response.body);
    data = extractData["results"];

    print(data[0]["name"]["first"]);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new RaisedButton(
          child: new Text('Make Request'),
          onPressed: makeRequest,
        ),//RaiseButton,
      ),//Center
    );//Scaffold
  }
}
