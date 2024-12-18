
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' ;

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
 final Map<String, HighlightedWord> _highlights={
  //1
  "flutter":HighlightedWord(
    onTap: (){
    debugPrint("flutter");
  },
  textStyle: const TextStyle(
    color: Colors.blue
  )),

  //2
    "Hello":HighlightedWord(
    onTap: (){
    debugPrint("Hello");
  },
  textStyle: const TextStyle(
    color: Colors.purple
  )),

  //3
      "Bye":HighlightedWord(
    onTap: (){
    debugPrint("Bye");
  },
  textStyle: const TextStyle(
    color: Colors.red
  )),

 };
  
  late SpeechToText _speech;
  bool _isListening=false;
  String _text= "press button and start speaking ";
  double _confidence=1.0;

 @override
  void initState() {
    super.initState();
    _speech=SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(title: Text("Confidence level :${(_confidence * 100.0).toStringAsFixed(1)}%"),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Colors.amber,
        duration: const  Duration(milliseconds: 200),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic :Icons.mic_none),
          ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child:Container(
          padding:const EdgeInsets.all(10),
          child: TextHighlight(
            text: _text,
             words: _highlights,),
          ) 
        ),
    );
  }
  void _listen() async{
   if(!_isListening){
    bool available=await _speech.initialize(
    onStatus: (val){print("status is $val");},
    onError: (error){print("error is $error");}
   );
   if(available){
    setState(() {
      _isListening=true;
    });
    _speech.listen(
    onResult: (val)=>
    setState(() {
      _text=val.recognizedWords;
      if(val.hasConfidenceRating && val.confidence>0){
        _confidence=val.confidence;
      }
    })
    );
   }
   else{
    setState(() {
      _isListening=false;
      _speech.stop();
    });
   }
   }
  }
}