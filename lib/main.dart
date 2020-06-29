import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/news.dart';

const apikey = '4b84e02564784f73a518489ac3a188b7';

void main() => runApp(
      MyApp(),
    );

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  void initState() {
    fetch_data();
    super.initState();
  }

  List data_list;
  void fetch_data() async {
    http.Response response = await http
        .get('https://newsapi.org/v2/top-headlines?country=in&apiKey=$apikey');

    var dynresponse = jsonDecode(response.body);
    setState(() {
      data_list = dynresponse['articles'];
    });
    print(response.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "News App",
      home: Builder(
        builder: (context) => Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Co",
                      style: TextStyle(color: Colors.red),
                    ),
                    Text(
                      "de",
                      style: TextStyle(color: Colors.deepOrangeAccent),
                    ),
                    Text("pth News"),
                  ],
                ),
                actions: <Widget>[
                  Opacity(
                    opacity: 0,
                    child: Container(
                      child: Icon(Icons.ac_unit),
                    ),
                  ),
                ],

                centerTitle: true,
                elevation: 5.0,
                floating: false,
                expandedHeight: 200.0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset('image/codepth logo.png'),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, index) => ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => News(blogUrl: this.data_list[index]['url'],),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(data_list[index]['urlToImage']),
                    ),
                    title: Text(data_list[index]['title']),
                  ),
                  childCount: data_list == null ? 0 : data_list.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}