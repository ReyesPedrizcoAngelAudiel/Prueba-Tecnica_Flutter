import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_carvel/providers/personajes.dart';

class PersonajeStatus extends StatelessWidget {
  final List<String> estados = ["alive", "dead", "unknown"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:
            estados.map((estado) {
              return ListTile(
                title: Text(estado.toUpperCase()),
                onTap: () {
                  Provider.of<PersonajesProvider>(
                    context,
                    listen: false,
                  ).filtrarPorEstado(estado);
                  Navigator.pop(context);
                },
              );
            }).toList(),
      ),
    );
  }
}
