import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InformScreen extends StatefulWidget {
  final int personajeId;

  const InformScreen({Key? key, required this.personajeId}) : super(key: key);

  @override
  _InformScreenState createState() => _InformScreenState();
}

class _InformScreenState extends State<InformScreen> {
  Map<String, dynamic>? personaje;
  List<String> episodios = [];

  @override
  void initState() {
    super.initState();
    getPersonaje();
  }

  Future<void> getPersonaje() async {
    final response = await http.get(
      Uri.parse(
        "https://rickandmortyapi.com/api/character/${widget.personajeId}",
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        personaje = json.decode(response.body);
        episodios = personaje!["episode"].cast<String>();
      });
    } else {
      throw Exception("Error al obtener el personaje");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.tealAccent),
        backgroundColor: Colors.black,
      ),
      body:
          personaje == null
              ? Center(
                child: CircularProgressIndicator(color: Colors.tealAccent),
              )
              : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        personaje!["name"],
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.tealAccent,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        // ! Sombra de la imagen
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.tealAccent.shade400,
                              blurRadius: 10,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        // ! Imagen del personaje
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(personaje!["image"]),
                        ),
                      ),
                      SizedBox(height: 14),
                      // ! Informacion del personaje
                      _buildInfoRow(
                        FontAwesomeIcons.dna,
                        "Especie",
                        personaje!["species"],
                      ),
                      _buildInfoRow(
                        FontAwesomeIcons.heartPulse,
                        "Estado",
                        personaje!["status"],
                      ),
                      _buildInfoRow(
                        FontAwesomeIcons.venusMars,
                        "Género",
                        personaje!["gender"],
                      ),
                      _buildInfoRow(
                        FontAwesomeIcons.globe,
                        "Origen",
                        personaje!["origin"]["name"],
                      ),
                      SizedBox(height: 20),
                      // ! Episodios
                      Text(
                        "Episodios en los que aparece:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: episodios.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.tealAccent,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    "Episodio ${index + 1}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, color: Colors.tealAccent, size: 20),
          SizedBox(width: 10),
          Text(
            "$label: ",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 18, color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
