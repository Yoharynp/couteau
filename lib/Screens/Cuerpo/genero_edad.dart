import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GeneroEdadScreen extends StatefulWidget {
  const GeneroEdadScreen({Key? key});

  @override
  State<GeneroEdadScreen> createState() => _GeneroEdadScreenState();
}

class _GeneroEdadScreenState extends State<GeneroEdadScreen> {
  final TextEditingController _nombreController = TextEditingController();
  String _edad = '';
  String _mensaje = '';
  String _imagen = '';

  Future<void> _obtenerEdad() async {
    final Dio dio = Dio();
    final String nombre = _nombreController.text;
    try {
      final response = await dio.get('https://api.agify.io/?name=$nombre');
      final Map<String, dynamic> data = response.data;
      final int edad = data["age"];
      setState(() {
        _edad = edad.toString();
        if (edad < 30) {
          _mensaje = 'Es joven';
          _imagen = 'https://thumbs.dreamstime.com/b/retrato-del-hombre-hermoso-joven-adolescente-aislado-en-el-estudio-w-90271158.jpg';
        } else if (edad >= 30 && edad < 60) {
          _mensaje = 'Es adulto';
          _imagen = 'https://img.freepik.com/fotos-premium/hombre-adulto-joven-guapo-sonriendo-ampliamente-mirando-feliz-positivo-seguro-exitoso-ambos-pulgares-arriba_1194-215353.jpg';
        } else {
          _mensaje = 'Es anciano';
          _imagen = 'https://i.pinimg.com/originals/ae/e4/6c/aee46c184f371c358ec343ca7b65d6a8.jpg';
        }
      });
    } catch (e) {
      print('Error al obtener la edad: $e');
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    super.dispose();
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
            Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 300, height: 300, child: Image.network('https://cdn-icons-png.freepik.com/512/3787/3787829.png', fit: BoxFit.cover,)),
              Text('Obtener Edad', style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )),
              Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    hintText: 'Ingrese un nombre',
                    labelText: 'Nombre',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: _obtenerEdad, 
                child: const Text('Obtener Edad', style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ))),
              const SizedBox(height: 20),
              _edad.isNotEmpty
                  ? Column(
                      children: [
                        Text('Edad: $_edad'),
                        Text(_mensaje),
                        const SizedBox(height: 20),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            _imagen,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ]),
      ),
    );
  }
}
