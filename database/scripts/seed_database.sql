-- =========================================
-- Seed de datos de prueba
-- =========================================

PRINT '=========================================';
PRINT 'INSERTANDO DATOS DE PRUEBA';
PRINT '=========================================';


-- =========================================
-- DATOS DE REFERENCIA
-- =========================================

PRINT 'Insertando estados...';

INSERT INTO Estado (descripcion) VALUES
    ('Disponible'),
    ('Prestado'),
    ('En Reparación'),
    ('Dado de Baja');


PRINT 'Insertando idiomas...';

INSERT INTO Idioma (nombre) VALUES
    ('Español'),
    ('Inglés'),
    ('Portugués');


PRINT 'Insertando editoriales...';

INSERT INTO Editorial (nombre) VALUES
    ('Pearson Educación'),
    ('McGraw-Hill'),
    ('Addison-Wesley'),
    ('Alfaomega');


PRINT 'Insertando estanterías...';

INSERT INTO Estanteria (zona) VALUES
    ('A - Informática'),
    ('B - Matemática'),
    ('C - Física'),
    ('D - General');


PRINT 'Insertando temas...';

INSERT INTO Tema (nombre) VALUES
    ('Base de Datos'),
    ('Algoritmos'),
    ('Redes de Computadoras'),
    ('Matemática Discreta'),
    ('Cálculo'),
    ('Ingeniería de Software');


PRINT 'Insertando palabras clave...';

INSERT INTO PalabraClave (palabra) VALUES
    ('SQL'),
    ('Normalización'),
    ('Algoritmo'),
    ('Grafo'),
    ('TCP/IP'),
    ('Sorting'),
    ('Árbol'),
    ('Complejidad');


PRINT 'Insertando materias...';

INSERT INTO Materia (nombre) VALUES
    ('Diseño de Base de Datos'),
    ('Algoritmos y Estructuras de Datos'),
    ('Redes de Computadoras'),
    ('Análisis Matemático I');


-- =========================================
-- CATÁLOGO
-- =========================================

PRINT 'Insertando autores...';

INSERT INTO Autor (nombre, apellido, nombreFantasia, fechaNacimiento, biografia) VALUES
    ('Abraham',    'Silberschatz', 'Silberschatz', '1945-07-18', 'Profesor en Yale, co-autor del clásico Fundamentos de Bases de Datos.'),
    ('Henry F.',   'Korth',        'Korth',        '1951-03-15', 'Investigador y docente, co-autor de Fundamentos de Bases de Datos.'),
    ('Thomas H.',  'Cormen',       'Cormen',       '1956-06-10', 'Profesor en Dartmouth College, co-autor de Introducción a los Algoritmos.'),
    ('Charles E.', 'Leiserson',    'Leiserson',    '1953-08-21', 'Profesor en MIT, co-autor de Introducción a los Algoritmos.'),
    ('Andrew S.',  'Tanenbaum',    'Tanenbaum',    '1944-03-16', 'Profesor en la Vrije Universiteit Amsterdam, autor de Redes de Computadoras.'),
    ('Donald E.',  'Knuth',        'Knuth',        '1938-01-10', 'Profesor emérito en Stanford, autor de El Arte de la Programación de Computadoras.');


PRINT 'Insertando libros...';
-- idEditorial: 1=Pearson, 2=McGraw-Hill, 3=Addison-Wesley, 4=Alfaomega
-- idIdioma:    1=Español, 2=Inglés, 3=Portugués

INSERT INTO Libro (titulo, idEditorial, idIdioma) VALUES
    ('Fundamentos de Bases de Datos',              1, 1),   -- idLibro 1
    ('Introducción a los Algoritmos',              2, 1),   -- idLibro 2
    ('Redes de Computadoras',                      1, 1),   -- idLibro 3
    ('El Arte de la Programación de Computadoras', 3, 2),   -- idLibro 4
    ('Diseño de Bases de Datos Relacionales',      4, 1);   -- idLibro 5


PRINT 'Insertando ediciones...';
-- idEstanteria: 1=A Informática, 2=B Matemática, 3=C Física, 4=D General
-- indice:       número de edición

