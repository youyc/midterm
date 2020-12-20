import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Detail_Screen extends StatefulWidget {
  //receive value from another screen
  var value;
  int index;
  Detail_Screen({Key key, this.value, this.index}) : super(key: key);
  @override
  _Detail_ScreenState createState() => _Detail_ScreenState();
}

class _Detail_ScreenState extends State<Detail_Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.value.toList()[0]["booktitle"]);
  }

  @override
  Widget build(BuildContext context) {
    List book_list = widget.value.toList();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Detail',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Book Detail'),
          backgroundColor: Colors.brown,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //upper part
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Align(
                  child: Text(
                    'BOOK ID : ${book_list[widget.index]['bookid']}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Align(
                  child: Text(
                    'ISBN : ${book_list[widget.index]['isbn']}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              SizedBox(height: 20),
              Container(
                color: Colors.amber[100],
                alignment: Alignment.center,
                child: Text(
                  book_list[widget.index]['booktitle'],
                  //textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Image.network(
                  "http://slumberjer.com/bookdepo/bookcover/${book_list[widget.index]['cover']}.jpg",
                  height: 300,
                  width: 200,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 3,
                  ),
                ),
              ),
              SizedBox(height: 20),
              RatingBarIndicator(
                rating: double.parse(book_list[widget.index]['rating']),
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 35.0,
              ),
              Text(
                book_list[widget.index]['rating'],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              //lower part
              Container(
                color: Colors.amber[100],
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 107,
                          child: Text(
                            'Author',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          ': ${book_list[widget.index]['author']}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 107,
                          child: Text(
                            'Publisher',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          ': ${book_list[widget.index]['publisher']}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Description :',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${book_list[widget.index]['description']}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Price : RM${book_list[widget.index]['price']}',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
