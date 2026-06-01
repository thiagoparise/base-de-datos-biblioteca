USE master;
GO

IF DB_ID('biblioteca') IS NOT NULL
BEGIN
    -- Cierra conexiones abiertas para evitar error al hacer drop
    ALTER DATABASE biblioteca SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE biblioteca;
END
GO

CREATE DATABASE biblioteca;
GO

USE biblioteca;
GO