# Analítica Integrada Salud

IndexMic es la plataforma ideal para hostear las aplicaciones de Analítica
Integrada Salud. Los logos para la mayoría de las aplicaciones vienen
pre-instalados en el repositorio; si un logo no se encuentra disponible
puede ser que la aplicación aun este en estado de pruebas o que sea
necesario actualizar IndexMic.

## Agregar una aplicación

Las aplicaciones disponibles en este momento son:

- `Análisis`: Aplicación para análisis y exploración de datos.
- `Agrupador`: Aplicación para el manejo de agrupadores.
- `Tarifas`: Aplicación para el manejo de tarifas.
- `Rutas`: Aplicación para la administración y análisis de rutas.
- `Notas técnicas`: Aplicación para la creación y seguimiento de notas técnicas.
- `ComBD`: Aplicación para la manipulación y cargue de datos.

Todas las aplicaciones se ingresan debajo de `specs` y siguen una configuración
base con los siguientes parámetros:

- `id`: El id único de la aplicación;
- `logo-url`: El nombre del archivo del logo (`/etc/indexmic/templates/2col/assets/img/`);
- `display-name`: El título de la aplicación en IndexMic;
- `description`: La descripción de la aplicación en IndexMic;
- `container-img`: Nombre de la imágen utilizada para iniciar el contenedor;
- `container-cmd`: El comando que se utiliza dentro del contenedor para iniciar la aplicación;
    - Los comandos llevan la siguiente estructura: `["ruta ejecutable", "flags", "argumentos"]`;
    - Ej. `["echo", "Hola Mundo"]`;
- `container-env`: Variables de ambiente a pasar al contenedor;

## Descargar imágenes

Las imágenes con el contenido de las aplicaciones de Analítica Integrada Salud se pueden
descargar desde Docker Hub. _Estos pasos aun estan por definirse_.

## Variables de ambiente

Todas las aplicaciones de Analítica Integrada Salud deben tener las siguiente variables
de ambiente bajo `container-env` para poder funcionar correctamente:

- `LICENSE_KEY`: Llave de acceso a la licencia;
- `DATABASE_NAME`: El nombre de la base de datos;
- `DATABASE_USER`: El usuario con acceso a la base de datos;
- `DATABASE_PW`: La contraseña del usuario;
- `DATABASE_HOST`: La dirección IP de la base de datos;
- `DATABASE_PORT`: El puerto de la base de datos;
- `TECNOLOGIAS_COL_COD`: El nombre de la variable con el código único de las tecnologías en la tabla `tecnologias_catalogo`;

**Notas**

- Para más detalles sobre las variables relacionadas a la base de datos revisar [Conexión a PostgreSQL](../conexion).
