import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MostrarPaisScreen extends StatefulWidget {
  const MostrarPaisScreen({Key? key});

  @override
  State<MostrarPaisScreen> createState() => _MostrarPaisScreenState();
}

class _MostrarPaisScreenState extends State<MostrarPaisScreen> {
  final TextEditingController _countryController = TextEditingController();
  List<dynamic> _universities = [];

  Future<void> _buscarUniversidades() async {
    final Dio dio = Dio();
    final String country = _countryController.text.trim();
    try {
      final response = await dio.get('http://universities.hipolabs.com/search?country=$country');
      setState(() {
        _universities = response.data;
      });
    } catch (e) {
      print('Error al obtener las universidades: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue, Colors.white],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 100),
                  const Text(
                    'Universidades por País',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        'https://t1.uc.ltmcdn.com/es/posts/7/1/6/cuantos_paises_hay_en_el_mundo_29617_600.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: _countryController,
                      decoration: const InputDecoration(
                        hintText: 'Ingrese el nombre del país en inglés',
                        labelText: 'País',
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                    onPressed: _buscarUniversidades,
                    child: const Text(
                      'Buscar Universidades',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 300,
                    margin: const EdgeInsets.only(bottom: 50, left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      border: Border.all(color: Colors.blue),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      itemCount: _universities.length,
                      itemBuilder: (BuildContext context, int index) {
                        final university = _universities[index];
                        return ListTile(
                          title: Text(university['name']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dominio: ${university['domains'].isEmpty ? 'No disponible' : university['domains'][0]}',
                              ),
                              Text(
                                'Sitio web: ${university['web_pages'].isEmpty ? 'No disponible' : university['web_pages'][0]}',
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
