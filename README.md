# 📱 App Flutter - Rick & Morty.
#### 💻 Proyecto en Flutter con: Dart, Provider y API publica.
> Este proyecto está desarrollado utilizando Flutter con Dart como lenguaje principal, aprovechando el Provider para gestionar el estado de la aplicación. Se conecta a una API pública para la obtención de datos y funcionalidades clave, brindando una experiencia de usuario fluida y dinámica.
#### 📝 Desiciones tecnicas relevantes.
>## 📚 Estructura del proyecto.
>### Screens | Pantallas
>- #### screens/home_screen.dart
>- Pagina principal e inicio, donde se visualizan todos los personajes.
>- #### screens/inform_screen.dart
>- Pagina de la información detallada de X personaje

>### Providers | Manejo de estados
>- #### providers/personajes.dart
>- Utilizado para obtener los datos de los personajes de la API en general, segmentado por paginas, genero, estado
>- #### providers/personajes_genero.dart
>- Utilizado para manejar el estado de la barra de navegación acorde a los distintos generos: male, female, genderless, unknown
>- #### providers/personajes_estado.dart
>- Utilizado para manejar el estado de la barra de navegación acorde a los distintos estados: alive, dead, unknown
>## 📍 Paginas.
>- Pensaba utilizar un archivo dart por cada pagina (42 en total) para la visualizacion de personajes, pero en su lugar decidi utilizar un metodo para llevar el control de las paginas
> ![](/Cosas_Readme/paginas.jpg)

>## 🚀 Características Principales
>- 📌 Listado de personages en HomePage o Pagina principal.
>- 🗃️ API obtenida de una consulta GET: https://rickandmortyapi.com/api.
>- 🎨 Interfaz moderna y responsiva.
>- ⚡ Puedes ver la informacion adicional de cada personaje.
>## ⚒️ Características Adicionales
>- 🪄 Filtrado de personajes por Genero y Estado
>- 📋 Vizualisacion de personajes por paginas.

# 💡 Instalación
---
> ### Necesitas tener Flutter instalado
> #### Documentacion de Flutter:
> [📄 Ver la instalación de Flutter y sus complementos](https://docs.flutter.dev/get-started/install/windows/mobile)
> #### En caso de error como este:
> ![](/Cosas_Readme/error.jpg)
>- Dirigete a Android Studio y abre el SDK manager
>- ![](/Cosas_Readme/android_studio.jpg)
>- Da click en SDK Tools 
>- ![](/Cosas_Readme/sdk_tools.jpg)
>- Selecciona la opcion Android SDK Command-line Tools
>- ![](/Cosas_Readme/comand_line.jpg)
>- Una vez termine la instalación, aplica los cambios y cierras el Android Studio
>- ![](/Cosas_Readme/aplicar.jpg)
>- Vuelve a tu linea de comandos y vuelve a ejecutar el comando
>- ![](/Cosas_Readme/resultado.jpg)
> #### Configurar Visual Estudio Code
>- Instala la extension de Android iOS Emulator
>- ![](/Cosas_Readme/extension.jpg)
>- En el icono de configuración, selecciona la siguiente opcion
>- ![](/Cosas_Readme/selecciona.jpg)
>- Busca tus emuladores en la carpeta de "C:\Users\[Nombre]\AppData\Local\Android\Sdk\emulator"
>- ![](/Cosas_Readme/ejemplo.jpg)
>- Colocalo tanto en Emulator Path, como en el Emulator de tu preferencia, en este caso Windows
>- ![](/Cosas_Readme/emulador_path.jpg)
>- #### ¿Cómo saber si ya se ha instalado todo lo necesario?:
> Cuando desde la linea de comandos ejecutas: "flutter doctor" y aparece asi:
>- ![](/Cosas_Readme/resultado_final.jpg)
>#### 🎉 Entonces la instalacion ha sido exitosa 🎉

# 🤔 ¿Cómo ejecutar la App?
---
#### En visual studio code ejecutar: Ctrl + Shift + P
>- Da enter en "Emulador" y despues en "View Android emulators"
>- ![](/Cosas_Readme/ejectuar.jpg)
>- Selecciona el emulador que prefieras
>- ![](/Cosas_Readme/ejectuar2.jpg)
>- Cargado el emulador de tu preferencia solo da click en el boton "Ejecución y depuración"
>- ![](/Cosas_Readme/ejectuar3.jpg)
### 🎉 Listo, hemos cargado el programa 🎉
>- ![](/Cosas_Readme/ejectuar_final.jpg)

# 🎥 Video de funcionamiento
---
> [🎦 Ver en youtube el proyecto]([https://docs.flutter.dev/get-started/install/windows/mobile](https://youtu.be/Oewj2wgLxS4))

---
###### 🌟 ¡Gracias por revisar este proyecto! 
###### Si tienes sugerencias o mejoras, no dudes en contribuir. 🦊
