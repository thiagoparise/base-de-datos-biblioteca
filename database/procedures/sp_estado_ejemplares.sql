-- =========================================
-- SP: sp_estado_ejemplares
-- =========================================
-- Req 2: estado actual de los ejemplares filtrado por uno de: ['libro', 'autor', 'tema', 'profesor']
--
-- Devuelve para cada ejemplar:
--   situacion: 'En estanteria' / 'Prestado' / 'Vencido'
--   fecha_devolucion_esperada si está prestado o vencido
-- =========================================

CREATE OR ALTER PROCEDURE sp_estado_ejemplares
	@tipo_filtro VARCHAR(20),
	@id_filtro INT
AS
BEGIN
	SET NOCOUNT ON;

	-- Formato DD-MM-YYYY.
	DECLARE @formato_arg INT  = 105;
	DECLARE @hoy         DATE = CAST(GETDATE() AS DATE);

	IF @tipo_filtro NOT IN ('libro', 'autor', 'tema', 'profesor')
	BEGIN
		RAISERROR(
			'tipo_filtro debe ser: libro, autor, tema o profesor. Recibido: %s',
			16,1,
			@tipo_filtro
		);
		RETURN;
	END

	SELECT
		Li.id_libro,
		Li.titulo,
		Ej.cod_isbn,
		Ej.num_ejemplar,
		Es.descripcion_estado AS estado_fisico,
		Est.zona AS estanteria,
		CASE
			WHEN Ej.disponible    = 1       THEN 'En estanteria'
			WHEN vpa.fecha_limite <  @hoy   THEN 'Vencido'
			WHEN vpa.fecha_limite >= @hoy   THEN 'Prestado'
			ELSE 'Sin estado'   -- defensa: disponible=0 sin préstamo activo (sin sincronía)
		END AS situacion,
		CASE
			WHEN vpa.fecha_limite IS NULL THEN NULL
			ELSE CONVERT(VARCHAR(10), vpa.fecha_limite, @formato_arg)
		END AS fecha_devolucion_esperada
	FROM       Ejemplar             Ej
	INNER JOIN Edicion              E    ON E.cod_isbn        = Ej.cod_isbn
	INNER JOIN Libro                Li   ON Li.id_libro       = E.id_libro
	INNER JOIN Estado               Es   ON Es.id_estado      = Ej.id_estado
	INNER JOIN Estanteria           Est  ON Est.id_estanteria = E.id_estanteria
	LEFT JOIN  vw_prestamos_activos vpa  ON vpa.cod_isbn      = Ej.cod_isbn
	                                    AND vpa.num_ejemplar  = Ej.num_ejemplar
	WHERE
		   (@tipo_filtro = 'libro'    AND Li.id_libro = @id_filtro)
		OR (@tipo_filtro = 'autor'    AND EXISTS (
				SELECT 1 FROM Escribe
				WHERE id_libro = Li.id_libro AND id_autor = @id_filtro))
		OR (@tipo_filtro = 'tema'     AND EXISTS (
				SELECT 1 FROM TrataSobre
				WHERE cod_isbn = Ej.cod_isbn AND id_tema = @id_filtro))
		OR (@tipo_filtro = 'profesor' AND EXISTS (
				SELECT 1 FROM Recomendado
				WHERE id_libro = Li.id_libro AND num_lector = @id_filtro))
	ORDER BY Li.titulo, Ej.cod_isbn, Ej.num_ejemplar;
END;
