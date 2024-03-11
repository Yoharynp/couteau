import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class AcercaDeScreen extends StatelessWidget {
  const AcercaDeScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Text('Acerca de', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(50),
                    image: const DecorationImage(
                      image: AssetImage('assets/yo.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Text('Yohary Nuñez', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Text('Desarrollador de Software Mobile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Text('829-658-8577', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 480,
                  child: SfPdfViewer.asset('assets/curriculum.pdf'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}