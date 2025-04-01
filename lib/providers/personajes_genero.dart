import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_carvel/providers/personajes.dart';

class PersonajeGenero extends StatelessWidget {
  final List<String> generos = ["male", "female", "genderless", "unknown"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:
            generos.map((genero) {
              return ListTile(
                title: Text(genero.toUpperCase()),
                onTap: () {
                  Provider.of<PersonajesProvider>(
                    context,
                    listen: false,
                  ).filtrarPorGenero(genero);
                  Navigator.pop(context);
                },
              );
            }).toList(),
      ),
    );
  }
}
