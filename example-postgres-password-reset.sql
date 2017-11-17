ALTER USER postgres PASSWORD 'your-password' ;
drop database if exists example_db_name ;
CREATE DATABASE example_db_name ;
DO
$body$
BEGIN
   IF NOT EXISTS (
      SELECT *
      FROM   pg_catalog.pg_user
      WHERE  usename = 'your_username') THEN

      CREATE ROLE your_username LOGIN PASSWORD 'your-password';
      CREATE USER your_username WITH PASSWORD 'your-password' ;
   END IF;
END
$body$;
ALTER ROLE your_username SET client_encoding TO 'utf8' ;
ALTER ROLE your_username SET default_transaction_isolation TO 'read committed' ;
ALTER ROLE your_username SET timezone TO 'UTC' ;
GRANT ALL PRIVILEGES ON DATABASE testing_db TO your_username ;
ALTER USER your_username CREATEDB;
drop database if exists testing_db ;
create database testing_db ;
grant all privileges on database testing_db to your_username ;
