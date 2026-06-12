-- =========================================
-- Trigger: tr_se_incluye_en_disponibilidad_insert
-- =========================================
-- Cuando se agrega un ejemplar a un préstamo, se registra que ese ejemplar como ocupado.
-- =========================================

CREATE OR ALTER TRIGGER tr_se_incluye_en_disponibilidad_insert
ON SeIncluyeEn
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE     Ej
	SET        Ej.disponible = 0
	FROM       Ejemplar Ej
	INNER JOIN inserted I  ON I.cod_isbn     = Ej.cod_isbn
	                      AND I.num_ejemplar = Ej.num_ejemplar
	WHERE I.fecha_devuelto IS NULL;
END;
