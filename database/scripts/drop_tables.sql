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

DROP TABLE IF EXISTS SeIncluyeEn;
DROP TABLE IF EXISTS Recomendado;
DROP TABLE IF EXISTS Dicta;
DROP TABLE IF EXISTS EsBibliografiaDe;
DROP TABLE IF EXISTS SeDescribePor;
DROP TABLE IF EXISTS TrataSobre;
DROP TABLE IF EXISTS Escribe;


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
