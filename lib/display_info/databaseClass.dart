/**
 * Create a MuscleReading class to parse our muscle data with filters:
 */
class MuscleReading {
  final String muscle;
  final int value;

  MuscleReading({required this.muscle, required this.value});
}

/**
 * Our database model to gather values in a structured way:
 */
class MorfoData {
  final String time;
  final List<MuscleReading> muscleData;

  MorfoData({required this.time, required this.muscleData});

  // Factory constructor to create a SensorData object from a map:
  factory MorfoData.fromMap(String time, Map<String, dynamic> muscleData) {
    List<MuscleReading> muscleReadings = [];

    muscleData.forEach((muscle, readings) {
      if (readings is Map<dynamic, dynamic>) {
        readings.forEach((key, value) {
          muscleReadings.add(MuscleReading(muscle: muscle, value: value));
        });
      }
    });

    return MorfoData(time: time, muscleData: muscleReadings);
  }
}
