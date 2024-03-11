import 'dart:math';

import 'package:couteau/Screens/Cuerpo/acerca_de.dart';
import 'package:couteau/Screens/Cuerpo/genero_edad.dart';
import 'package:couteau/Screens/Cuerpo/genero_persona.dart';
import 'package:couteau/Screens/Cuerpo/mostrar_clima.dart';
import 'package:couteau/Screens/Cuerpo/mostrar_pais.dart';
import 'package:couteau/Screens/Cuerpo/pagina_logo.dart';
import 'package:couteau/Screens/Inicio/menu_provider.dart';
import 'package:couteau/Widgets/menu_button.dart';
import 'package:couteau/Widgets/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ScreenHomeScreen extends StatefulWidget {
  const ScreenHomeScreen({super.key});

  @override
  State<ScreenHomeScreen> createState() => _ScreenHomeScreenState();
}

class _ScreenHomeScreenState extends State<ScreenHomeScreen>
    with SingleTickerProviderStateMixin {
  bool isMenuOpen = true;
  late AnimationController _controller = _controller;
  late Animation<double> _scaleAnimation = _scaleAnimation;
  late Animation<double> _scaleAnimationTwo = _scaleAnimationTwo;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        setState(() {});
      });
    _scaleAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _scaleAnimationTwo = Tween<double>(begin: 1, end: 0.8)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> screens = <Widget>[
    const GeneroPersonaScreen(),
    const GeneroEdadScreen(),
    const MostrarPaisScreen(),
    const MostrarClimaScreen(),
    const PaginaLogoScreen(),
    const AcercaDeScreen(),
  ];

  int currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Stack(
        children: [
        AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: 288,
            left: isMenuOpen ? -288 : 0,
            height: MediaQuery.of(context).size.height,
            child: const SideMenuScreen()),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(
                _scaleAnimation.value - 30 * _scaleAnimation.value * pi / 180),
          child: Transform.translate(
              offset: Offset(_scaleAnimation.value * 265, 0),
              child: Transform.scale(
                  scale: _scaleAnimationTwo.value * 1.05,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: screens[Provider.of<MenuIndexProvider>(context)
                          .selectedIndex]))),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          left: isMenuOpen ? 0 : 220,
          top: isMenuOpen ? 0  : 50,
          child: MenuButtom(
            controller: _controller,
            onMenuPressed: () {
              setState(() {
                if (isMenuOpen) {
                  _controller.forward();
                  isMenuOpen = !isMenuOpen;
                } else {
                  _controller.reverse();
                  isMenuOpen = !isMenuOpen;
                }
              });
            },
          ),
        ),
      ]),
    );
  }
}
