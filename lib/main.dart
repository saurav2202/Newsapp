import 'package:flappy_search_bar/flappy_search_bar.dart';
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
        .get('http://newsapi.org/v2/everything?q=tech&apiKey=$apikey');
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
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: CustomSearchDelegate(),
                      );
                    },
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

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SearchBar(),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  MyAppState data = new MyAppState();
  List searchlist;
  void initstate() {
    searchlist = data.data_list;
    print(searchlist.length);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.cancel),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
//    final mylist = query.isEmpty
//        ? loadFoodItem()
//        : loadFoodItem().where((p) => (p.title.contains(query))||p.category.contains(query)).toList();

    return ListView.builder(
        itemCount: searchlist.length,
        itemBuilder: (context, index) {
//          final FoodItem listitem = mylist[index];
//          return ListTile(
//            onTap: (){
//
//            },
//            title: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Text(
//                  listitem.title,
//                  style: TextStyle(fontSize: 20),
//                ),
//                Text(listitem.category),
//                Divider(),
//              ],
//            ),
//          );
          return new Text(data.data_list[index]['title']);
        });
  }
}

class FoodItem {
  final String title;
  final String category;
  FoodItem({
    this.title,
    this.category,
  });
}

List<FoodItem> loadFoodItem() {
  var fi = [];
//  <FoodItem>[
//    FoodItem(
//      title: "chocolate",
//      category: "Milkshake",
//    ),
//    FoodItem(
//      title: "Hakka Noodles",
//      category: "Chinese",
//    ),
//    FoodItem(
//      title: "Samosa",
//      category: "Indian",
//    ),
//    FoodItem(
//      title: "Oreo Shake",
//      category: "Milkshakes",
//    ),
//    FoodItem(
//      title: "Spring Roles",
//      category: "Chinese",
//    ),
//    FoodItem(
//      title: "Coke",
//      category: "Cold Drinks",
//    ),
//    FoodItem(
//      title: "Dum Aloo",
//      category: "Indian",
//    ),
//    FoodItem(
//      title: "Pizza",
//      category: "Italian",
//    ),
//  ];
  return fi;
}
