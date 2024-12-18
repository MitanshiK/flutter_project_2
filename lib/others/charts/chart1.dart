import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart1 extends StatefulWidget {
  const Chart1({super.key});

  @override
  State<Chart1> createState() => _Chart1State();
}

class _Chart1State extends State<Chart1> {
  final ZoomPanBehavior _zoomPanBehavior =ZoomPanBehavior(
                               enableSelectionZooming: true , // make a selection by long pressing to zoom
                               enableDoubleTapZooming: true,
                               enablePinching: true,
                               enablePanning: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Charts"),),
      body:  SingleChildScrollView(
        child: Column(
          children: [
          const  Text("Monthly CORONA victims stats"),
          //1
            SfCartesianChart(
               zoomPanBehavior: _zoomPanBehavior,
            // onZooming: (ZoomPanArgs args) => zoom(args),
           
            primaryXAxis: const CategoryAxis(),
            legend: const Legend(isVisible:  true),
            tooltipBehavior: TooltipBehavior(enable: true),
            title: const ChartTitle(text: "LineSeries [SfCartesianChart]"),
              series: <LineSeries<Infections,String>>[
                LineSeries<Infections,String>(
                  dataSource:const <Infections> [
                   
                  ],
                  xValueMapper: (Infections victims,_) => victims.month, // values along x axis
                  yValueMapper: (Infections victims,_) => victims.victims, // values along y axis 
                  // xAxisName: "Months",
                  // yAxisName: "victim",
            
                   dataLabelSettings: const DataLabelSettings(isVisible: true), //shows the values on map
                   markerSettings: const MarkerSettings(isVisible: true),// shows dots on value on graph
                   ),
              ],
            
            ),
            //2
            const SizedBox(height: 20),
            SfCircularChart( 
           selectionGesture: ActivationMode.singleTap,
           
            legend: const Legend(isVisible:  true),
            tooltipBehavior: TooltipBehavior(enable: true),
            title: const ChartTitle(text: "DoughnutSeries [SfCircularChart]"),
              series: <DoughnutSeries<Infections,String>>[
                DoughnutSeries<Infections,String>(
                  dataSource:<Infections> [
                    Infections("jan",100),
                    Infections("Feb",400),
                    Infections("Mar",700),
                    Infections("Apr",600),
                    Infections("May",1000),
                    Infections("Jun",1500),
                    Infections("Jul",1200),
                    Infections("Aug",2000),
                    Infections("Sep",2400),
                    Infections("Oct",1600),
                    Infections("Nov",4400),
                    Infections("Dec",3000)
            
                  ],
                  xValueMapper: (Infections victims,_) => victims.month, // values along x axis
                  yValueMapper: (Infections victims,_) => victims.victims, // values along y axis 
            
                   dataLabelSettings: const DataLabelSettings(isVisible: true), //shows the values on map
                  //  markerSettings: const MarkerSettings(isVisible: true),// shows dots on value on graph
                   ),
              ],
            ),
            //3
          ],
        ),
      )
    );
  }
}

class Infections{
 final String month;
 final int victims;

  Infections(this.month,this.victims);

}