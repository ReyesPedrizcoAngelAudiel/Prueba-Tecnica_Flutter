import 'package:flutter/material.dart';                 //Material Design Library
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';                //Para manejar el estado de la app
import 'package:app_carvel/providers/personajes.dart';  //Para manejar los personajes
import 'package:app_carvel/screens/home_screen.dart';   //Pagina de inicio donde se muestran 20 personajes iniciales

//Funcion principal que sin llamarla se ejecuta siempre
void main() {
  runApp(
    //Widget principal
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PersonajesProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //Ventana de Inicio
        home: HomePage(),
      ),
    ),
  ); //Ejecutamos la app
}