import 'dart:async'; // For Timer
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart'; // For the chart
import 'package:flutter/material.dart';
import 'package:morflutter/design/constants.dart';
import 'package:morflutter/display_info/databaseClass.dart';
import 'package:morflutter/display_info/sensorData.dart'; // Flutter essentials

class timerSendPage extends StatefulWidget {
  @override
  _timerSendPageState createState() => _timerSendPageState();
}

class _timerSendPageState extends State<timerSendPage> {
  /* ===================== DATABASE DATA FETCHING ================= */

  final database = FirebaseDatabase.instance.ref();
  User? newUser = FirebaseAuth.instance.currentUser;
  List<MorfoData> sensorDataList = [];

  @override
  void initState() {
    super.initState();
    FetchMorfoData();
  }

  void FetchMorfoData() {
    String? userUID = newUser?.uid;
    String path = '/sensorSim/${userUID}/';

    database.child(path).onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      List<MorfoData> tempList = [];

      data.forEach((date, muscleData) {
        if (muscleData is Map<dynamic, dynamic>) {
          tempList.add(
              MorfoData.fromMap(date, Map<String, dynamic>.from(muscleData)));
        }
      });

      setState(() {
        sensorDataList = tempList;
      });
    });
  }

  /* ================== GENERATE SPOTS FROM DATABASE ========================= */

  List<FlSpot> _generateSpots() {
    List<FlSpot> spots = [];
    int index = 0;

    for (var sensorData in sensorDataList) {
      for (var reading in sensorData.muscleData) {
        spots.add(FlSpot(index.toDouble(), reading.value.toDouble()));
        index++;
      }
    }

    return spots;
  }

  /* ================== TIMER AND CHART DISPLAY ========================= */

  List<FlSpot> spots = [];
  bool isCollectingData = false;
  Timer? _timer;
  int _remainingTime = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EMG Sensor Data Collection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!isCollectingData)
                ElevatedButton(
                  onPressed: startDataCollection,
                  child: Text('Start Data Collection'),
                ),
              if (isCollectingData)
                Column(
                  children: [
                    Text('Collecting data... $_remainingTime seconds left'),
                    SizedBox(height: 20),
                    AspectRatio(
                      aspectRatio: 1,
                      child: LineChart(LineChartData(
                        backgroundColor: Colors.black,
                        titlesData: FlTitlesData(
                          show: true,
                          rightTitles: AxisTitles(
                            axisNameWidget: Text('Sensor data'),
                            axisNameSize: 20,
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            axisNameSize: 50,
                            axisNameWidget: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('TOMA 1'),
                                Text('TOMA 2'),
                                Text('TOMA 3'),
                              ],
                            ),
                          ),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            color: Colors.amber,
                            gradient: LinearGradient(colors: [
                              morfoWhite,
                              darkPeriwinkle,
                              darkPeriwinkle,
                            ]),
                            isCurved: true,
                            barWidth: 2,
                            spots: _generateSpots(),
                            dotData: FlDotData(
                              show: true,
                              getDotPainter: (FlSpot spot, double percent,
                                  LineChartBarData barData, int index) {
                                List<FlSpot> spots = barData.spots;

                                if (spot.y == findMaxValue(spots)) {
                                  return FlDotCirclePainter(
                                    radius: 6,
                                    color: Colors.blue,
                                    strokeWidth: 2,
                                    strokeColor: Colors.white,
                                  );
                                } else {
                                  return FlDotCirclePainter(
                                    radius: 4,
                                    color: lilyPurple,
                                    strokeWidth: 2,
                                    strokeColor: Colors.white,
                                  );
                                }
                              },
                            ),
                          )
                        ],
                      )),
                    ),
                  ],
                ),
              SizedBox(height: 20),
              if (!isCollectingData && spots.isNotEmpty)
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context,
                        MaterialPageRoute(builder: (context) => dataVis()));
                  },
                  child: Text('Generate Report'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void startDataCollection() {
    setState(() {
      isCollectingData = true;
      _remainingTime = 10;
      spots = _generateSpots(); // Clear previous data and use new spots
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime--;

        if (_remainingTime <= 0) {
          stopDataCollection();
        }
      });
    });
  }

  void stopDataCollection() {
    _timer?.cancel();
    setState(() {
      isCollectingData = false;
    });

    // Notify user that data collection is done
    showMaxValueDialog(context, findMaxValue(spots));
  }

  double findMaxValue(List<FlSpot> spots) {
    return spots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
  }

  void showMaxValueDialog(BuildContext context, double maxValue) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Max Value'),
        content: Text('The maximum value recorded is: $maxValue'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Sensor Data Report'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Report: ${spots.length} data points collected.'),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: spots.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    'Point $index: X=${spots[index].x}, Y=${spots[index].y}',
                  ),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
