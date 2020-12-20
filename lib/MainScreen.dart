import 'DetailScreen.dart';
import 'Book.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:convert';

void main() => runApp(My_App());

List book_list;

class My_App extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<My_App> {
  int book_list_size;
  int book_selected_index;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _load_book();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'List of Books',
      routes: <String, WidgetBuilder>{
        "/MainScreen": (BuildContext context) => My_App(),
        "/DetailScreen": (BuildContext context) => Detail_Screen(
              value: book_list,
              index: book_selected_index,
            ),
      },
      home: Scaffold(
        appBar: AppBar(
          title: Text('List of Books'),
          backgroundColor: Colors.brown,
        ),
        body: book_list == null
            ? Container()
            : Container(
                color: Colors.amber[100],
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.55,
                  ),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      book_selected_index = index;
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        "/DetailScreen",
                        (route) => true,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.brown[900]),
                        color: Colors.white70,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 2,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 290,
                            child: Column(
                              children: [
                                Container(
                                  child: Image.network(
                                    "http://slumberjer.com/bookdepo/bookcover/${book_list[index]['cover']}.jpg",
                                    height: 170,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 3,
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 20,
                                ),
                                //book title
                                Text(
                                  book_list[index]['booktitle'].toString(),
                                  textAlign: TextAlign.center,
                                  // overflow: TextOverflow.ellipsis,
                                  // softWrap: false,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                //author
                                Text(
                                  'Author: ${book_list[index]['author'].toString()}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //price and rating bar
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.amber[400],
                              borderRadius: BorderRadiusDirectional.vertical(
                                bottom: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              children: [
                                //price
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'RM ${book_list[index]['price'].toString()}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  alignment: Alignment.centerRight,
                                  child: RatingBarIndicator(
                                    rating: double.parse(
                                        book_list[index]['rating']),
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.deepPurple,
                                    ),
                                    itemCount: 5,
                                    itemSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  itemCount: book_list_size,
                ),
              ),
      ),
    );
  }

  void _load_book() async {
    http.post(
      'http://slumberjer.com/bookdepo/php/load_books.php',
      body: {},
    ).then((res) {
      if (res.body == 'nodata') {
        print('no data');
      } else {
        //print(res.body);
        var books_jscode = json.decode(res.body);
        book_list = books_jscode['books'];
        book_list_size = book_list.length;
        print(book_list_size);
      }

      // if (res.body == 'nodata') {
      //   print('failed');
      // } else {
      //   print('yes');
      // }

      // if (res.body == "success") {
      //   Toast.show(
      //     "Get success.",
      //     context,
      //     duration: 4,
      //     gravity: Toast.BOTTOM,
      //   );
      // } else {
      //   print(res);
      //   Toast.show(
      //     "Get failed",
      //     context,
      //     duration: Toast.LENGTH_LONG,
      //     gravity: Toast.BOTTOM,
      //   );
      // }
    }).catchError((err) {
      print(err);
    });
  }
}
