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

INSERT INTO Estado (descripcion_estado) VALUES
    ('Perfecto'),        -- id_estado 1: sin marcas, como nuevo
    ('Bueno'),           -- id_estado 2: desgaste normal por uso
    ('Aceptable'),       -- id_estado 3: marcas o doblez menor, sigue siendo útil
    ('Deteriorado'),     -- id_estado 4: daño visible: páginas sueltas, tapa dañada
    ('Muy deteriorado'), -- id_estado 5: daño severo, uso limitado
    ('Inutilizable');    -- id_estado 6: destruido, no puede circular


PRINT 'Insertando idiomas...';

INSERT INTO Idioma (nombre) VALUES
    ('Español'),
    ('Inglés'),
    ('Portugués');


PRINT 'Insertando editoriales...';

INSERT INTO Editorial (nombre_editorial) VALUES
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

INSERT INTO Materia (nombre_materia) VALUES
    ('Diseño de Base de Datos'),
    ('Algoritmos y Estructuras de Datos'),
    ('Redes de Computadoras'),
    ('Análisis Matemático I');


-- =========================================
-- CATÁLOGO
-- =========================================

PRINT 'Insertando autores...';

INSERT INTO Autor (nombre, apellido, nombre_fantasia, fecha_nacimiento, biografia) VALUES
    ('Abraham',     'Silberschatz', 'Silberschatz', '1945-07-18', 'Profesor en Yale, co-autor del clásico Fundamentos de Bases de Datos.'),
    ('Henry F.',    'Korth',        'Korth',        '1951-03-15', 'Investigador y docente, co-autor de Fundamentos de Bases de Datos.'),
    ('Thomas H.',   'Cormen',       'Cormen',       '1956-06-10', 'Profesor en Dartmouth College, co-autor de Introducción a los Algoritmos.'),
    ('Charles E.',  'Leiserson',    'Leiserson',    '1953-08-21', 'Profesor en MIT, co-autor de Introducción a los Algoritmos.'),
    ('Andrew S.',   'Tanenbaum',    'Tanenbaum',    '1944-03-16', 'Profesor en la Vrije Universiteit Amsterdam, autor de Redes de Computadoras.'),
    ('Donald E.',   'Knuth',        'Knuth',        '1938-01-10', 'Profesor emérito en Stanford, autor de El Arte de la Programación de Computadoras.'),
    -- Nuevos para escenarios de notificación (Req 4)
    ('William',     'Stallings',    'Stallings',    '1945-04-09', 'Autor prolífico de textos sobre sistemas operativos, redes y criptografía.'),                          -- id_autor 7
    ('Christopher', 'Date',         'C.J. Date',    '1941-05-15', 'Pionero en la teoría de bases de datos relacionales, autor de "An Introduction to Database Systems".'), -- id_autor 8
    ('Stuart',      'Russell',      'Russell',      '1962-08-31', 'Profesor en Berkeley, co-autor de "Inteligencia Artificial: Un Enfoque Moderno".'),                     -- id_autor 9
    ('Peter',       'Norvig',       'Norvig',       '1956-12-14', 'Director de Investigación en Google, co-autor de "Inteligencia Artificial: Un Enfoque Moderno".');     -- id_autor 10


PRINT 'Insertando libros...';
-- id_editorial: 1=Pearson, 2=McGraw-Hill, 3=Addison-Wesley, 4=Alfaomega
-- id_idioma:    1=Español, 2=Inglés, 3=Portugués

INSERT INTO Libro (titulo, id_editorial, id_idioma) VALUES
    ('Fundamentos de Bases de Datos',                       1, 1),   -- id_libro 1
    ('Introducción a los Algoritmos',                       2, 1),   -- id_libro 2
    ('Redes de Computadoras',                               1, 1),   -- id_libro 3
    ('El Arte de la Programación de Computadoras',          3, 2),   -- id_libro 4
    ('Diseño de Bases de Datos Relacionales',               4, 1),   -- id_libro 5
    -- Nuevos para escenarios de notificación (Req 4)
    ('Sistemas Operativos: Aspectos Internos y Diseño',     1, 1),   -- id_libro 6  — Stallings (1/3)
    ('Criptografía y Seguridad en Redes',                   1, 1),   -- id_libro 7  — Stallings (2/3)
    ('Comunicaciones y Redes de Computadores',              1, 1),   -- id_libro 8  — Stallings (3/3)
    ('Introducción a los Sistemas de Bases de Datos',       1, 1),   -- id_libro 9  — Date (1/1)
    ('Inteligencia Artificial: Un Enfoque Moderno',         1, 1),   -- id_libro 10 — Russell + Norvig (co-autores)
    -- Solo-autor para escenarios multi-autor (Cormen + Leiserson son co-autores de libro 2)
    ('Métodos Numéricos para Ingeniería',                   2, 1),   -- id_libro 11 — Cormen (solo)     → habilita test multi-autor
    ('Computación Paralela: Algoritmos y Arquitecturas',    3, 1);   -- id_libro 12 — Leiserson (solo)  → habilita test multi-autor


