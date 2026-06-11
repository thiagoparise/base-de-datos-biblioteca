-- =========================================
-- Vista: vw_prestamos_activos
-- =========================================
-- Plazo:  14 días para docentes, 7 días para alumnos / graduados.
--
-- La idea es reutilizar esta vista en la consulta de estado de ejemplares (Req 2)
-- para saber la fecha esperada de devolución del préstamo activo de un ejemplar.
-- =========================================

CREATE OR ALTER VIEW vw_prestamos_activos AS
SELECT
	P.id_prestamo,
	P.num_lector,
	L.nombre,
	L.apellido,
	L.cuil,
	L.telefono,
	LI.id_libro,
	LI.titulo,
	SIE.cod_isbn,
	SIE.num_ejemplar,
	P.fecha_realizado,
	P.dias_plazo,
	DATEADD(DAY, P.dias_plazo, P.fecha_realizado) AS fecha_limite
FROM (
	-- Subconsulta: se valida una sola vez para no duplicar el CASE en el SELECT externo.
	SELECT
		P.id_prestamo,
		P.num_lector,
		P.fecha_realizado,
		CASE
			WHEN LD.num_lector IS NOT NULL THEN 14    -- docente
			ELSE                                7     -- alumno o graduado
		END AS dias_plazo
	FROM Prestamo P LEFT JOIN LectorDocente LD ON LD.num_lector = P.num_lector
) P
INNER JOIN Lector       L    ON L.num_lector    = P.num_lector
INNER JOIN SeIncluyeEn  SIE  ON SIE.id_prestamo = P.id_prestamo
INNER JOIN Edicion      E    ON E.cod_isbn      = SIE.cod_isbn
INNER JOIN Libro        LI   ON LI.id_libro     = E.id_libro
WHERE SIE.fecha_devuelto IS NULL;
