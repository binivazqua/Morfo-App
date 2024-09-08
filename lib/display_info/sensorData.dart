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

  List<FlSpot> _generateSpotsColored() {
    // Create al FLSpot object list.
    List<FlSpot> spots = [];
    int index = 0;
    // iterate in our data and append to the list.
    for (var sensorData in sensorDataList) {
      for (var reading in sensorData.muscleData) {
        if (reading.value.toDouble() > 180) {
          spots.add(FlSpot(index.toDouble(), reading.value.toDouble()));
        }
        print('Data: ${sensorData.muscleData}');
        spots.add(FlSpot(index.toDouble(), reading.value.toDouble()));
        index++;
      }
    }

    print('Spots: ${spots}');
    return spots;
  }

  /* ================== CUSTOM FUNCTION FOR DATA VISUALIZATION ===================== */

  String customCheck(List<FlSpot> spots, int index) {
    // Case 1: Check if the value is negative
    if (spots[index].y < 98) {
      return "IS FALSE"; // Negative value detected
    }

    // Case 2: Check for values within a threshold of 10 units over 3 consecutive spots
    const int consecutiveCount = 2; // Number of consecutive spots to check
    const double threshold = 10.0; // Threshold of 10 units difference
    const double max_value = 10.0; // Threshold of 10 units difference

    if (index >= consecutiveCount - 1) {
      bool isWithinThreshold = true;

      // Compare the current spot with the previous consecutive spots
      for (int i = 1; i < consecutiveCount; i++) {
        double diff = (spots[index - i].y - spots[index].y).abs();
        if (diff > threshold) {
          isWithinThreshold = false;
          break;
        }
      }

      if (isWithinThreshold) {
        return "WITHIN THRESHOLD"; // Values are within the 10-unit threshold for consecutive spots
      }
    }

    return "OUT OF THRESHOLD"; // No special case detected
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
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (FlSpot spot, double percent,
                              LineChartBarData barData, int index) {
                            List<FlSpot> spots =
                                barData.spots; // Access all spots

                            // Use the custom check to determine the color
                            if (customCheck(spots, index) == "IS FALSE") {
                              return FlDotCirclePainter(
                                radius: 4,
                                color: Colors
                                    .red, // Custom condition met (constant value or negative value)
                                strokeWidth: 2,
                                strokeColor: Colors.white,
                              );
                            } else if (customCheck(spots, index) ==
                                "WITHIN THRESHOLD") {
                              return FlDotCirclePainter(
                                radius: 4,
                                color: Colors.green, // Default color
                                strokeWidth: 2,
                                strokeColor: Colors.white,
                              );
                            } else {
                              return FlDotCirclePainter(
                                radius: 4,
                                color: lilyPurple, // Default color
                                strokeWidth: 2,
                                strokeColor: Colors.white,
                              );
                            }
                          },
                        ),
                      )
                    ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
