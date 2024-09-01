import 'package:flutter/material.dart';
import 'package:morflutter/components/helpCenterTile.dart';
import 'package:morflutter/design/constants.dart';
import 'package:morflutter/starting_pages/aboutStateful.dart';
import 'package:morflutter/starting_pages/ui/about.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image(
            image: AssetImage(
              'lib/design/logos/rectangular_vino_trippypurplep.png',
            ),
            width: 120),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hola, Usuario!",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 20),
            Container(
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: lilyPurple),
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.person_2,
                      color: draculaPurple,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Username"),
                      Text(
                        "Prótesis transradial",
                        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 155,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: draculaPurple,
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Centro de ayuda",
              style: TextStyle(fontSize: 25),
            ),
            Expanded(
                child: GridView.builder(
                    itemCount: 4,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return helpCenterType(
                            service: 'Sobre Morfo',
                            icon: Icon(
                              Icons.info_rounded,
                              color: darkPeriwinkle,
                              size: 50,
                            ),
                            goTo: MaterialPageRoute(
                                builder: (context) => AboutPage()));
                      } else if (index == 1) {
                        return helpCenterType(
                          service: 'Centro de ayuda',
                          icon: Icon(
                            Icons.help_outlined,
                            color: darkPeriwinkle,
                            size: 50,
                          ),
                          goTo: MaterialPageRoute(
                              builder: (context) => AboutPage()),
                        );
                      } else if (index == 2) {
                        return helpCenterType(
                          service: 'Mis Productos',
                          icon: Icon(
                            Icons.production_quantity_limits_rounded,
                            color: darkPeriwinkle,
                            size: 50,
                          ),
                          goTo: MaterialPageRoute(
                              builder: (context) => AboutPage()),
                        );
                      } else {
                        return helpCenterType(
                          service: 'Especialistas',
                          icon: Icon(
                            Icons.healing_rounded,
                            color: darkPeriwinkle,
                            size: 50,
                          ),
                          goTo: MaterialPageRoute(
                              builder: (context) => AboutPage()),
                        );
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
