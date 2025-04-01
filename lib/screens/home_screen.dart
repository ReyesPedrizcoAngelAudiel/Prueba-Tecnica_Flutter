// Home_Screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'inform_screen.dart';

import 'package:app_carvel/providers/personajes.dart';
import 'package:app_carvel/providers/personajes_genero.dart';
import 'package:app_carvel/providers/personajes_estado.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaActual = 1;
  final TextEditingController _pageController = TextEditingController();

  // ! Inicio de la app
  @override
  void initState() {
    super.initState();
    _cargarPersonajes();
  }

  // ! Metodo para cargar los personajes de la API
  void _cargarPersonajes() {
    Provider.of<PersonajesProvider>(
      context,
      listen: false,
    ).getPersonajes(paginaActual);
  }

  // ! Metodo para cambiar de pagina
  void _cambiarPagina(int nuevaPagina) {
    if (nuevaPagina < 1 || nuevaPagina > 42) {
      _mostrarMensaje("Ingrese un número entre 1 y 42");
      return;
    }
    setState(() {
      paginaActual = nuevaPagina;
      _pageController.text = nuevaPagina.toString();
    });
    _cargarPersonajes();
  }

  // ! Metodo para mostrar el mensaje de error entre pantallas (1 - 42)
  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje), backgroundColor: Colors.red),
    );
  }

  // ! Filtro de Genero
  void _mostrarFiltroGenero() {
    showModalBottomSheet(
      context: context,
      builder: (context) => PersonajeGenero(),
    );
  }

  // ! Filtro de Estado
  void _mostrarFiltroEstado() {
    showModalBottomSheet(
      context: context,
      builder: (context) => PersonajeStatus(),
    );
  }

  // ! Pantalla principal
  @override
  Widget build(BuildContext context) {
    final personajesProvider = Provider.of<PersonajesProvider>(context);
    final personajes = personajesProvider.personajes;

    return Scaffold(
      backgroundColor: Colors.black,                  // ? Fondo negro
      appBar: _buildAppBar(),                           // ? Barra de navegación superior
      body: _buildBody(personajes),                     // ? Cuerpo
      bottomNavigationBar: _buildBottomNavigationBar(), // ? Barra de navegación inferior
    );
  }

  // ! Barra de navegación superior
  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        "Personajes - Rick & Morty",
        style: TextStyle(color: Colors.tealAccent, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.tealAccent),
      actions: [_buildPopupMenu(), _buildPageInput()],
    );
  }

  // ! Menu desplegable
  Widget _buildPopupMenu() {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert, color: Colors.tealAccent),
      itemBuilder:
          (context) => [
            PopupMenuItem(
              child: Text("Filtrar por Género"),
              onTap: _mostrarFiltroGenero,
            ),
            PopupMenuItem(
              child: Text("Filtrar por Estado"),
              onTap: _mostrarFiltroEstado,
            ),
            PopupMenuItem(
              child: Text("Limpiar Filtros"),
              onTap: () {
                Provider.of<PersonajesProvider>(
                  context,
                  listen: false,
                ).quitarFiltros();
              },
            ),
          ],
    );
  }

  // ! Campo de entrada de la página (Número de pagina)
  Widget _buildPageInput() {
    return SizedBox(
      width: 40,
      child: TextField(
        controller: _pageController,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Pg",
          hintStyle: TextStyle(color: Colors.white54),
          border: InputBorder.none,
        ),
        onSubmitted: (value) {
          final int? nuevaPagina = int.tryParse(value);
          if (nuevaPagina != null) _cambiarPagina(nuevaPagina);
        },
      ),
    );
  }

  // ! Cuerpo Responsivo
  Widget _buildBody(List personajes) {
    if (personajes.isEmpty) return Center(child: CircularProgressIndicator());

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 1; // Por defecto | Celulares

        if (constraints.maxWidth > 600) {
          crossAxisCount = 2;   // Tablets
        }
        if (constraints.maxWidth > 900) {
          crossAxisCount = 4;   // Escritorios
        }

        return Stack(
          children: [
            Positioned.fill(
              child: Container(color: Colors.black),
            ),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2 / 1,
              ),
              itemCount: personajes.length,
              itemBuilder: (BuildContext context, int index) {
                final personaje = personajes[index];
                return _buildPersonajeCard(personaje);
              },
            ),
          ],
        );
      },
    );
  }

  // ! Tarjeta de personaje
  Widget _buildPersonajeCard(Map personaje) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder:
                (context, animation, secondaryAnimation) =>
                    InformScreen(personajeId: personaje['id']),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween = Tween(
                begin: begin,
                end: end,
              ).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(position: offsetAnimation, child: child);
            },
          ),
        );
      },
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.teal.shade600,
                spreadRadius: 2,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(personaje['image']),
                  radius: 80.0,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        personaje['name'],
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Click aquí para ver detalles",
                        style: TextStyle(fontSize: 14.0, color: Colors.white60),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ! Barra de navegación inferior
  Widget _buildBottomNavigationBar() {
    return Container(
      padding: EdgeInsets.all(7.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (paginaActual > 1)
            TextButton(
              onPressed: () => _cambiarPagina(paginaActual - 1),
              child: Text(
                "Anterior",
                style: TextStyle(color: Colors.tealAccent),
              ),
            ),
          Text(
            "Página $paginaActual",
            style: TextStyle(color: Colors.tealAccent),
          ),
          if (paginaActual < 42)
            TextButton(
              onPressed: () => _cambiarPagina(paginaActual + 1),
              child: Text(
                "Siguiente",
                style: TextStyle(color: Colors.tealAccent),
              ),
            ),
        ],
      ),
    );
  }
}
