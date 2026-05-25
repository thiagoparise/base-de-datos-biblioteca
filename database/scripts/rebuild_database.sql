-- =========================================
-- Rebuild completo de la base de datos
-- =========================================
-- Requiere:
-- Query > SQLCMD Mode habilitado en SSMS
-- =========================================

PRINT '=========================================';
PRINT 'INICIANDO REBUILD DE BASE DE DATOS';
PRINT '=========================================';


-- =========================================
-- DROP TABLES
-- =========================================

PRINT 'Dropping tables...';

:r drop_tables.sql


-- =========================================
-- TABLAS PRINCIPALES
-- =========================================

PRINT 'Creando tablas principales...';

:r ../tables/entities/editorial.sql
:r ../tables/entities/idioma.sql
:r ../tables/entities/autor.sql
:r ../tables/entities/estanteria.sql
:r ../tables/entities/tema.sql
:r ../tables/entities/palabra_clave.sql
:r ../tables/entities/estado.sql
:r ../tables/entities/materia.sql
:r ../tables/entities/lector.sql

-- =========================================
-- ESPECIALIZACIONES
-- =========================================

PRINT 'Creando especializaciones de lector...';

:r ../tables/entities/lector_docente.sql
:r ../tables/entities/lector_alumno.sql
:r ../tables/entities/lector_graduado.sql


-- =========================================
-- TABLAS DEPENDIENTES
-- =========================================

PRINT 'Creando tablas dependientes...';

:r ../tables/entities/libro.sql
:r ../tables/entities/edicion.sql
:r ../tables/entities/ejemplar.sql
:r ../tables/entities/prestamo.sql
:r ../tables/entities/consulta.sql

-- =========================================
-- TABLAS RELACIONALES N:M
-- =========================================

PRINT 'Creando tablas relacionales...';

:r ../tables/relations/autor_libro.sql
:r ../tables/relations/edicion_tema.sql
:r ../tables/relations/edicion_palabra.sql
:r ../tables/relations/libro_materia.sql
:r ../tables/relations/docente_materia.sql
:r ../tables/relations/ejemplar_prestamo.sql
:r ../tables/relations/recomendado.sql


-- =========================================
-- SEED DATA
-- =========================================

--PRINT 'Insertando datos iniciales...';

--:r ../seed/idiomas.sql
--:r ../seed/estados.sql
--:r ../seed/temas.sql
--:r ../seed/editoriales.sql
--:r ../seed/materias.sql


-- =========================================
-- FINALIZADO
-- =========================================

PRINT '=========================================';
PRINT 'REBUILD FINALIZADO CORRECTAMENTE';
PRINT '=========================================';
