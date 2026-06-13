-- =========================================
-- Vista: vw_solicitudes_lector
-- =========================================
-- Devuelve los libros que cada lector solicitó.
-- "Solicitar" se interpreta de manera amplia: préstamo o consulta en sala.
--
-- Se cuenta que el lector haya visto libro, no la edición: leer cualquier edición del libro cuenta como haberlo solicitado.
-- =========================================

CREATE OR ALTER VIEW vw_solicitudes_lector AS
SELECT DISTINCT P.num_lector, E.id_libro
FROM Prestamo P, SeIncluyeEn SIE, Edicion E
WHERE SIE.id_prestamo = P.id_prestamo
  AND E.cod_isbn      = SIE.cod_isbn
UNION
SELECT DISTINCT C.num_lector, E.id_libro
FROM Consulta C, Edicion E
WHERE E.cod_isbn = C.cod_isbn;