INSERT INTO Edicion (codISBN, fechaPublicacion, indice, idLibro, idEstanteria) VALUES
    ('9780078022159', '2011-01-01', 7, 1, 1),   -- Fundamentos BD, 7a ed
    ('9780131873254', '2006-01-01', 6, 1, 1),   -- Fundamentos BD, 6a ed
    ('9780262033848', '2009-07-31', 3, 2, 1),   -- Introducción Algoritmos, 3a ed
    ('9780132126953', '2011-10-07', 5, 3, 1),   -- Redes de Computadoras, 5a ed
    ('9780201485417', '1968-01-01', 1, 4, 1),   -- El Arte de la Programación Vol. 1
    ('9789587780246', '2015-06-01', 1, 5, 1),   -- Diseño BD Relacionales, 1a ed
    ('9780262046305', '2022-04-05', 4, 2, 1);   -- Introducción Algoritmos, 4a ed


PRINT 'Insertando ejemplares...';
-- idEstado: 1=Disponible, 2=Prestado, 3=En Reparación, 4=Dado de Baja

-- Fundamentos BD 7a ed (ISBN 9780078022159): 3 ejemplares
INSERT INTO Ejemplar (codISBN, idEstado) VALUES ('9780078022159', 2);   -- numEjemplar  1: Prestado (préstamo vencido)
INSERT INTO Ejemplar (codISBN, idEstado) VALUES ('9780078022159', 1);   -- numEjemplar  2: Disponible
INSERT INTO Ejemplar (codISBN, idEstado) VALUES ('9780078022159', 1);   -- numEjemplar  3: Disponible

-- Fundamentos BD 6a ed (ISBN 9780131873254): 2 ejemplares
INSERT INTO Ejemplar (codISBN, idEstado) VALUES ('9780131873254', 1);   -- numEjemplar  4: Disponible
INSERT INTO Ejemplar (codISBN, idEstado) VALUES ('9780131873254', 1);   -- numEjemplar  5: Disponible

-- Introducción Algoritmos 3a ed (ISBN 9780262033848): 3 ejemplares
INSERT INTO Ejemplar (codISBN, idEstado) VALUES ('9780262033848', 2);   -- numEjemplar  6: Prestado (préstamo vencido)
INSERT INTO Ejemplar (codISBN, idEstado) VALUES ('9780262033848', 1);   -- numEjemplar  7: Disponible
INSERT INTO Ejemplar (codISBN, idEstado) VALUES ('9780262033848', 1);   -- numEjemplar  8: Disponible

-- Redes de Computadoras 5a ed (ISBN 9780132126953): 2 ejemplares
INSERT INTO Ejemplar (codISBN, idEstado) VALUES ('9780132126953', 1);   -- numEjemplar  9: Disponible
INSERT INTO Ejemplar (codISBN, idEstado) VALUES ('9780132126953', 3);   -- numEjemplar 10: En Reparación

-- El Arte de la Programación Vol. 1 (ISBN 9780201485417): 1 ejemplar — único → habilita consultas en sala
INSERT INTO Ejemplar (codISBN, idEstado) VALUES ('9780201485417', 1);   -- numEjemplar 11: Disponible

-- Diseño BD Relacionales 1a ed (ISBN 9789587780246): 2 ejemplares
INSERT INTO Ejemplar (codISBN, idEstado) VALUES ('9789587780246', 2);   -- numEjemplar 12: Prestado (préstamo vencido)
INSERT INTO Ejemplar (codISBN, idEstado) VALUES ('9789587780246', 2);   -- numEjemplar 13: Prestado (préstamo vencido)

-- Introducción Algoritmos 4a ed (ISBN 9780262046305): 2 ejemplares
INSERT INTO Ejemplar (codISBN, idEstado) VALUES ('9780262046305', 1);   -- numEjemplar 14: Disponible (préstamo devuelto)
INSERT INTO Ejemplar (codISBN, idEstado) VALUES ('9780262046305', 2);   -- numEjemplar 15: Prestado (préstamo activo)


-- =========================================
-- LECTORES
-- =========================================

PRINT 'Insertando lectores...';
-- cuil: NCHAR(11) sin guiones

