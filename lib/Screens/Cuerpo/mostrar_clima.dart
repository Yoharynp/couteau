import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MostrarClimaScreen extends StatefulWidget {
  const MostrarClimaScreen({super.key});

  @override
  State<MostrarClimaScreen> createState() => _MostrarClimaScreenState();
}

class _MostrarClimaScreenState extends State<MostrarClimaScreen> {
  String _clima = '';
  String _iconUrl = '';
  String _nombreCiudad = '';

  @override
  void initState() {
    super.initState();
    _obtenerClima();
  }

  Future<void> _obtenerClima() async {
    const String apiKey = 'd0a0243aa9c4f0dddb5a38ded409cd1e';
    const String cityId = '3508796'; // ID de República Dominicana
    const String apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?id=$cityId&appid=$apiKey&units=metric';

    try {
      final dio = Dio();
      final response = await dio.get(apiUrl);

      if (response.statusCode == 200) {
        // La solicitud fue exitosa
        final jsonData = response.data;
        setState(() {
          final tempActual = jsonData['main']['temp'];
          final tempMin = jsonData['main']['temp_min'];
          final tempMax = jsonData['main']['temp_max'];
          final presion = jsonData['main']['pressure'];
          final humidity = jsonData['main']['humidity'];
          final icon = jsonData['weather'][0]['icon'];
          final nombreCiudad = jsonData['name'];
          _clima =
              'Temperatura Actual: $tempActual°C\nTemperatura Mínima: $tempMin°C\nTemperatura Máxima: $tempMax°C\nPresión: $presion hPa\nHumedad: $humidity%';
          _iconUrl = 'https://openweathermap.org/img/wn/$icon@2x.png';
          _nombreCiudad = nombreCiudad;
        });
      } else {
        // La solicitud falló
        setState(() {
          _clima = 'Error al obtener el clima: ${response.statusCode}';
        });
      }
    } catch (e) {
      // Ocurrió un error durante la solicitud
      setState(() {
        _clima = 'Error al obtener el clima: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
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
            Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _iconUrl.isNotEmpty
                  ? Image.network(
                      _iconUrl,
                      width: 100,
                      height: 100,
                    )
                  : const CircularProgressIndicator(),
              const SizedBox(height: 20),
              _clima.isNotEmpty
                  ? Text(
                      _clima,
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    )
                  : const CircularProgressIndicator(),
            ],
          ),
        ]),
      ),
    );
  }
}
