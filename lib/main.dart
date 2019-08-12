import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

 void main() => runApp(new MyApp());

 class MyApp extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       title: "Http fetch Data",
       theme: new ThemeData(
         primarySwatch: Colors.blueGrey,
       ),
       home: new HomePage(),
     );
   }
 }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String url = "https://swapi.co/api/people";
  List data;

  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }

Future<String> getJsonData() async{
    var response = await http.get(
    //encode url
    Uri.encodeFull(url),
    //only accept json response
    headers: {"Accept": "application/json"}
  );
  print(response.body);

  setState(() {
    var conertDataTojson = jsonDecode(response.body);
    data = conertDataTojson['results'];
  });
  return "Success";
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Fetch Json via HTTP Get"),
      ),
      body: ListView.builder(
        itemCount: data == null ? 0: data.length,
        itemBuilder: (context, index){
          return Container(
            child: new Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child: new Container(
                      child: new Text(data[index]['name']),
                      padding: const EdgeInsets.all(20.0),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}