INSERT INTO Lector (nombre, apellido, cuil, telefono) VALUES
    ('María',     'González',  '27301234560', '2235410001'),   -- numLector  1 → Docente
    ('Carlos',    'Rodríguez', '20256789012', '2235410002'),   -- numLector  2 → Docente
    ('Ana',       'Martínez',  '27345678901', '2235410003'),   -- numLector  3 → Docente
    ('Luis',      'Fernández', '20456789013', '2235410004'),   -- numLector  4 → Docente
    ('Sofía',     'López',     '27567890124', '2235410005'),   -- numLector  5 → Alumno
    ('Diego',     'Sánchez',   '20678901235', '2235410006'),   -- numLector  6 → Alumno
    ('Valentina', 'Torres',    '27789012346', '2235410007'),   -- numLector  7 → Alumno
    ('Martín',    'Pérez',     '20890123457', '2235410008'),   -- numLector  8 → Alumno
    ('Florencia', 'Gómez',     '27901234568', '2235410009'),   -- numLector  9 → Graduado
    ('Javier',    'Díaz',      '20012345679', '2235410010');   -- numLector 10 → Graduado


PRINT 'Insertando docentes...';

INSERT INTO LectorDocente (numLector) VALUES (1), (2), (3), (4);


PRINT 'Insertando alumnos...';

INSERT INTO LectorAlumno (numLector, libreta) VALUES
    (5, 'LU-12345'),
    (6, 'LU-23456'),
    (7, 'LU-34567'),
    (8, 'LU-45678');


PRINT 'Insertando graduados...';

INSERT INTO LectorGraduado (numLector, fechaEgreso) VALUES
    (9,  '2022-12-15'),
    (10, '2020-06-30');


-- =========================================
-- RELACIONES N:M
-- =========================================

PRINT 'Insertando relaciones autor-libro...';

INSERT INTO AutorLibro (idAutor, idLibro) VALUES
    (1, 1),   -- Silberschatz → Fundamentos BD
    (2, 1),   -- Korth        → Fundamentos BD
    (3, 2),   -- Cormen       → Introducción Algoritmos
    (4, 2),   -- Leiserson    → Introducción Algoritmos
    (5, 3),   -- Tanenbaum    → Redes de Computadoras
    (6, 4),   -- Knuth        → El Arte de la Programación
    (1, 5);   -- Silberschatz → Diseño BD Relacionales


PRINT 'Insertando relaciones edición-tema...';

INSERT INTO EdicionTema (codISBN, idTema) VALUES
    ('9780078022159', 1),   -- Fundamentos BD 7a → Base de Datos
    ('9780078022159', 6),   -- Fundamentos BD 7a → Ingeniería de Software
    ('9780131873254', 1),   -- Fundamentos BD 6a → Base de Datos
    ('9780262033848', 2),   -- Algoritmos 3a     → Algoritmos
    ('9780262033848', 4),   -- Algoritmos 3a     → Matemática Discreta
    ('9780132126953', 3),   -- Redes 5a          → Redes de Computadoras
    ('9780201485417', 2),   -- Arte Programación → Algoritmos
    ('9789587780246', 1),   -- Diseño BD         → Base de Datos
    ('9780262046305', 2),   -- Algoritmos 4a     → Algoritmos
    ('9780262046305', 4);   -- Algoritmos 4a     → Matemática Discreta


PRINT 'Insertando relaciones edición-palabra clave...';

INSERT INTO EdicionPalabra (codISBN, idPalabraClave) VALUES
    ('9780078022159', 1),   -- Fundamentos BD 7a → SQL
    ('9780078022159', 2),   -- Fundamentos BD 7a → Normalización
    ('9780131873254', 1),   -- Fundamentos BD 6a → SQL
    ('9780131873254', 2),   -- Fundamentos BD 6a → Normalización
    ('9780262033848', 3),   -- Algoritmos 3a     → Algoritmo
    ('9780262033848', 4),   -- Algoritmos 3a     → Grafo
    ('9780262033848', 6),   -- Algoritmos 3a     → Sorting
    ('9780262033848', 8),   -- Algoritmos 3a     → Complejidad
    ('9780132126953', 5),   -- Redes 5a          → TCP/IP
    ('9780201485417', 3),   -- Arte Programación → Algoritmo
    ('9780201485417', 7),   -- Arte Programación → Árbol
    ('9789587780246', 1),   -- Diseño BD         → SQL
    ('9789587780246', 2),   -- Diseño BD         → Normalización
    ('9780262046305', 3),   -- Algoritmos 4a     → Algoritmo
    ('9780262046305', 4),   -- Algoritmos 4a     → Grafo
    ('9780262046305', 6),   -- Algoritmos 4a     → Sorting
    ('9780262046305', 8);   -- Algoritmos 4a     → Complejidad


