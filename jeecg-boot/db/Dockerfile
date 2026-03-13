FROM mysql:5.7

# Import PSI schema and views/functions on first container startup.
COPY psi-mysql-5.7-1.sql /docker-entrypoint-initdb.d/10-psi-mysql-5.7-1.sql
COPY psi-mysql-5.7-2.sql /docker-entrypoint-initdb.d/20-psi-mysql-5.7-2.sql
