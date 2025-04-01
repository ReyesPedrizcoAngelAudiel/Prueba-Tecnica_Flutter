import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PersonajesProvider with ChangeNotifier {
  List personajes = [];
  int paginaActual = 1;
  String? filtroGenero;
  String? filtroEstado;
  bool isLoading = false; // Loader

  Future<void> getPersonajes(int pagina) async {
    isLoading = true;
    notifyListeners(); // Notificar que está cargando

    paginaActual = pagina;
    String url = "https://rickandmortyapi.com/api/character/?page=$pagina";

    if (filtroGenero != null) url += "&gender=$filtroGenero";
    if (filtroEstado != null) url += "&status=$filtroEstado";

    final respuesta = await http.get(Uri.parse(url));
    final data = json.decode(respuesta.body);

    if (data.containsKey('results')) {
      personajes = data['results'];
    } else {
      personajes = [];
    }

    isLoading = false; // Carga terminada
    notifyListeners();
  }

  void filtrarPorGenero(String genero) {
    filtroGenero = genero;
    getPersonajes(paginaActual);
  }

  void filtrarPorEstado(String estado) {
    filtroEstado = estado;
    getPersonajes(paginaActual);
  }

  void quitarFiltros() {
    filtroGenero = null;
    filtroEstado = null;
    getPersonajes(paginaActual);
  }
}