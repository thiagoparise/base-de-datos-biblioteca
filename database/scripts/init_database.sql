USE master;
GO

-- Spanish como default language del login sa: garantiza por ejemplo los nombres de los meses esten en Español
ALTER LOGIN sa WITH DEFAULT_LANGUAGE = Spanish;
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