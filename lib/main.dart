// ignore_for_file: library_private_types_in_public_api

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

////////////////////////////////////////////////////////////////////

void main() {
  runApp(const MyApp());
}

////////////////////////////////////////////////////////////////////

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

////////////////////////////////////////////////////////////////////

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

////////////////////////////////////////////////////////////////////

class _MyHomePageState extends State<MyHomePage> {
  ///
  List<FlSpot> flspots = [const FlSpot(0, 0)];

  ///
  @override
  void initState() {
    super.initState();
    setChartData();

    startCreatingDemoData();
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: LineChart(data),
    );
  }

  ///
  void startCreatingDemoData() async {
    List<int> number = [0, 20, 70, 30, 90, 50, 70];

    for (var i = 0; i < number.length; i++) {
      if (i == 0) continue;
      await Future.delayed((Duration(milliseconds: 500))).then(
        (value) {
          flspots.add(
            FlSpot(
              double.parse(i.toString()),
              double.parse(number[i].toString()),
            ),
          );

          setState(() {
            setChartData();
          });
        },
      );
    }
  }

  ///
  LineChartData data = LineChartData();

  void setChartData() {
    data = LineChartData(
      ///

      minX: 0,
      minY: 0,
      //
      maxX: 6,
      maxY: 100,

      ///

      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.pinkAccent.withOpacity(0.3),
        ),
      ),

      ///

      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,

        //横線
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.greenAccent,
            strokeWidth: 1,
          );
        },

        //縦線
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.blueAccent,
            strokeWidth: 1,
          );
        },
      ),

      ///

      /// 全体の枠
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
      ),

      ///

      lineBarsData: [
        LineChartBarData(
          spots: flspots,
//          isCurved: true,//グラフを曲線にするか
          barWidth: 5,
          isStrokeCapRound: true,
          color: Colors.redAccent,
          belowBarData: BarAreaData(
            show: true,
            color: Colors.orangeAccent.withOpacity(0.2),
          ), // グラフの下の塗り
        ),
      ],

      ///
    );
  }
}
