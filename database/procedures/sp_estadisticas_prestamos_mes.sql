-- =========================================
-- SP: sp_estadisticas_prestamos_mes
-- =========================================
-- Req 3: cantidad de libros prestados en un mes, agrupados por
-- (titulo / autor / editorial / tema), en comparación con el mismo mes del año anterior.
-- =========================================

CREATE OR ALTER PROCEDURE sp_estadisticas_prestamos_mes
	@año INT,
	@mes INT,
	@agrupar_por VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;

	IF @agrupar_por NOT IN ('titulo', 'autor', 'editorial', 'tema')
	BEGIN
		RAISERROR('agrupar_por debe ser: titulo, autor, editorial o tema. Recibido: %s', 16, 1, @agrupar_por);
		RETURN;
	END

	DECLARE @año_anterior INT = @año - 1;

	IF @agrupar_por = 'titulo'
	BEGIN
		SELECT
			ppm.titulo AS agrupacion,
			( SELECT COUNT(*)
			  FROM vw_prestamos_por_mes
			  WHERE titulo = ppm.titulo AND mes = @mes AND año = @año
			) AS cantidad_prestamos_año_actual,
			( SELECT COUNT(*)
			  FROM vw_prestamos_por_mes
			  WHERE titulo = ppm.titulo AND mes = @mes AND año = @año_anterior
			) AS cantidad_prestamos_año_anterior
		FROM vw_prestamos_por_mes ppm
		WHERE ppm.mes = @mes AND ppm.año IN (@año, @año_anterior)
		GROUP BY ppm.titulo
		ORDER BY cantidad_prestamos_año_actual DESC;
	END
	ELSE IF @agrupar_por = 'editorial'
	BEGIN
		SELECT
			ppm.nombre_editorial AS agrupacion,
			( SELECT COUNT(*)
			  FROM vw_prestamos_por_mes
			  WHERE nombre_editorial = ppm.nombre_editorial AND mes = @mes AND año = @año
			) AS cantidad_prestamos_año_actual,
			( SELECT COUNT(*)
			  FROM vw_prestamos_por_mes
			  WHERE nombre_editorial = ppm.nombre_editorial AND mes = @mes AND año = @año_anterior
			) AS cantidad_prestamos_año_anterior
		FROM vw_prestamos_por_mes ppm
		WHERE ppm.mes = @mes AND ppm.año IN (@año, @año_anterior)
		GROUP BY ppm.nombre_editorial
		ORDER BY cantidad_prestamos_año_actual DESC;
	END
	ELSE IF @agrupar_por = 'autor'
	BEGIN
		SELECT
			CONCAT(A.apellido, ', ', A.nombre) AS agrupacion,
			( SELECT COUNT(*)
			  FROM       vw_prestamos_por_mes ppm2
			  INNER JOIN Escribe              Esc2 ON Esc2.id_libro = ppm2.id_libro
			  WHERE Esc2.id_autor = A.id_autor AND ppm2.mes = @mes AND ppm2.año = @año
			) AS cantidad_prestamos_año_actual,
			( SELECT COUNT(*)
			  FROM       vw_prestamos_por_mes ppm2
			  INNER JOIN Escribe              Esc2 ON Esc2.id_libro = ppm2.id_libro
			  WHERE Esc2.id_autor = A.id_autor AND ppm2.mes = @mes AND ppm2.año = @año_anterior
			) AS cantidad_prestamos_año_anterior
		FROM       vw_prestamos_por_mes ppm
		INNER JOIN Escribe              Esc ON Esc.id_libro = ppm.id_libro
		INNER JOIN Autor                A   ON A.id_autor   = Esc.id_autor
		WHERE ppm.mes = @mes AND ppm.año IN (@año, @año_anterior)
		GROUP BY A.id_autor, A.apellido, A.nombre
		ORDER BY cantidad_prestamos_año_actual DESC;
	END
	ELSE IF @agrupar_por = 'tema'
	BEGIN
		SELECT
			T.nombre AS agrupacion,
			( SELECT COUNT(*)
			  FROM       vw_prestamos_por_mes ppm2
			  INNER JOIN TrataSobre           Tr2 ON Tr2.cod_isbn = ppm2.cod_isbn
			  WHERE Tr2.id_tema = T.id_tema AND ppm2.mes = @mes AND ppm2.año = @año
			) AS cantidad_prestamos_año_actual,
			( SELECT COUNT(*)
			  FROM       vw_prestamos_por_mes ppm2
			  INNER JOIN TrataSobre           Tr2 ON Tr2.cod_isbn = ppm2.cod_isbn
			  WHERE Tr2.id_tema = T.id_tema AND ppm2.mes = @mes AND ppm2.año = @año_anterior
			) AS cantidad_prestamos_año_anterior
		FROM       vw_prestamos_por_mes ppm
		INNER JOIN TrataSobre           Tr ON Tr.cod_isbn = ppm.cod_isbn
		INNER JOIN Tema                 T  ON T.id_tema   = Tr.id_tema
		WHERE ppm.mes = @mes AND ppm.año IN (@año, @año_anterior)
		GROUP BY T.id_tema, T.nombre
		ORDER BY cantidad_prestamos_año_actual DESC;
	END
END;
