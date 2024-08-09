import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:morflutter/design/constants.dart';
import 'package:morflutter/display_info/databaseClass.dart';
import 'package:morflutter/starting_pages/ui/homepage.dart';

class dataVis extends StatefulWidget {
  const dataVis({super.key});

  @override
  State<dataVis> createState() => _dataVisState();
}

class _dataVisState extends State<dataVis> {
  final database = FirebaseDatabase.instance.ref();
  User? newUser = FirebaseAuth.instance.currentUser;
  List<MorfoData> sensorDataList = [];

  /**
   *  Initializes our app state so that it can read data in real time.
   */
  @override
  void initState() {
    super.initState();
    //_activateListeners();
    FetchMorfoData();
  }

  /**
   * _A method to fetch data from RTDB and only make use of the classes in our code.
   *  The same used in our @databaseLink page.
   */
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

  /**
   *  Listens to any updates to the desired child in the database.
   */
  void _activateListeners() {
    String? userUID = newUser?.uid;
    String path = '/sensorSim/$userUID/';
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

  /**
   * Generate FL spots.
   */

  List<FlSpot> _generateSpots() {
    // Create al FLSpot object list.
    List<FlSpot> spots = [];
    int index = 0;
    // iterate in our data and append to the list.
    for (var sensorData in sensorDataList) {
      for (var reading in sensorData.muscleData) {
        print('Data: ${sensorData.muscleData}');
        spots.add(FlSpot(index.toDouble(), reading.value.toDouble()));
        index++;
      }
    }

    print('Spots: ${spots}');
    return spots;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: lilyPurple,
        backgroundColor: draculaPurple,
        title: Image(
          width: 120,
          image: AssetImage(
              'lib/design/logos/principal_morado_negro-removebg-preview.png'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.graphic_eq_rounded,
                color: lilyPurple,
                shadows: [
                  Shadow(color: lilyPurple),
                  Shadow(color: darkPeriwinkle),
                ],
                size: 50,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Telemetría de sensores EMG',
                style: TextStyle(
                    fontSize: 18,
                    color: darkPeriwinkle,
                    fontFamily: 'Lausane650'),
              ),
              SizedBox(
                height: 30,
              ),
              AspectRatio(
                aspectRatio: 1,
                child: LineChart(LineChartData(
                    backgroundColor: Colors.black,
                    titlesData: FlTitlesData(
                        show: true,
                        rightTitles: AxisTitles(
                            axisNameWidget: Text('Sensor data'),
                            axisNameSize: 20,
                            sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                            axisNameSize: 50,
                            axisNameWidget: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Día 1',
                                ),
                                Text('Día 2'),
                                Text('Día 3'),
                              ],
                            ))),
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
                      ),
                    ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
