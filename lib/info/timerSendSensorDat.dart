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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (!isCollectingData)
                  Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Tu centro de telemetría',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: darkPeriwinkle),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'En este espacio podrás visualizar tu datos electromiográficos en tiempo real para fortalecer tu conexión cerebro-músculo.'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '¿Cómo lo hago?',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 20, color: darkPeriwinkle),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'Durante un periodo de tiempo de tu elección, realizarás una serie de liberaciones y contracciones para adaptarte al uso de electrodos.'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '1. Escoge tu tiempo',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 15,
                            color: lilyPurple,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('De 10, 30 y 60 segundos.'),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '2. Concéntrate',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 15,
                            color: lilyPurple,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'Apóyate en tu profesional rehabilitador para generar conciencia cerebro-músculo.'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '3. Empieza a probar',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 15,
                            color: lilyPurple,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'Contrae y libera en distinta intensidad para encontrar tus puntos de máximo alcance y reposo.'),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: startDataCollection,
                            child: Text(
                              'Recopilar datos',
                              style: TextStyle(color: morfoWhite),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(lilyPurple)),
                          ),
                        ],
                      )
                    ],
                  )),
                if (isCollectingData)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Text(
                          'Recopilando datos $_remainingTime segundos restantes'),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                    onPressed: () => showReportDialog(
                        context, findMaxValue(spots), findMinValue(spots)),
                    child: Text('Generar Reporte'),
                  ),
              ],
            ),
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

  double findMinValue(List<FlSpot> spots) {
    return spots.map((spot) => spot.y).reduce((a, b) => a < b ? a : b);
  }

  void showMaxValueDialog(BuildContext context, double maxValue) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Max Value'),
        content: Text('Nuevo máximo detectado: $maxValue'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void showReportDialog(
      BuildContext context, double maxValue, double minValue) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Reporte de Telemetría',
          style: TextStyle(color: lilyPurple, fontSize: 20),
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Reporte: ${spots.length} puntos recolectados.'),
            Text('Valor máximo: ${maxValue} '),
            Text('Valor mínimo: ${minValue} '),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}