PRINT 'Insertando ediciones...';
-- id_estanteria: 1=A Informática, 2=B Matemática, 3=C Física, 4=D General
-- indice:        número de edición

INSERT INTO Edicion (cod_isbn, fecha_publicacion, indice, id_libro, id_estanteria) VALUES
    ('9780078022159', '2011-01-01', 7, 1, 1),   -- Fundamentos BD, 7a ed
    ('9780131873254', '2006-01-01', 6, 1, 1),   -- Fundamentos BD, 6a ed
    ('9780262033848', '2009-07-31', 3, 2, 1),   -- Introducción Algoritmos, 3a ed
    ('9780132126953', '2011-10-07', 5, 3, 1),   -- Redes de Computadoras, 5a ed
    ('9780201485417', '1968-01-01', 1, 4, 1),   -- El Arte de la Programación Vol. 1
    ('9789587780246', '2015-06-01', 1, 5, 1),   -- Diseño BD Relacionales, 1a ed
    ('9780262046305', '2022-04-05', 4, 2, 1),   -- Introducción Algoritmos, 4a ed
    -- Nuevas ediciones para escenarios de notificación (Req 4)
    ('9788483227206', '2005-05-01', 5, 6,  1),  -- Sistemas Operativos (Stallings), 5a ed
    ('9788478291672', '2004-09-15', 4, 7,  1),  -- Criptografía (Stallings), 4a ed
    ('9788478290932', '2004-06-10', 7, 8,  1),  -- Comunicaciones y Redes (Stallings), 7a ed
    ('9788478290802', '2001-04-20', 7, 9,  1),  -- Introducción a Bases de Datos (Date), 7a ed
    ('9788420540030', '2010-11-25', 3, 10, 1),  -- IA: Un Enfoque Moderno (Russell + Norvig), 3a ed
    -- Solo-autor para escenarios multi-autor
    ('9788429143751', '2009-03-12', 1, 11, 2),  -- Métodos Numéricos (Cormen), 1a ed
    ('9788429143768', '2010-08-20', 2, 12, 2),  -- Computación Paralela (Leiserson), 2a ed
    -- Ediciones adicionales para profundizar testeo cruzado (más variedad por título)
    ('9780132553175', '2014-09-01', 6, 3,  1),  -- Redes de Computadoras, 6a ed (Tanenbaum)
    ('9780201896831', '1997-07-04', 3, 4,  1),  -- El Arte de la Programación Vol. 1, 3a impresión (1997) — ahora lendable (≥2 ej)
    ('9788448181192', '2021-03-10', 2, 5,  1),  -- Diseño BD Relacionales, 2a ed (Silberschatz)
    ('9780321197849', '2003-08-04', 8, 9,  1);  -- Introducción a los Sistemas de BD (Date), 8a ed


PRINT 'Insertando ejemplares...';
-- num_ejemplar: numeración física del ejemplar dentro de su edición (1, 2, 3, ... reinicia por cod_isbn).
-- id_estado:    1=Perfecto, 2=Bueno, 3=Aceptable, 4=Deteriorado, 5=Muy deteriorado, 6=Inutilizable.
-- disponible:   1=libre para préstamo, 0=ocupado. Coherente con los préstamos seedeados más abajo.

-- Fundamentos BD 7a ed (ISBN 9780078022159): 3 ejemplares
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (1, '9780078022159', 1, 0);   -- Perfecto    | ocupado (P1)
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (2, '9780078022159', 2, 0);   -- Bueno       | ocupado (P6 — historial: también pasó por P8 en 2025, ya devuelto)
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (3, '9780078022159', 2, 1);   -- Bueno       | libre (P4 ya devuelto)

