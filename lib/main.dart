import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(const MaterialApp(
    routes: {},
    home: Homepage(),
  ));
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String url = "assets/click me.png";
  String title = "I want random meme";
  var index = Random().nextInt(99);
  Future<void> getData() async {
    //making request to api
    Response res = await get(Uri.parse('https://api.imgflip.com/get_memes'));

    //saving data in Map format
    Map fact = jsonDecode(res.body);

    //getting properties from data
    title = fact['data']['memes'][index]['name'];
    url = fact['data']['memes'][index]['url'];
    print(title);
    print(url);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[850],
      /*appBar: AppBar(
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        title: const Text(" "),
      ),*/
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: width,
              height: height / 10,
              child: const FlatButton(
                  onPressed: null,
                  child: Text("Click for more template",
                      style: TextStyle(color: Colors.white, fontSize: 15)))),
          FittedBox(
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    index = Random().nextInt(99);
                    print(index);
                  });

                  getData();
                },
                child: Image.network(
                  url,
                  height: (MediaQuery.of(context).size.height / 2),
                  width: (MediaQuery.of(context).size.width),
                )),
          ),
          FittedBox(
            child: Container(
                width: width,
                height: height / 10,
                child: FlatButton(
                    onPressed: null,
                    child: Text(title,
                        style: TextStyle(color: Colors.white, fontSize: 20)))),
          )
        ],
      ),
      floatingActionButton: const Text('a website by rahulpal aka pratishodhi', style: TextStyle(fontStyle: FontStyle.italic),),

    );
  }
}
