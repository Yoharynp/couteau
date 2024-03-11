

import 'package:flutter/material.dart';

  int selectedIndex = 0; // Índice del elemento seleccionado

  // Lista de elementos
  List<Widget> elementos = [
    _buildElemento(0, const Icon(Icons.person), 'Genero Persona'),
    _buildElemento(1, const Icon(Icons.numbers), 'Genero Edad'),
    _buildElemento(2, const Icon(Icons.location_city), 'Mostar pais'),
    _buildElemento(3, const Icon(Icons.sunny), 'Mostrar Clima'),
    _buildElemento(4, const Icon(Icons.public), 'Pagina Logo'),
    _buildElemento(5, const Icon(Icons.person_search_rounded), 'Acerca De'),
  ];

  // Método para construir un elemento de la lista
  Widget _buildElemento(int index, Icon iconlist, String texto) {
    return ListTile(
      leading: iconlist,
      title: Text(texto),
      textColor: Colors.white,
      iconColor: Colors.white,
    );
  }