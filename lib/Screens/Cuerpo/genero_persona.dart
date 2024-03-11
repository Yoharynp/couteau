import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GeneroPersonaScreen extends StatefulWidget {
  const GeneroPersonaScreen({Key? key});

  @override
  State<GeneroPersonaScreen> createState() => _GeneroPersonaScreenState();
}

class _GeneroPersonaScreenState extends State<GeneroPersonaScreen> {
  final TextEditingController _nombreController = TextEditingController();
  String _genero = '';

  Future<void> _obtenerGenero() async {
    final Dio dio = Dio();
    final String nombre = _nombreController.text;
    try {
      final response = await dio.get('https://api.genderize.io/?name=$nombre');
      final Map<String, dynamic> data = response.data;
      final String genero = data["gender"];
      setState(() {
        _genero = genero;
      });
    } catch (e) {
      throw Exception('Error al obtener el género');
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
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: const DecorationImage(
                    image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/Aiga_toilets_inv.svg/1200px-Aiga_toilets_inv.svg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 20),
                width: 300,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Text('Predice el genero', textAlign: TextAlign.center, style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    hintText: 'Ingrese un nombre',
                    labelText: 'Nombre',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20),
                      )
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
                ),
                onPressed: _obtenerGenero, 
                child: const Text('Obtener genero', style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),),
              const SizedBox(height: 20),
              _genero.isNotEmpty
                  ? Container(
                      width: 200,
                      height: 100,
                      child: Text(
                        textAlign: TextAlign.center,
                        _genero == 'male' ? 'Es Hombre' : 'Es Mujer',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    )
                  : const SizedBox(),
            ],
          ),
        ]),
      ),
    );
  }
}
