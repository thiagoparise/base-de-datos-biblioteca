-- =========================================
-- SP: sp_registrar_prestamo
-- =========================================

CREATE OR ALTER PROCEDURE sp_registrar_prestamo
	@num_lector INT, --6
	@cod_isbn CHAR(13), --B73
	@num_ejemplar INT, --4
	@id_prestamo INT = NULL OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	BEGIN TRY
		BEGIN TRANSACTION;

		-- 1. Verificar que el lector exista
		IF NOT EXISTS (
			SELECT 1
			FROM   Lector
			WHERE  num_lector = @num_lector
		)
			RAISERROR('El lector %d no existe', 16, 1, @num_lector);

		-- 2. Verificar que el ejemplar esté disponible
		IF NOT EXISTS (
			SELECT 1
			FROM Ejemplar
			WHERE cod_isbn = @cod_isbn
			  AND num_ejemplar = @num_ejemplar
			  AND disponible = 1
		)
			RAISERROR('El ejemplar (cod_isbn=%s, num=%d) no esta disponible', 16, 1, @cod_isbn, @num_ejemplar);

		-- 3. Edición prestable:
		--    "Si hay más de un ejemplar de una determinada edición, el mismo puede ser
		--    prestado para retirar de la biblioteca, sino sólo se lo puede consultar
		--    dentro de la misma."
		IF (
			SELECT COUNT(*)
			FROM Ejemplar
			WHERE cod_isbn = @cod_isbn
		) < 2
			RAISERROR('La edicion %s tiene un solo ejemplar - solo se puede consultar en sala', 16, 1, @cod_isbn);

        -- "Una misma persona puede retirar varios ejemplares en un mismo préstamo"
		-- Si @id_prestamo viene NULL, es un préstamo nuevo, creo un prestamo a la fecha y guardo el @id_prestamo
		-- Si @id_prestamo no es NULL, se reutiliza el @id_prestamo, se crea un registro con otro ejemplar en SeIncluyeEn con el mismo @id_prestamo
		IF @id_prestamo IS NULL
		BEGIN
			INSERT INTO Prestamo (num_lector, fecha_realizado)
			VALUES (@num_lector, CAST(GETDATE() AS DATE));
			SET @id_prestamo = SCOPE_IDENTITY();
		END

		INSERT INTO SeIncluyeEn (id_prestamo, cod_isbn, num_ejemplar)
		VALUES (@id_prestamo, @cod_isbn, @num_ejemplar);
		-- Al agregar el ejemplar al préstamo, se ejecuta el trigger para marcar el ejemplar como no disponible

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
		THROW;   -- re-lanza el error original con su contexto
	END CATCH
END;
