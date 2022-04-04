# Conexión a PostgreSQL

Las aplicaciones de Analítica Integrada Salud requieren conectarse
a una base de datos PostgreSQL. IndexMic utilizará los siguientes
parámetros para autenticarse con la base de datos:

- `DATABASE_NAME`: El nombre de la base de datos;
- `DATABASE_USER`: El usuario con acceso a la base de datos;
- `DATABASE_PW`: La contraseña del usuario;
- `DATABASE_HOST`: La dirección IP de la base de datos;
- `DATABASE_PORT`: El puerto de la base de datos;

Para permitir configurar una aplicación para que se conecte a una
base de datos se haria se la siguiente manera:

```yml
proxy:
  ...
  specs:
  - id: analisis
    ...
    container-env:
      DATABASE_NAME: ais
      DATABASE_USER: ais
      DATABASE_PW: password
      DATABASE_HOST: 172.17.0.1
      DATABASE_PORT: 5432
```

**Notas**

- `DATABASE_HOST` esta definido como `172.17.0.1` porque si el servicio de
PostgreSQL corre en el host de IndexMic, los contenedores podrán
conectarse a través de esa IP. Este
[artículo](https://dockertips.com/algo_sobre_redes) explora el tema con
mayor profundidad.

## Configuración dentro de PostgreSQL

Para permitir a las aplicaciones conectarse a la base de datos se deben
configurar los accesos a la base de datos. Si la base de datos se encuentra en
un servidor remoto, se debe configurar el acceso a la máquina que corre los
contenedores.

En el archivo `pg_hba.conf` se debe agregar una linea indicando que la
dirección IP de la(s) maquina(s) puede conectarse. Ver la documentación
para la versión específica de PostgreSQL utilizada.

- [Versión 14](https://www.postgresql.org/docs/14/auth-pg-hba-conf.html)
- [Versión 13](https://www.postgresql.org/docs/13/auth-pg-hba-conf.html)
- [Versión 12](https://www.postgresql.org/docs/12/auth-pg-hba-conf.html)
- [Versión 11](https://www.postgresql.org/docs/11/auth-pg-hba-conf.html)
- [Versión 10](https://www.postgresql.org/docs/10/auth-pg-hba-conf.html)

**Notas**

- Si la base de datos corre en la misma máquina que los contenedores
se debe utilizar el siguiente rango por defecto: `172.17.0.0/16`.
Este permitirá que los contenedores se conecten a través de
la red creada por el Docker Daemon.
