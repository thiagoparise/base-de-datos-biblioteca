USE master;
GO

IF DB_ID('biblioteca') IS NOT NULL
BEGIN
    DROP DATABASE biblioteca;
END
GO

CREATE DATABASE biblioteca;
GO

USE biblioteca;
GO