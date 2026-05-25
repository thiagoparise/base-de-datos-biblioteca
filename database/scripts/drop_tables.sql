-- =========================================
-- DROP DE TABLAS
-- =========================================
-- Orden importante:
-- Primero tablas relacionales/dependientes
-- Luego tablas principales
-- =========================================

PRINT '=========================================';
PRINT 'ELIMINANDO TABLAS';
PRINT '=========================================';


-- =========================================
-- TABLAS RELACIONALES
-- =========================================

DROP TABLE IF EXISTS EjemplarPrestamo;
DROP TABLE IF EXISTS Recomendado;
DROP TABLE IF EXISTS DocenteMateria;
DROP TABLE IF EXISTS LibroMateria;
DROP TABLE IF EXISTS EdicionPalabra;
DROP TABLE IF EXISTS EdicionTema;
DROP TABLE IF EXISTS Autor_Libro;


-- =========================================
-- ESPECIALIZACIONES
-- =========================================

DROP TABLE IF EXISTS LectorGraduado;
DROP TABLE IF EXISTS LectorAlumno;
DROP TABLE IF EXISTS LectorDocente;


-- =========================================
-- TABLAS DEPENDIENTES
-- =========================================

DROP TABLE IF EXISTS Consulta;
DROP TABLE IF EXISTS Prestamo;
DROP TABLE IF EXISTS Ejemplar;
DROP TABLE IF EXISTS Edicion;
DROP TABLE IF EXISTS Libro;


-- =========================================
-- TABLAS PRINCIPALES
-- =========================================

DROP TABLE IF EXISTS Lector;
DROP TABLE IF EXISTS Materia;
DROP TABLE IF EXISTS Estado;
DROP TABLE IF EXISTS PalabraClave;
DROP TABLE IF EXISTS Tema;
DROP TABLE IF EXISTS Estanteria;
DROP TABLE IF EXISTS Autor;
DROP TABLE IF EXISTS Idioma;
DROP TABLE IF EXISTS Editorial;


PRINT '=========================================';
PRINT 'TABLAS ELIMINADAS';
PRINT '=========================================';