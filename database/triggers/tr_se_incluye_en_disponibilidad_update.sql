-- =========================================
-- Trigger: tr_se_incluye_en_disponibilidad_update
-- =========================================
-- Cuando se devuelve un ejemplar, se registra ese ejemplar como disponible,
-- considerando detectar la transición en la columna fecha_devuelto NULL → fecha
-- =========================================

CREATE OR ALTER TRIGGER tr_se_incluye_en_disponibilidad_update
ON SeIncluyeEn
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE     Ej
	SET        Ej.disponible = 1
	FROM       Ejemplar Ej
	INNER JOIN inserted I  ON I.cod_isbn     = Ej.cod_isbn
	                      AND I.num_ejemplar = Ej.num_ejemplar
	INNER JOIN deleted  D  ON D.id_prestamo  = I.id_prestamo
	                      AND D.cod_isbn     = I.cod_isbn
	                      AND D.num_ejemplar = I.num_ejemplar
	WHERE D.fecha_devuelto IS     NULL
	  AND I.fecha_devuelto IS NOT NULL;
END;