-- Fundamentos BD 6a ed (ISBN 9780131873254): 2 ejemplares  (edición más antigua → más desgaste)
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (1, '9780131873254', 3, 0);   -- Aceptable   | ocupado (P1)
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (2, '9780131873254', 4, 1);   -- Deteriorado | libre (P4 ya devuelto)

-- Introducción Algoritmos 3a ed (ISBN 9780262033848): 3 ejemplares
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (1, '9780262033848', 2, 0);   -- Bueno       | ocupado (P2)
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (2, '9780262033848', 1, 1);   -- Perfecto    | libre (P7 en 2025 y P4 en 2026 ya devueltos)
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (3, '9780262033848', 2, 0);   -- Bueno       | ocupado (P3)

-- Redes de Computadoras 5a ed (ISBN 9780132126953): 2 ejemplares
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (1, '9780132126953', 2, 0);   -- Bueno       | ocupado (P3)
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (2, '9780132126953', 4, 1);   -- Deteriorado | libre (en reparación; el estado físico es ortogonal a la disponibilidad)

-- El Arte de la Programación Vol. 1 (ISBN 9780201485417): 1 ejemplar — único → habilita consultas en sala
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (1, '9780201485417', 3, 1);   -- Aceptable   | libre (las consultas en sala no ocupan el ejemplar a nivel disponible)

-- Diseño BD Relacionales 1a ed (ISBN 9789587780246): 2 ejemplares
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (1, '9789587780246', 2, 0);   -- Bueno       | ocupado (P3)
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (2, '9789587780246', 2, 0);   -- Bueno       | ocupado (P6)

-- Introducción Algoritmos 4a ed (ISBN 9780262046305): 2 ejemplares  (edición reciente → mejor estado)
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (1, '9780262046305', 1, 1);   -- Perfecto    | libre (P4 ya devuelto)
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (2, '9780262046305', 1, 0);   -- Perfecto    | ocupado (P5)

-- Nuevos ejemplares para Req 4 (todos disponibles: los préstamos asociados ya están devueltos)
-- Sistemas Operativos (Stallings, ISBN 9788483227206): 2 ejemplares
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (1, '9788483227206', 2, 1);   -- Bueno
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (2, '9788483227206', 1, 1);   -- Perfecto

-- Criptografía (Stallings, ISBN 9788478291672): 2 ejemplares
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (1, '9788478291672', 2, 1);   -- Bueno
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (2, '9788478291672', 2, 1);   -- Bueno

-- Comunicaciones y Redes (Stallings, ISBN 9788478290932): 2 ejemplares
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (1, '9788478290932', 1, 1);   -- Perfecto
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (2, '9788478290932', 2, 1);   -- Bueno

-- Introducción a Bases de Datos (Date, ISBN 9788478290802): 2 ejemplares
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (1, '9788478290802', 2, 1);   -- Bueno
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (2, '9788478290802', 1, 1);   -- Perfecto

-- IA: Un Enfoque Moderno (Russell + Norvig, ISBN 9788420540030): 2 ejemplares
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (1, '9788420540030', 1, 1);   -- Perfecto
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (2, '9788420540030', 2, 1);   -- Bueno

-- Métodos Numéricos (Cormen, ISBN 9788429143751): 2 ejemplares — escenarios multi-autor
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (1, '9788429143751', 1, 1);   -- Perfecto
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (2, '9788429143751', 2, 1);   -- Bueno

-- Computación Paralela (Leiserson, ISBN 9788429143768): 2 ejemplares — escenarios multi-autor
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (1, '9788429143768', 2, 1);   -- Bueno
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (2, '9788429143768', 1, 1);   -- Perfecto

-- Ediciones adicionales (más variedad por título, mejor cobertura de testeo)

-- Redes de Computadoras 6a ed (Tanenbaum, ISBN 9780132553175): 2 ejemplares
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (1, '9780132553175', 1, 1);   -- Perfecto
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (2, '9780132553175', 2, 1);   -- Bueno

-- El Arte Vol 1, 3a impresión (Knuth, ISBN 9780201896831): 2 ejemplares → libro 4 ahora también es prestable, no solo consulta
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (1, '9780201896831', 2, 1);   -- Bueno
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (2, '9780201896831', 1, 1);   -- Perfecto

