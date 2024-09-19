# Utiliza la imagen oficial de PostgreSQL desde Docker Hub
FROM postgres:15.3-alpine

# Variables de entorno para la base de datos
ENV POSTGRES_DB pizza
ENV POSTGRES_USER myuser
ENV POSTGRES_PASSWORD platzi

# Copia el archivo init.sql al contenedor Docker
COPY ./init.sql /docker-entrypoint-initdb.d/

CMD [ "postgres" ]