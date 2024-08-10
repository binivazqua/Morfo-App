import 'package:cupertino_battery_indicator/cupertino_battery_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:morflutter/design/constants.dart';
import 'package:morflutter/display_info/databaseLink.dart';

class MySbk101 extends StatefulWidget {
  const MySbk101({super.key});

  @override
  State<MySbk101> createState() => _MySbk101State();
}

class _MySbk101State extends State<MySbk101> {
  void connectionSwitch() {
    setState(() {});
  }

  double _value = 0.5;
  bool _icon = false;

  bool connected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                // MY SBK101
                children: [
                  Text(
                    'Mi SBK-101',
                    style: TextStyle(
                        fontFamily: 'Lausane650',
                        fontSize: 20,
                        color: draculaPurple),
                  ),

                  SizedBox(height: 25),
                  //RENDER
                  Image(image: AssetImage('lib/design/renders/my_sbk101.png')),

                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      width: 250,
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: BatteryIndicator(
                            //trackHeight: 30.0,
                            value: _value,
                            icon: _icon
                                ? Icon(CupertinoIcons.question,
                                    color: draculaPurple)
                                : null,
                            iconOutline: draculaPurple,
                            iconOutlineBlur: 1.0,
                          ),
                        ),
                        Text('${(_value * 100).ceil()}%'),
                        Slider(
                          activeColor: darkPeriwinkle,
                          overlayColor: WidgetStatePropertyAll(lilyPurple),
                          value: _value,
                          min: 0.0,
                          max: 1.0,
                          onChanged: (v) => setState(() => _value = v),
                        ),
                      ]),
                    ),
                  ),

                  // SERIAL NUM
                  Container(
                    decoration: BoxDecoration(
                        color: darkPeriwinkle,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: 220,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'NO.',
                          style: TextStyle(color: morfoWhite),
                        ),
                        Text(
                          '47108DEQEJ',
                          style: TextStyle(color: morfoWhite),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  // ESTADO
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Estado:',
                        style: TextStyle(
                            fontFamily: 'Lausane650', color: draculaPurple),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Óptimo'),
                          Icon(
                            Icons.check_circle_rounded,
                            color: lilyPurple,
                          )
                        ],
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  //BATTERY STATUS

                  // CONECTIVITY STATUS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Conectividad'),
                      CupertinoSwitch(
                        value: connected,
                        activeColor: darkPeriwinkle,
                        onChanged: (bool? value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            connected = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => databaseReadTest()));
                    },
                    child: Text(
                      'Ir a mis datos',
                      style: TextStyle(color: morfoWhite),
                    ),
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(darkPeriwinkle),
                        shadowColor: WidgetStatePropertyAll(draculaPurple)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
