import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:morflutter/design/constants.dart';
import 'package:morflutter/display_info/databaseClass.dart';
import 'package:morflutter/display_info/databaseGrouped.dart';
import 'package:morflutter/display_info/sensorData.dart';
import 'package:morflutter/info/timerSendSensorDat.dart';

class databaseReadTest extends StatefulWidget {
  const databaseReadTest({super.key});

  @override
  State<databaseReadTest> createState() => _databaseReadTestState();
}

class _databaseReadTestState extends State<databaseReadTest> {
  // MORFO DATABASE REFERENCE:
  final database = FirebaseDatabase.instance.ref();

  // AUTH INSTANCE:
  User? newUser = FirebaseAuth.instance.currentUser;

  // Primary data:
  String databaseData = 'Data from database will be here';

  // Morfo Data lIST:
  List<MorfoData> morfoDataList = [];

  /**
   *  Initializes our app state so that it can read data in real time.
   */
  @override
  void initState() {
    super.initState();
    //_activateListeners();
    FetchMorfoData();
  }

  void LogOut() {
    FirebaseAuth.instance.signOut();
  }

  /**
   *  Listens to any updates to the desired child in the database.
   */
  void _activateListeners() {
    // taking current user UID to implement it in the path.
    String? userUID = newUser?.uid;
    String path = '/sensorSim/${userUID}/';
    print('Activating listeners at path: ${path}');

    /** 
     * Stream of events listener:
     *  where 'event' is our data.
    * */

    database.child(path).onValue.listen((event) {
      // saving our retrieved value in a variable:
      final String data = event.snapshot.value.toString();

      // create a SetState() call to change our value.
      setState(() {
        databaseData = 'Raw Database data:' + data;
      });
    });
  }

  /** 
   * Fetch data function.
   */

  void FetchMorfoData() {
    // taking current user UID to implement it in the path.
    String? userUID = newUser?.uid;
    String path = '/sensorSim/${userUID}/';

    print('Activating listeners at path: ${path}');

    database.child(path).onValue.listen((event) {
      final morfoData = event.snapshot.value as Map<dynamic, dynamic>;
      List<MorfoData> tempList = [];
      morfoData.forEach((date, muscleData) {
        if (muscleData is Map<dynamic, dynamic>) {
          tempList.add(
              MorfoData.fromMap(date, Map<String, dynamic>.from(muscleData)));
        }
      });
      setState(() {
        morfoDataList = tempList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String? userUID = newUser?.uid;
    String path = '/sensorSim/${userUID}/';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: lilyPurple,
        title: Image(
            image: AssetImage(
              'lib/design/logos/rectangular_vino_trippypurplep.png',
            ),
            width: 120),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => dataGrouped()));
                  },
                  icon: Icon(
                    Icons.graphic_eq,
                    color: draculaPurple,
                  ))),
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => timerSendPage()));
                  },
                  icon: Icon(
                    Icons.timer,
                    color: draculaPurple,
                  )))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Lecturas previas:',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Lausane650',
                      color: draculaPurple),
                ),
                SizedBox(
                  height: 30,
                ),
                /**
                 * USING A STREAM BUILDER AS AN EVENT LISTENER:
                 */

                StreamBuilder(
                  stream: database.child(path).onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data!.snapshot.value != null) {
                      final data = Map<String, dynamic>.from(
                          snapshot.data!.snapshot.value as Map);
                      List<MorfoData> sensorDataList = [];

                      // Parsing the data from the database
                      data.forEach((date, muscleData) {
                        if (muscleData is Map<dynamic, dynamic>) {
                          sensorDataList.add(MorfoData.fromMap(
                              date, Map<String, dynamic>.from(muscleData)));
                        }
                      });

                      // Sorting the list by date chronologically
                      sensorDataList.sort((a, b) {
                        DateTime dateA = DateTime.parse(a
                            .time); // Assuming 'time' is in ISO 8601 or similar format
                        DateTime dateB = DateTime.parse(b.time);
                        return dateA.compareTo(
                            dateB); // For ascending order (oldest first)
                      });

                      // Grouping data by day (yyyy-MM-dd)
                      Map<String, List<MorfoData>> groupedData = {};
                      for (var sensorData in sensorDataList) {
                        DateTime date = DateTime.parse(sensorData.time);
                        String day =
                            '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

                        if (groupedData[day] == null) {
                          groupedData[day] = [];
                        }
                        groupedData[day]!.add(sensorData);
                      }

                      return SingleChildScrollView(
                        child: ListView(
                          shrinkWrap: true,
                          children: groupedData.entries.map((entry) {
                            String day = entry.key;
                            List<MorfoData> readings = entry.value;

                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 8.0),
                              padding: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    day,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Column(
                                    children: readings.map((sensorData) {
                                      return ListTile(
                                        title: Text(
                                          sensorData.time,
                                          style: TextStyle(
                                            fontFamily: 'Lausane650',
                                            color: darkPeriwinkle,
                                          ),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: sensorData.muscleData
                                              .map((reading) {
                                            return Text(
                                                '${reading.muscle}: ${reading.value}');
                                          }).toList(),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),

/*
                StreamBuilder(
                  stream: database.child(path).onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data!.snapshot.value != null) {
                      final data = Map<String, dynamic>.from(
                          snapshot.data!.snapshot.value as Map);
                      List<MorfoData> sensorDataList = [];

                      data.forEach((date, muscleData) {
                        if (muscleData is Map<dynamic, dynamic>) {
                          sensorDataList.add(MorfoData.fromMap(
                              date, Map<String, dynamic>.from(muscleData)));
                        }
                      });

                      // Sorting the list by date chronologically
                      sensorDataList.sort((a, b) {
                        DateTime dateA = DateTime.parse(a
                            .time); // Assuming 'time' is in ISO 8601 or similar format
                        DateTime dateB = DateTime.parse(b.time);
                        return dateA.compareTo(
                            dateB); // For ascending order (oldest first)
                      });

                      return ListView.builder(
                        // single child scrollview allowed:
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: sensorDataList.length,
                        itemBuilder: (context, index) {
                          final sensorData = sensorDataList[index];
                          return ListTile(
                            title: Text(
                              sensorData.time,
                              style: TextStyle(
                                  fontFamily: 'Lausane650',
                                  color: darkPeriwinkle),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: sensorData.muscleData.map((reading) {
                                return Text(
                                    '${reading.muscle}: ${reading.value}');
                              }).toList(),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),

                */
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(lilyPurple)),
                    onPressed: LogOut,
                    child: Text(
                      'Log Out',
                      style: TextStyle(
                          fontFamily: 'Lausane650', color: draculaPurple),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