-- Diseño BD Relacionales 2a ed (Silberschatz, ISBN 9788448181192): 2 ejemplares
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (1, '9788448181192', 1, 1);   -- Perfecto
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (2, '9788448181192', 2, 1);   -- Bueno

-- Introducción a Bases de Datos (Date) 8a ed (ISBN 9780321197849): 2 ejemplares
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (1, '9780321197849', 1, 1);   -- Perfecto
INSERT INTO Ejemplar (num_ejemplar, cod_isbn, id_estado, disponible) VALUES (2, '9780321197849', 2, 1);   -- Bueno


-- =========================================
-- LECTORES
-- =========================================

PRINT 'Insertando lectores...';
-- cuil: NCHAR(11) sin guiones
-- email: validado por CHECK (formato mínimo X@X.X)

INSERT INTO Lector (nombre, apellido, cuil, telefono, email) VALUES
    ('María',     'González',  '27301234560', '2235410001', 'maria.gonzalez@mdp.edu.ar'),    -- num_lector  1 → Docente
    ('Carlos',    'Rodríguez', '20256789012', '2235410002', 'carlos.rodriguez@mdp.edu.ar'),  -- num_lector  2 → Docente
    ('Ana',       'Martínez',  '27345678901', '2235410003', 'ana.martinez@mdp.edu.ar'),      -- num_lector  3 → Docente
    ('Luis',      'Fernández', '20456789013', '2235410004', 'luis.fernandez@mdp.edu.ar'),    -- num_lector  4 → Docente
    ('Sofía',     'López',     '27567890124', '2235410005', 'sofia.lopez@mdp.edu.ar'),       -- num_lector  5 → Alumno
    ('Diego',     'Sánchez',   '20678901235', '2235410006', 'diego.sanchez@mdp.edu.ar'),     -- num_lector  6 → Alumno
    ('Valentina', 'Torres',    '27789012346', '2235410007', 'valentina.torres@mdp.edu.ar'),  -- num_lector  7 → Alumno
    ('Martín',    'Pérez',     '20890123457', '2235410008', 'martin.perez@mdp.edu.ar'),      -- num_lector  8 → Alumno
    ('Florencia', 'Gómez',     '27901234568', '2235410009', 'florencia.gomez@mdp.edu.ar'),   -- num_lector  9 → Graduado
    ('Javier',    'Díaz',      '20012345679', '2235410010', 'javier.diaz@mdp.edu.ar'),       -- num_lector 10 → Graduado
    -- Nuevos lectores para escenarios de notificación (Req 4)
    ('Roberto',   'Vega',      '20111222330', '2235410011', 'roberto.vega@mdp.edu.ar'),      -- num_lector 11 → Docente   | leyó los 3 libros de Stallings (positivo)
    ('Mariana',   'Solá',      '27222333440', '2235410012', 'mariana.sola@mdp.edu.ar'),      -- num_lector 12 → Docente   | leyó 2/3 de Stallings (negativo parcial)
    ('Pablo',     'Rivero',    '20333444550', '2235410013', 'pablo.rivero@mdp.edu.ar'),      -- num_lector 13 → Alumno    | leyó 1/3 de Stallings (negativo)
    ('Laura',     'Cabrera',   '27444555660', '2235410014', 'laura.cabrera@mdp.edu.ar'),     -- num_lector 14 → Alumno    | no leyó ningún Stallings (negativo vacío)
    ('Esteban',   'Marín',     '20555666770', '2235410015', 'esteban.marin@mdp.edu.ar');     -- num_lector 15 → Graduado  | leyó el único libro de Date (positivo)


PRINT 'Insertando docentes...';

INSERT INTO LectorDocente (num_lector) VALUES (1), (2), (3), (4), (11), (12);


PRINT 'Insertando alumnos...';

INSERT INTO LectorAlumno (num_lector, libreta) VALUES
    (5,  'LU-12345'),
    (6,  'LU-23456'),
    (7,  'LU-34567'),
    (8,  'LU-45678'),
    (13, 'LU-56789'),
    (14, 'LU-67890');


PRINT 'Insertando graduados...';

INSERT INTO LectorGraduado (num_lector, fecha_egreso) VALUES
    (9,  '2022-12-15'),
    (10, '2020-06-30'),
    (15, '2023-07-30');


