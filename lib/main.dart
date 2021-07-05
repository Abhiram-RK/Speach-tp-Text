import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    theme: ThemeData(
      primarySwatch: Colors.green,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: Icon(Icons.mic),
      ),
      appBar: AppBar(
        title: Text("Speach 2 Text"),
      ),
      body: Container(
        child: Container(
          child: Column(children: <Widget>[
            Container(
              child: Text("Speech 2 Text"),
            )
          ]),
        ),
      ),
    );
  }
}
