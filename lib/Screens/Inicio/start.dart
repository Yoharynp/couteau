import 'package:couteau/Screens/Inicio/screen_home.dart';
import 'package:flutter/material.dart';
import 'package:sweep_animation_button/sweep_animation_button.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/herramientas.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Couteau',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          SweepAnimationButton(
              width: 250,
              height: 50,
              animationProgressColor: Colors.green[800],
              borderRadius: 50,
              animationColor: Colors.lightGreen,
              backroundColor: Colors.lightGreen[200],
              durationCircle: 1,
              hideIcon: true,
              child: Text(
                "Sweeped Button",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.green[600],
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    shape: const CircleBorder(),
                    elevation: 0.4,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.lightGreen[300],
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.done,
                          size: 24,
                          color: Colors.lightGreen[700],
                        ),
                      ),
                    ),
                  ),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScreenHomeScreen()),
                );
              },
            ),
        ],
      ),
    ));
  }
}
