import 'package:flutter/material.dart';
import 'package:morflutter/design/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  Future<void>? _launched;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _launchInWebView(Uri url, {required String path}) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'lib/design/logos/rectangular_vino_violette-removebg-preview-2.png',
                  width: 200,
                ),
              ),
              Text(
                '¿Quiénes somos?',
                style: TextStyle(
                    fontSize: 20,
                    color: draculaPurple,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Somos una empresa mexicana de prótesis biónicas que promueve la accesibilidad, diversidad e innovación a través de sus productos.',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.asset('lib/design/pics/doc1.jpeg'),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Nuestra misión',
                style: TextStyle(
                    fontSize: 20,
                    color: draculaPurple,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  'Empoderamos a las personas con amputaciones en su proceso de recuperación y búsqueda de independencia, desafiando el estereotipo que implica carecer de una extremidad.'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.asset('lib/design/pics/docasses.jpeg'),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Nuestra visión',
                style: TextStyle(
                    fontSize: 20,
                    color: draculaPurple,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  'Nos enfocamos no solo en proporcionar prótesis de alta calidad, sino también en ofrecer un soporte integral que incluye educación, rehabilitación y seguimiento continuo.'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.asset(
                  'lib/design/pics/developer.jpg',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(darkPeriwinkle),
                            maximumSize: WidgetStatePropertyAll(Size(170, 50))),
                        onPressed: () => setState(() {
                              _launched = _launchInBrowser(Uri(
                                  path:
                                      'https://pub.dev/packages/url_launcher/example'));
                            }),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.wb_iridescent_rounded,
                              color: lilyPurple,
                            ),
                            Text(
                              'Conocer más',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