-- =========================================
-- RELACIONES N:M
-- =========================================

PRINT 'Insertando relaciones autor-libro...';

INSERT INTO Escribe (id_autor, id_libro) VALUES
    (1, 1),    -- Silberschatz → Fundamentos BD
    (2, 1),    -- Korth        → Fundamentos BD
    (3, 2),    -- Cormen       → Introducción Algoritmos
    (4, 2),    -- Leiserson    → Introducción Algoritmos
    (5, 3),    -- Tanenbaum    → Redes de Computadoras
    (6, 4),    -- Knuth        → El Arte de la Programación
    (1, 5),    -- Silberschatz → Diseño BD Relacionales
    -- Nuevas relaciones (Req 4)
    (7, 6),    -- Stallings    → Sistemas Operativos
    (7, 7),    -- Stallings    → Criptografía
    (7, 8),    -- Stallings    → Comunicaciones y Redes
    (8, 9),    -- Date         → Introducción a Bases de Datos
    (9, 10),   -- Russell      → IA: Enfoque Moderno (co-autor)
    (10, 10),  -- Norvig       → IA: Enfoque Moderno (co-autor)
    -- Solo-autor para escenarios multi-autor
    (3, 11),   -- Cormen       → Métodos Numéricos (libro 11)
    (4, 12);   -- Leiserson    → Computación Paralela (libro 12)


PRINT 'Insertando relaciones edición-tema...';

INSERT INTO TrataSobre (cod_isbn, id_tema) VALUES
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

INSERT INTO SeDescribePor (cod_isbn, id_palabra_clave) VALUES
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
-- num_lector: 1=María, 2=Carlos, 3=Ana, 4=Luis
-- id_materia:  1=Diseño BD, 2=Algoritmos, 3=Redes, 4=Análisis Mat.

INSERT INTO Dicta (num_lector, id_materia) VALUES
    (1, 1),   -- María  → Diseño BD
    (1, 2),   -- María  → Algoritmos
    (2, 1),   -- Carlos → Diseño BD
    (2, 3),   -- Carlos → Redes
    (3, 2),   -- Ana    → Algoritmos
    (3, 4),   -- Ana    → Análisis Mat.
    (4, 3);   -- Luis   → Redes


PRINT 'Insertando bibliografía de materias...';
-- es_obligatorio: 1=sí, 0=no

INSERT INTO EsBibliografiaDe (id_libro, id_materia, es_obligatorio) VALUES
    (1, 1, 1),   -- Fundamentos BD      → Diseño BD (obligatorio)
    (5, 1, 1),   -- Diseño BD Rel.      → Diseño BD (obligatorio)
    (1, 2, 0),   -- Fundamentos BD      → Algoritmos (optativo)
    (2, 2, 1),   -- Introd. Algoritmos  → Algoritmos (obligatorio)
    (4, 2, 0),   -- Arte Programación   → Algoritmos (optativo)
    (3, 3, 1);   -- Redes               → Redes (obligatorio)


PRINT 'Insertando libros recomendados por docentes...';

INSERT INTO Recomendado (num_lector, id_materia, id_libro) VALUES
    (1, 1, 1),   -- María  recomienda Fundamentos BD     en Diseño BD
    (1, 1, 5),   -- María  recomienda Diseño BD Rel.     en Diseño BD
    (2, 1, 1),   -- Carlos recomienda Fundamentos BD     en Diseño BD
    (3, 2, 2);   -- Ana    recomienda Introd. Algoritmos en Algoritmos


-- =========================================
-- PRÉSTAMOS Y CONSULTAS
-- =========================================

PRINT 'Insertando préstamos...';
-- Vencimiento: docentes = 14 días, alumnos/graduados = 7 días

