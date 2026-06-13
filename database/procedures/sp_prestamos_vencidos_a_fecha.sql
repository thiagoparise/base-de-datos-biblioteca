-- =========================================
-- SP: sp_prestamos_vencidos_a_fecha
-- =========================================
-- Req 1: listado de préstamos vencidos a una fecha dada,
-- con datos del deudor y del libro para poder reclamarlo.
--
-- @fecha:
--   - 'DD-MM-YYYY'           → vencidos al cierre de esa fecha.
--   - NULL                   → sin pasarle parametro la fecha de revisión es a fecha actual.
--   - cualquier otro formato → error con mensaje claro.
--
-- El PROCEDURE parsea al formato de fechas de salida en formato DD-MM-YYYY".
--
-- El cálculo de fecha_limite se realiza en vw_prestamos_activos.
-- =========================================

CREATE OR ALTER PROCEDURE sp_prestamos_vencidos_a_fecha
	@fecha VARCHAR(10) = NULL   -- 'DD-MM-YYYY' o NULL para hoy
AS
BEGIN
	SET NOCOUNT ON;

	-- Formato DD-MM-YYYY (ANSI/ISO "italiano").
	DECLARE @formato_arg INT = 105;
	DECLARE @fecha_revision DATE;

	IF @fecha IS NULL
		SET @fecha_revision = CAST(GETDATE() AS DATE);
	ELSE
	BEGIN
		SET @fecha_revision = TRY_CONVERT(DATE, @fecha, @formato_arg);
		IF @fecha_revision IS NULL
		BEGIN
			RAISERROR(
				'Formato invalido para @fecha. Se espera DD-MM-YYYY (ej: ''10-06-2026''). Recibido: %s',
				16, 1, @fecha);
			RETURN;
		END
	END

	SELECT
		id_prestamo,
		num_lector,
		nombre,
		apellido,
		cuil,
		telefono,
		email,
		id_libro,
		titulo,
		cod_isbn,
		num_ejemplar,
		CONVERT(VARCHAR(10), fecha_realizado, @formato_arg) AS fecha_realizado,
		dias_plazo,
		CONVERT(VARCHAR(10), fecha_limite,    @formato_arg) AS fecha_limite,
		DATEDIFF(DAY, fecha_limite, @fecha_revision) AS dias_atraso
	FROM vw_prestamos_activos
	WHERE fecha_limite < @fecha_revision
	ORDER BY dias_atraso DESC;   -- lectores con vencimientos más atrasados primero
END;
