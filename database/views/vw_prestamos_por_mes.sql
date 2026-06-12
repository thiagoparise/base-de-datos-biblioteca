-- =========================================
-- Vista: vw_prestamos_por_mes
-- =========================================
-- Vista para desacoplar la lógica en el Procedure de estadísticas
-- =========================================

CREATE OR ALTER VIEW vw_prestamos_por_mes AS
SELECT
	YEAR(P.fecha_realizado)            AS año,
	MONTH(P.fecha_realizado)           AS mes,
	DATENAME(MONTH, P.fecha_realizado) AS nombre_mes,
	P.id_prestamo,
	SIE.cod_isbn,
	SIE.num_ejemplar,
	Li.id_libro,
	Li.titulo,
	Edi.id_editorial,
	Edi.nombre_editorial
FROM       Prestamo    P
INNER JOIN SeIncluyeEn SIE ON SIE.id_prestamo  = P.id_prestamo
INNER JOIN Edicion     E   ON E.cod_isbn       = SIE.cod_isbn
INNER JOIN Libro       Li  ON Li.id_libro      = E.id_libro
INNER JOIN Editorial   Edi ON Edi.id_editorial = Li.id_editorial;