INSERT INTO Prestamo (num_lector, fecha_realizado) VALUES
    (1,  '2026-01-10'),   -- P1: María      (docente)   → 2 ejemplares, vencido (límite 2026-01-24)
    (5,  '2026-02-01'),   -- P2: Sofía      (alumno)    → 1 ejemplar,  vencido (límite 2026-02-08)
    (9,  '2026-03-15'),   -- P3: Florencia  (graduado)  → 3 ejemplares, vencido (límite 2026-03-22)
    (2,  '2026-05-10'),   -- P4: Carlos     (docente)   → 4 ejemplares, devueltos
    (6,  '2026-05-28'),   -- P5: Diego      (alumno)    → 1 ejemplar,  activo  (límite 2026-06-04)
    (8,  '2026-04-15'),   -- P6: Martín     (alumno)    → 2 ejemplares, vencido (límite 2026-04-22)
    (3,  '2025-03-15'),   -- P7: Ana        (docente)   → 1 ejemplar,  devuelto en 2025 (para comparativa interanual)
    (4,  '2025-01-20'),   -- P8: Luis       (docente)   → 1 ejemplar,  devuelto en 2025 (para comparativa interanual)
    -- Préstamos históricos (2024) para escenarios de notificación (Req 4) — todos devueltos
    (11, '2024-03-10'),   -- P9:  Roberto   (docente)   → Stallings OS              (1/3)
    (11, '2024-04-10'),   -- P10: Roberto   (docente)   → Stallings Crypto          (2/3)
    (11, '2024-05-10'),   -- P11: Roberto   (docente)   → Stallings Networks        (3/3) ✓ leyó los 3
    (12, '2024-06-10'),   -- P12: Mariana   (docente)   → Stallings OS              (1/2 — no Networks)
    (12, '2024-07-10'),   -- P13: Mariana   (docente)   → Stallings Crypto          (2/2)
    (13, '2024-08-10'),   -- P14: Pablo     (alumno)    → Stallings OS              (1/3, le falta Crypto y Networks)
    (15, '2024-09-10'),   -- P15: Esteban   (graduado)  → Date                      (1/1) ✓ leyó el único
    -- Escenarios multi-autor Cormen+Leiserson (Diego ya tiene libro 2 por P5; Sofía por P2; Florencia por P3)
    (6,  '2024-10-05'),   -- P16: Diego     (alumno)    → Métodos Numéricos         (Cormen solo)   → Diego: {2, 11}
    (6,  '2024-10-25'),   -- P17: Diego     (alumno)    → Computación Paralela      (Leiserson solo) → Diego: {2, 11, 12} ✓ positivo bajo B
    (5,  '2024-11-10'),   -- P18: Sofía     (alumno)    → Métodos Numéricos         (Cormen solo)   → Sofía: {2, 11} → A-Cormen pero NO B
    (9,  '2024-11-20'),   -- P19: Florencia (graduado)  → Computación Paralela      (Leiserson solo) → Florencia: {2, 12} → A-Leiserson pero NO B
    -- Préstamos que ejercitan las ediciones adicionales (mejor cobertura cruzada Req 1-3)
    (1,  '2024-08-15'),   -- P20: María     (docente)   → Redes 6a (libro 3)        → María cubre {1, 3} — qualifies para Tanenbaum (libro 3 es su único libro)
    (11, '2024-09-15'),   -- P21: Roberto   (docente)   → El Arte Vol 1 3a impr.    → Roberto cubre {6,7,8 Stallings + 4 Knuth} — qualifies para Knuth (libro 4 es su único libro)
    (15, '2024-10-12');   -- P22: Esteban   (graduado)  → Date 8a (libro 9)         → Esteban ya tiene libro 9 (P15); este P22 es una 2da edición del mismo libro


PRINT 'Insertando detalle de ejemplares por préstamo...';

