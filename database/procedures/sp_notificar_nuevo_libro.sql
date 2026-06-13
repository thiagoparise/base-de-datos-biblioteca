-- =========================================
-- SP: sp_notificar_nuevo_libro
-- =========================================
-- Req 4: dado el id_libro de un libro nuevo, devuelve los lectores a notificar por e-mail.
-- Un lector califica si solicitó TODOS los libros de los autores del nuevo libro.
--
-- Hipótesis: Solicitar se entiende que es préstamo o consulta en sala. (basta con haber leído al menos una edición del libro).
-- =========================================

CREATE OR ALTER PROCEDURE sp_notificar_nuevo_libro
	@id_libro_nuevo INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT L.num_lector, L.nombre, L.apellido, L.email
	FROM Lector L
	WHERE
		-- 1. Verifico que al menos solicitó 1 libro previo
		EXISTS (
			SELECT 1
			FROM (
				-- Libros previos de los autores del libro nuevo
				SELECT DISTINCT Esc.id_libro
				FROM Escribe Esc
				WHERE Esc.id_autor IN (
					SELECT id_autor FROM Escribe WHERE id_libro = @id_libro_nuevo
				)
				  AND Esc.id_libro <> @id_libro_nuevo
			) LPA, vw_solicitudes_lector SL
			WHERE SL.num_lector = L.num_lector
			  AND SL.id_libro   = LPA.id_libro
		)
		
		-- 2. NO existe libro previo que el lector NO haya solicitado (división relacional)
		AND NOT EXISTS (
			SELECT 1
			FROM (
				SELECT DISTINCT Esc.id_libro
				FROM Escribe Esc
				WHERE Esc.id_autor IN (
					SELECT id_autor FROM Escribe WHERE id_libro = @id_libro_nuevo
				)
				  AND Esc.id_libro <> @id_libro_nuevo
			) LPA
			WHERE NOT EXISTS (
				SELECT 1 FROM vw_solicitudes_lector SL
				WHERE SL.num_lector = L.num_lector
				  AND SL.id_libro   = LPA.id_libro
			)
		);
END;
