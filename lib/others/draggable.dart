import 'package:flutter/material.dart';

class DarggableWidget extends StatefulWidget {
  const DarggableWidget({super.key});

  @override
  State<DarggableWidget> createState() => _DarggableWidgetState();
}

class _DarggableWidgetState extends State<DarggableWidget> {

String targetText="Drop here";
Color targetColor=Colors.grey;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
                Draggable(
                 
                  affinity: null,
                  feedback: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(color: Colors.yellow),
                ),
                childWhenDragging:  Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(color: Colors.blue),
                 ),
                 data: const {
                  "Color":Colors.purple,
                  "text" :"purple"
                  },
                  child: Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(color: Colors.yellow),
                  child: const Text("drag it"),
                ),
                ),
      
                DragTarget(
                  builder: (BuildContext context, List<Object?> candidateData, List<dynamic> rejectedData) {  
                    
                    return Container(
                      width: 250,
                      height: 250,
                      color: targetColor,
                      child: Text(targetText),
                    );
                  },
                  onAcceptWithDetails: (DragTargetDetails<Map>  details) => {
                    if(details.data!=null){
                       targetColor=details.data["Color"]
                    }
      
                  },
                  )
        ],),
      ),
    );
  }
}