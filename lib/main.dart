import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
        .get('http://newsapi.org/v2/everything?q=tech&apiKey=$apikey');
    print('hello there');
    var dynresponse = jsonDecode(response.body);
    setState(() {
      data_list = dynresponse['articles'];
    });
    print(response.statusCode);
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "News App",
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Codeth News'),
              floating: false,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset('image/codepth logo.png'),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(data_list[index]['urlToImage']),
                  ),
                  title: Text(data_list[index]['title']),
                ),
                childCount: data_list==null?0:data_list.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
