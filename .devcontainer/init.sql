DROP DATABASE IF EXISTS "GamesDB";
CREATE DATABASE "GamesDB";

\c GamesDB;

DROP TYPE IF EXISTS session_status;
CREATE TYPE session_status AS ENUM ('incomplete', 'complete');

DROP TABLE IF EXISTS Games;
CREATE TABLE table_name (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    
);