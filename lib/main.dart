import 'dart:convert';

import 'package:flutter/material.dart';
//import 'dart:io';
//import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: Center(child: DemoNetwork()),
        ));
  }
}

class DemoNetwork extends StatefulWidget {
  @override
  _DemoNetworkState createState() => _DemoNetworkState();
}

class _DemoNetworkState extends State<DemoNetwork> {
  String title = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "$title",
            style: TextStyle(fontSize: 20),
          ),
          ElevatedButton(
            onPressed: () {
              // https://jsonplaceholder.typicode.com/guide/
              getHttp();
            },
            child: Text("Make Request"),
          )
        ],
      ),
    );
  }

  void getHttp() async {
    try {
      Response response =
          await Dio().get("https://jsonplaceholder.typicode.com/posts/1");
      var post = Post.fromJSon(jsonDecode(response.toString()));
      setState(() {
        title = post.title;
      });
      print(response);
    } catch (e) {
      print(e);
    }
  }

  /*makeHttpGetFromDartIO() {
    HttpClient client = HttpClient();
    client
        .getUrl(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'))
        .then((HttpClientRequest request) {
      return request.close();
    }).then((HttpClientResponse response) {
      var content = StringBuffer();
      response.transform(utf8.decoder).listen((data) {
        content.write(data);

        var post = Post.fromJSon(jsonDecode(content.toString()));
        setState(() {
          title = post.title;
        });
      });
    });
  }*/

  /*makeHttpGet() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/posts/1');
    //200 <= status code < 300
    if (response.statusCode == 200) {
      print(response.body);
      var post = Post.fromJSon(jsonDecode(response.body));
      setState(() {
        title = post.title;
      });
    }
  }

  makeHttpPost() async {
    var client = http.Client();
    final response =
        await client.post('https://jsonplaceholder.typicode.com/posts', body: {
      'title': 'Code4Func',
      'body': 'body code4func',
    });

    if (response.statusCode == 201) {
      var post = Post.fromJSon(jsonDecode(response.body));
      setState(() {
        title = post.title;
      });
    }
  }*/
}

class Post {
  int userId;
  int id;
  String title;
  String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJSon(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
