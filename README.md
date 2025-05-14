# Proyecto de Búsqueda de Información de Citas Médicas

Este proyecto es una aplicación web que permite buscar información detallada sobre citas médicas almacenadas en una base de datos. La aplicación utiliza PHP para la lógica del servidor, JavaScript (jQuery) para la interacción en el cliente, y una base de datos PostgreSQL para almacenar los datos.

## Características

- **Búsqueda por ID de Cotización**: Permite al usuario buscar información de una cita médica ingresando el ID de la cotización.
- **Consulta Segura**: Utiliza consultas preparadas con PDO para prevenir inyecciones SQL.
- **Interfaz de Usuario Amigable**: Incluye notificaciones visuales para informar al usuario sobre el estado de la búsqueda (éxito, advertencia o error).
- **Resultados Detallados**: Muestra información como:
  - Nombre y apellido del paciente.
  - Identificación del paciente.
  - Nombre y apellido del profesional médico.
  - Fecha y hora de la cita.

### Estructura del Proyecto


1. **`index.html`**: Página principal con el formulario de búsqueda.
2. **`controller.php`**: Archivo PHP que procesa la solicitud, realiza la consulta a la base de datos y devuelve los resultados.
3. **`scripts.js`**: Archivo JavaScript que maneja la interacción del usuario con el formulario y realiza solicitudes AJAX al servidor.
4. **`db.php`**: Archivo de configuración para la conexión a la base de datos PostgreSQL.

### Dependencias

- [jQuery](https://jquery.com/) para la interacción en el cliente.
- [Notiflix](https://notiflix.github.io/) para notificaciones visuales.
