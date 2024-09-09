import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:morflutter/design/constants.dart';
import 'package:morflutter/display_info/databaseClass.dart';

class dataGrouped extends StatefulWidget {
  const dataGrouped({super.key});

  @override
  State<dataGrouped> createState() => _dataGroupedState();
}

class _dataGroupedState extends State<dataGrouped> {
  final database = FirebaseDatabase.instance.ref();
  User? newUser = FirebaseAuth.instance.currentUser;
  List<MorfoData> sensorDataList = [];
  Map<String, List<MorfoData>> groupedDataByDay = {};

  @override
  void initState() {
    super.initState();
    FetchMorfoData();
  }

  // Fetch data and group by day
  void FetchMorfoData() {
    String? userUID = newUser?.uid;
    String path = '/sensorSim/${userUID}/';

    database.child(path).onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      List<MorfoData> tempList = [];
      Map<String, List<MorfoData>> tempGroupedData = {};

      data.forEach((date, muscleData) {
        if (muscleData is Map<dynamic, dynamic>) {
          var morfoData =
              MorfoData.fromMap(date, Map<String, dynamic>.from(muscleData));
          tempList.add(morfoData);

          // Group data by day (assuming the date is a String in 'YYYY-MM-DD' format)
          String day = date
              .split(" ")[0]; // Split the date string to get just the day part
          if (!tempGroupedData.containsKey(day)) {
            tempGroupedData[day] = [];
          }
          tempGroupedData[day]!.add(morfoData);
        }
      });

      setState(() {
        sensorDataList = tempList;
        groupedDataByDay = tempGroupedData;
      });
    });
  }

  // Generate FLSpots for each day
  List<FlSpot> _generateSpotsForDay(List<MorfoData> dayData) {
    List<FlSpot> spots = [];
    int index = 0;
    for (var sensorData in dayData) {
      for (var reading in sensorData.muscleData) {
        spots.add(FlSpot(index.toDouble(), reading.value.toDouble()));
        index++;
      }
    }
    return spots;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: lilyPurple,
        backgroundColor: draculaPurple,
        title: Text("Sensor Data Visualization"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.graphic_eq_rounded,
                color: lilyPurple,
                size: 50,
              ),
              SizedBox(height: 20),
              Text(
                'Historial de lecturas',
                style: TextStyle(
                  fontSize: 18,
                  color: darkPeriwinkle,
                  fontFamily: 'Lausane650',
                ),
              ),
              SizedBox(height: 30),

              // Display a graph for each day
              Expanded(
                child: ListView.builder(
                  itemCount: groupedDataByDay.length,
                  itemBuilder: (context, index) {
                    String day = groupedDataByDay.keys.elementAt(index);
                    List<MorfoData> dayData = groupedDataByDay[day]!;

                    return Column(
                      children: [
                        Text(
                          "Telemetría de: ${day}",
                          style: TextStyle(
                            fontSize: 16,
                            color: draculaPurple,
                          ),
                        ),
                        AspectRatio(
                          aspectRatio: 1,
                          child: LineChart(
                            LineChartData(
                              backgroundColor: Colors.black,
                              titlesData: FlTitlesData(
                                show: true,
                                bottomTitles: AxisTitles(
                                  axisNameWidget: Text('Readings for $day'),
                                  axisNameSize: 20,
                                ),
                              ),
                              lineBarsData: [
                                LineChartBarData(
                                  color: Colors.amber,
                                  gradient: LinearGradient(colors: [
                                    morfoWhite,
                                    darkPeriwinkle,
                                  ]),
                                  isCurved: true,
                                  barWidth: 2,
                                  spots: _generateSpotsForDay(dayData),
                                  dotData: FlDotData(show: true),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
