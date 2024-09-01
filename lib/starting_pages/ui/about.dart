import 'package:flutter/material.dart';
import 'package:morflutter/design/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPageStateless extends StatelessWidget {
  const AboutPageStateless({super.key});

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
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                    style: ButtonStyle(
                        maximumSize: WidgetStatePropertyAll(Size(200, 100))),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [Icon(Icons.web), Text('Conoce más')],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchInWebView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }
}