PRINT 'Insertando materias dictadas por docentes...';
-- numLector: 1=María, 2=Carlos, 3=Ana, 4=Luis
-- idMateria:  1=Diseño BD, 2=Algoritmos, 3=Redes, 4=Análisis Mat.

INSERT INTO DocenteMateria (numLector, idMateria) VALUES
    (1, 1),   -- María  → Diseño BD
    (1, 2),   -- María  → Algoritmos
    (2, 1),   -- Carlos → Diseño BD
    (2, 3),   -- Carlos → Redes
    (3, 2),   -- Ana    → Algoritmos
    (3, 4),   -- Ana    → Análisis Mat.
    (4, 3);   -- Luis   → Redes


PRINT 'Insertando bibliografía de materias...';
-- esObligatorio: 1=sí, 0=no

INSERT INTO LibroMateria (idLibro, idMateria, esObligatorio) VALUES
    (1, 1, 1),   -- Fundamentos BD      → Diseño BD (obligatorio)
    (5, 1, 1),   -- Diseño BD Rel.      → Diseño BD (obligatorio)
    (1, 2, 0),   -- Fundamentos BD      → Algoritmos (optativo)
    (2, 2, 1),   -- Introd. Algoritmos  → Algoritmos (obligatorio)
    (4, 2, 0),   -- Arte Programación   → Algoritmos (optativo)
    (3, 3, 1);   -- Redes               → Redes (obligatorio)


PRINT 'Insertando libros recomendados por docentes...';

INSERT INTO Recomendado (numLector, idMateria, idLibro) VALUES
    (1, 1, 1),   -- María  recomienda Fundamentos BD     en Diseño BD
    (1, 1, 5),   -- María  recomienda Diseño BD Rel.     en Diseño BD
    (2, 1, 1),   -- Carlos recomienda Fundamentos BD     en Diseño BD
    (3, 2, 2);   -- Ana    recomienda Introd. Algoritmos en Algoritmos


-- =========================================
-- PRÉSTAMOS Y CONSULTAS
-- =========================================

PRINT 'Insertando préstamos...';
-- Vencimiento: docentes = 14 días, alumnos/graduados = 7 días

INSERT INTO Prestamo (numLector, fechaRealizado) VALUES
    (1, '2026-01-10'),   -- idPrestamo 1: María      (docente)   → vencido (límite 2026-01-24)
    (5, '2026-02-01'),   -- idPrestamo 2: Sofía      (alumno)    → vencido (límite 2026-02-08)
    (9, '2026-03-15'),   -- idPrestamo 3: Florencia  (graduado)  → vencido (límite 2026-03-22)
    (2, '2026-05-10'),   -- idPrestamo 4: Carlos     (docente)   → devuelto
    (6, '2026-05-28'),   -- idPrestamo 5: Diego      (alumno)    → activo  (límite 2026-06-04)
    (8, '2026-04-15');   -- idPrestamo 6: Martín     (alumno)    → vencido (límite 2026-04-22)


PRINT 'Insertando detalle de ejemplares por préstamo...';

INSERT INTO EjemplarPrestamo (idPrestamo, codISBN, numEjemplar, idEstadoDevuelto, fechaDevuelto) VALUES
    (1, '9780078022159', 1,  NULL, NULL),            -- Préstamo 1: activo/vencido
    (2, '9780262033848', 6,  NULL, NULL),            -- Préstamo 2: activo/vencido
    (3, '9789587780246', 12, NULL, NULL),            -- Préstamo 3: activo/vencido
    (4, '9780262046305', 14, 1,   '2026-05-20'),     -- Préstamo 4: devuelto (estado Disponible)
    (5, '9780262046305', 15, NULL, NULL),            -- Préstamo 5: activo
    (6, '9789587780246', 13, NULL, NULL);            -- Préstamo 6: activo/vencido


PRINT 'Insertando consultas en sala...';
-- Solo para ediciones con ejemplar único (ISBN 9780201485417, numEjemplar 11)

INSERT INTO Consulta (fechaConsulta, codISBN, numEjemplar, numLector) VALUES
    ('2026-04-10', '9780201485417', 11, 7),    -- Valentina (alumno)
    ('2026-05-15', '9780201485417', 11, 3),    -- Ana       (docente)
    ('2026-05-20', '9780201485417', 11, 10);   -- Javier    (graduado)


PRINT '=========================================';
PRINT 'SEED FINALIZADO CORRECTAMENTE';
PRINT '=========================================';