INSERT INTO SeIncluyeEn (id_prestamo, cod_isbn, num_ejemplar, id_estado_devuelto, fecha_devuelto) VALUES
    -- P1: María (docente) — 2 ejemplares activos, vencidos
    (1, '9780078022159', 1, NULL, NULL),         -- Fundamentos BD 7a
    (1, '9780131873254', 1, NULL, NULL),         -- Fundamentos BD 6a (otra edición del mismo libro, cod_isbn distinto → permitido)

    -- P2: Sofía (alumno) — 1 ejemplar activo, vencido
    (2, '9780262033848', 1, NULL, NULL),         -- Algoritmos 3a

    -- P3: Florencia (graduado) — 3 ejemplares activos, todos vencidos
    (3, '9789587780246', 1, NULL, NULL),         -- Diseño BD Relacionales
    (3, '9780132126953', 1, NULL, NULL),         -- Redes 5a
    (3, '9780262033848', 3, NULL, NULL),         -- Algoritmos 3a (ejemplar 3)

    -- P4: Carlos (docente) — 4 ejemplares, todos devueltos (con estados variados)
    (4, '9780262046305', 1, 1,    '2026-05-20'), -- Algoritmos 4a   → Perfecto
    (4, '9780078022159', 3, 2,    '2026-05-20'), -- Fundamentos BD 7a → Bueno
    (4, '9780262033848', 2, 1,    '2026-05-22'), -- Algoritmos 3a   → Perfecto
    (4, '9780131873254', 2, 3,    '2026-05-22'), -- Fundamentos BD 6a → Aceptable

    -- P5: Diego (alumno) — 1 ejemplar activo
    (5, '9780262046305', 2, NULL, NULL),         -- Algoritmos 4a

    -- P6: Martín (alumno) — 2 ejemplares activos, vencidos
    (6, '9789587780246', 2, NULL, NULL),         -- Diseño BD Relacionales
    (6, '9780078022159', 2, NULL, NULL),         -- Fundamentos BD 7a

    -- P7: Ana (docente, 2025-03-15) — 1 ejemplar devuelto (interanual)
    (7, '9780262033848', 2, 2,    '2025-03-25'), -- Algoritmos 3a → Bueno

    -- P8: Luis (docente, 2025-01-20) — 1 ejemplar devuelto (interanual)
    (8, '9780078022159', 2, 1,    '2025-02-01'), -- Fundamentos BD 7a → Perfecto

    -- P9-P11: Roberto (docente) leyó los 3 libros de Stallings
    (9,  '9788483227206', 1, 2,    '2024-03-20'), -- Stallings OS       → Bueno
    (10, '9788478291672', 1, 1,    '2024-04-22'), -- Stallings Crypto   → Perfecto
    (11, '9788478290932', 1, 2,    '2024-05-24'), -- Stallings Networks → Bueno

    -- P12-P13: Mariana (docente) leyó solo 2 de los 3 Stallings
    (12, '9788483227206', 2, 1,    '2024-06-22'), -- Stallings OS       → Perfecto
    (13, '9788478291672', 2, 2,    '2024-07-22'), -- Stallings Crypto   → Bueno

    -- P14: Pablo (alumno) leyó 1 Stallings
    (14, '9788483227206', 1, 2,    '2024-08-17'), -- Stallings OS       → Bueno   (Bueno → Bueno)

    -- P15: Esteban (graduado) leyó el único libro de Date
    (15, '9788478290802', 1, 1,    '2024-09-17'), -- Date               → Perfecto

    -- P16-P19: escenarios multi-autor para test de interpretación B (Cormen+Leiserson)
    (16, '9788429143751', 1, 1,    '2024-10-12'), -- Diego     → Métodos Numéricos     (Cormen)    → Perfecto
    (17, '9788429143768', 1, 1,    '2024-11-01'), -- Diego     → Computación Paralela  (Leiserson) → Perfecto
    (18, '9788429143751', 2, 2,    '2024-11-17'), -- Sofía     → Métodos Numéricos     (Cormen)    → Bueno
    (19, '9788429143768', 2, 1,    '2024-11-27'), -- Florencia → Computación Paralela  (Leiserson) → Perfecto

    -- P20-P22: préstamos sobre las ediciones adicionales (variedad de cobertura)
    (20, '9780132553175', 1, 1,    '2024-08-29'), -- María     → Redes 6a (Tanenbaum)         → Perfecto
    (21, '9780201896831', 1, 2,    '2024-09-29'), -- Roberto   → El Arte Vol 1 3a impr. (Knuth) → Bueno
    (22, '9780321197849', 1, 1,    '2024-10-19'); -- Esteban   → Date 8a                      → Perfecto


PRINT 'Insertando consultas en sala...';
-- Solo para ediciones con ejemplar único (ISBN 9780201485417, num_ejemplar 1 — único ejemplar de esa edición)

INSERT INTO Consulta (fecha_consulta, cod_isbn, num_ejemplar, num_lector) VALUES
    ('2026-04-10', '9780201485417', 1, 7),    -- Valentina (alumno)
    ('2026-05-15', '9780201485417', 1, 3),    -- Ana       (docente)
    ('2026-05-20', '9780201485417', 1, 10);   -- Javier    (graduado)


PRINT '=========================================';
PRINT 'SEED FINALIZADO CORRECTAMENTE';
PRINT '=========================================';
