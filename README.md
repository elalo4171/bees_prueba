# Bees_prueba

En este proyecto consumo una rest api de libros, el proyecto trata de mostrar los primeros libros nuevas y que el usuario pueda realizar búsquedas personalizadas, para la pantalla principal usa BLOC para gestionar el estado de la pantalla, este BLOC se encuentra dentro de la carpeta 

`logic`

Todos los archivos de desarrollo se encuentran en la carpeta lib, la carpeta logic ya se definió arriba, la carpeta model tiene los modelos de la API, la carpeta page tiene las paginas que en este caso seria HOME PAGE y BOOK PAGE, la carpeta TOOLS tiene varios archivos 

El archivo api contiene todos los endpoints de la api así como el servidor.
El archivo enums contiene los enumerados usados para mantener el estado.
Http Answer es una clase para ayudar a recibir la información de la API.
Request provider es una clase que nos ayuda a hacer las peticiones sin tener que estar creando objetos de http, esta clase es un Singleton por si en algún momento se tiene que mandar un token.
La clase response es para acceder a las medidas de Media Query.
La clase Rest api contiene todas las peticiones como tal, y se encarga de convertir la respuesta de la api a los modelos.
 
 ## Cambios

Se actualizo el diseño de toda la app, y se creo una pantalla solo para la búsqueda, la búsqueda cuanta con paginación ya que al ver la documentación no se puede paginar los libros New por lo tanto solo la aplique en la búsqueda.  
Para la pantalla de la búsqueda siguiendo la arquitectura anterior se creo su Bloc para manejar el estado de la pantalla

Se cambio el diseño de la pagina donde se visualiza cada libro.