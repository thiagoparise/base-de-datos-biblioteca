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

:r ../tables/relations/escribe.sql
:r ../tables/relations/trata_sobre.sql
:r ../tables/relations/se_describe_por.sql
:r ../tables/relations/es_bibliografia_de.sql
:r ../tables/relations/dicta.sql
:r ../tables/relations/se_incluye_en.sql
:r ../tables/relations/recomendado.sql


-- =========================================
-- TRIGGERS
-- =========================================

PRINT 'Creando triggers...';
GO
:r ../triggers/tr_se_incluye_en_disponibilidad_insert.sql
GO
:r ../triggers/tr_se_incluye_en_disponibilidad_update.sql
GO


-- =========================================
-- VIEWS
-- =========================================

PRINT 'Creando vistas...';
GO
:r ../views/vw_prestamos_activos.sql
GO
:r ../views/vw_prestamos_por_mes.sql
GO


-- =========================================
-- STORED PROCEDURES
-- =========================================

PRINT 'Creando stored procedures...';
GO
:r ../procedures/sp_prestamos_vencidos_a_fecha.sql
GO
:r ../procedures/sp_estado_ejemplares.sql
GO
:r ../procedures/sp_estadisticas_prestamos_mes.sql
GO


-- =========================================
-- FINALIZADO
-- =========================================

PRINT '=========================================';
PRINT 'REBUILD FINALIZADO CORRECTAMENTE';
PRINT '=========================================';
