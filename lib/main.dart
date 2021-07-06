import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_to_text.dart';



void main() {
  runApp(MaterialApp(
    home: MyApp(),
    theme: ThemeData(
      primarySwatch: Colors.green,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    routes: <String, WidgetBuilder>{

    }
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double confidence = 1.0;
  SpeechToText speech = SpeechToText();
  bool isListening = false;
  String text = "Press the button to start speaking";

  @override
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        endRadius: 75,
        animate: isListening,
        glowColor: Theme.of(context).primaryColor,
        duration:  Duration(milliseconds: 2000),
        repeatPauseDuration:  Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: listen,
          child: Icon(isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      appBar: AppBar(
        title: Text("Confdence: ${(confidence * 100.0).toStringAsFixed(1)}%"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(children: <Widget>[
            Container(
              child: Text(text,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
              ),
            ),
            // Container(
            //   child: TextField(
            //     decoration: InputDecoration(
            //       labelText: "Speek to search",
            //       suffixIcon: IconButton(
            //         icon: Icon(Icons.mic),
            //         onPressed: ,
            //       )
            //     ),
            //   ),
            // ),
          ]),
        ),
      ),
    );
  }

  void listen() async {
    if (!isListening) {
      bool available = await speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => isListening = true);
        speech.listen(
          onResult: (val) => setState(() {
            text = val.recognizedWords;
            print("ok $text");
            if (val.hasConfidenceRating && val.confidence > 0) {
              confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => isListening = false);
      print("not ok");
      speech.stop();
    }
  }

}
