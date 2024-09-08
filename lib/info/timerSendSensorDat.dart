import 'dart:async'; // For Timer
import 'package:fl_chart/fl_chart.dart'; // For the chart
import 'package:flutter/material.dart'; // Flutter essentials

class timerSendPage extends StatefulWidget {
  @override
  _timerSendPageState createState() => _timerSendPageState();
}

class _timerSendPageState extends State<timerSendPage> {
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
              if (!isCollectingData) // Only show this if not collecting data
                ElevatedButton(
                  onPressed: startDataCollection,
                  child: Text('Start Data Collection'),
                ),
              if (isCollectingData) // Show timer and data graph during collection
                Column(
                  children: [
                    Text('Collecting data... $_remainingTime seconds left'),
                    SizedBox(height: 20),
                    AspectRatio(
                      aspectRatio: 1,
                      child: LineChart(
                        LineChartData(
                          lineBarsData: [
                            LineChartBarData(
                              spots: spots,
                              isCurved: true,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 20),
              if (!isCollectingData && spots.isNotEmpty)
                ElevatedButton(
                  onPressed: () => showReportDialog(context),
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
      spots = []; // Clear previous data
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime--;
        _collectData(); // Collect data for 30 seconds
      });

      if (_remainingTime <= 0) {
        stopDataCollection();
      }
    });
  }

  void _collectData() {
    // Simulate sensor data collection (replace this with actual data fetching logic)
    double x = 30 - _remainingTime.toDouble();
    double y = (x % 2 == 0) ? 2.0 : 1.0; // Simulated data points

    setState(() {
      spots.add(FlSpot(x, y));
    });
  }

  void stopDataCollection() {
    _timer?.cancel();
    setState(() {
      isCollectingData = false;
    });

    // Optional: Notify user that data collection is done
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
    // Implement logic to generate and display the report based on the collected data
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Sensor Data Report'),
        content: Text('Report: ${spots.length} data points collected.'),
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
