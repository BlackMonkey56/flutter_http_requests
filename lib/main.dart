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

  String url = 'https://randomuser.me/api?results=15';
  List data;

  Future<String> makeRequest() async {
    var response = await http.get(Uri.encodeFull(url),
        headers: {"Accept": "application/json"});


    setState(() {
      var extractData = json.decode(response.body);
      data = extractData["results"];
    });



  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Contact List'),
      ),//AppBar
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, i){
          return new ListTile(
            title: new Text(data[i]["name"]["first"]),
            subtitle: new Text(data[i]["phone"]),
            leading: new CircleAvatar(
              backgroundImage: new NetworkImage(data[i]["picture"]["thumbnail"]),
            ),//CircleAvatar
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new SecondPage(data[i])
                ));//MaterialPageRoute
            },
          );//ListTilet
        }),//ListView.builder
    );//Scaffold
  }
}

class SecondPage extends StatelessWidget {
  SecondPage(this.data);
  final data;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Second page'),
      ),//AppBar
      body: new Center(
        child: new Container(
          width: 150.0,
          height: 150.0,
          decoration: new BoxDecoration(
            color: const Color(0xff7c94b6),
            image: new DecorationImage(
              image: new NetworkImage(data["picture"]["large"]),
              fit: BoxFit.cover,
            ),//DecorationImage
            borderRadius: new BorderRadius.all(new Radius.circular(75.0)),
            border: new Border.all(
              color: Colors.greenAccent,
              width: 4.0
            ),//Border.all
          ),//BoxDecoration
        ),//Container
      ),//Center
    );//Scaffold
  }
}
