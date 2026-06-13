# Sistema de Gestión de Biblioteca Universitaria 📚

---

## Índice
- [Descripción del Proyecto](#descripcion-del-proyecto)
- [Setup de Base de Datos] (#setup-base-de-datos)
- [Base de Datos](#base-de-datos)
- [Validación de Requerimientos](#validacion-de-requerimientos)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Documentación](#documentacion)
- [Objetivos del Proyecto](#objetivos-del-proyecto)
- [Equipo](#equipo)

---

<a id="descripcion-del-proyecto"></a>
## 📋 Descripción del Proyecto

Sistema de Gestión de Biblioteca Universitaria implementado sobre **SQL Server**, diseñado para informatizar las operaciones de una biblioteca de universidad. Permite administrar el catálogo de libros, ediciones y ejemplares, gestionar préstamos y consultas, y dar soporte a las necesidades de docentes, alumnos y egresados.

**Materia:** Diseño de Base de Datos y Bases de Datos — 1c2026  
**Docente:** Prof. Leticia M. Seijas  
**Universidad:** Universidad Nacional de Mar del Plata — Facultad de Ingeniería

### Funcionalidades Principales

**Gestión del Catálogo:**
- 📖 **Libros** — Título, autores, editorial e idioma
- 🗂️ **Ediciones** — Identificadas por ISBN, con fecha de publicación, índice, temas y palabras clave
- 📦 **Ejemplares** — Control de estado y ubicación por estantería
- ✍️ **Autores** — Nombre, apellido, nombre de fantasía, fecha de nacimiento y biografía

**Gestión de Lectores:**
- 👨‍🏫 **Docentes** — Con las materias que dictan y su bibliografía recomendada
- 🎓 **Alumnos** — Con número de libreta universitaria
- 🏛️ **Egresados** — Con fecha de egreso registrada
- 📋 **Materias** — Con bibliografía obligatoria y optativa asociada

**Funcionalidades Avanzadas:**
- 📅 **Préstamos** — Control de plazos (2 semanas para docentes, 1 para alumnos/egresados), con restricción de no poder retirar dos ejemplares de la misma edición en el mismo préstamo
- 🔍 **Consultas en sala** — Disponible solo cuando hay un único ejemplar de una edición
- ⚠️ **Préstamos vencidos** — Listado completo con datos del deudor para reclamo
- 📊 **Estadísticas de préstamos** — Por mes, agrupadas por título, autor, editorial o tema, con comparativa respecto al mismo mes del año anterior
- 📬 **Notificación de nuevos libros** — Stored procedure que identifica a qué lectores avisar cuando se incorpora un libro, según si solicitaron todos los libros del mismo autor
- 🗃️ **Estado de ejemplares** — Consulta por libro, autor, tema o profesor recomendante, con estado actual de cada ejemplar (en estantería, en préstamo, vencido, etc.)

---

<a id="setup-base-de-datos"></a>
## ⚙️ Setup de base de datos

### Requisitos previos

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) **instalado y con el daemon corriendo** (no alcanza con la app abierta — esperá a que el ícono de la barra de menú deje de animarse). Verificalo con `docker info`.
- [sqlcmd](https://learn.microsoft.com/es-es/sql/tools/sqlcmd/sqlcmd-utility) instalado y en el PATH
- Archivo `.env` en la raíz del proyecto (ver `.env.example`)

### Primera vez (o rebuild completo)

**1.** Arrancá Docker (si no lo tenés ya):
```bash
open -a Docker                                       # macOS
until docker info > /dev/null 2>&1; do sleep 1; done # esperar al daemon
```

**2.** Corré el setup:
```powershell
.\setup_database.ps1
```

```bash
./setup_database.sh
```

Esto levanta el contenedor, crea la base de datos y recrea todas las tablas.

### Datos de prueba (opcional)

Para poblar la base de datos con registros listos para consultar:

**1.** Asegurate de tener el contenedor corriendo:
```bash
docker ps  # debe aparecer biblioteca-sqlserver como "Up"
```

**2.** Corré el setup con el flag de seed (desde el root del repo):
```powershell
.\setup_database.ps1 -WithSeed
```

```bash
./setup_database.sh --with-seed
```

**3.** Verificá que los datos se insertaron:
```bash
sqlcmd -S localhost,1433 -U sa -P Password123 -d biblioteca -C -Q "SELECT COUNT(*) FROM Libro"
```

El seed incluye:
- 5 libros técnicos con sus autores, ediciones, temas y palabras clave
- 10 lectores: 4 docentes, 4 alumnos y 2 graduados, con sus materias y recomendaciones
- 6 préstamos: activos, vencidos y uno ya devuelto — útiles para probar vistas y consultas
- 3 consultas en sala sobre el ejemplar único de *El Arte de la Programación de Computadoras*

### Opciones disponibles

| Flag (PowerShell) | Flag (bash) | Descripción |
|---|---|---|
| `-SkipDocker` | `--skip-docker` | Omite el `docker compose up` (útil si el contenedor ya está corriendo) |
| `-WithSeed` | `--with-seed` | Inserta los datos de prueba después de crear las tablas |

**Ejemplos:**
```powershell
# Solo recrear tablas (contenedor ya corriendo)
.\setup_database.ps1 -SkipDocker

# Setup completo con datos de prueba
.\setup_database.ps1 -WithSeed

# Solo tablas + seed, sin Docker
.\setup_database.ps1 -SkipDocker -WithSeed
```

```bash
# Solo recrear tablas (contenedor ya corriendo)
./setup_database.sh --skip-docker

# Setup completo con datos de prueba
./setup_database.sh --with-seed

# Solo tablas + seed, sin Docker
./setup_database.sh --skip-docker --with-seed
```

### Solución de problemas

**El script no se puede ejecutar**
PowerShell puede bloquear scripts externos por política de ejecución. Ejecutar una vez:
```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

**`Cannot connect to the Docker daemon`**
El daemon de Docker no está corriendo. Abrí Docker Desktop y esperá a que el ícono de la barra de menú se quede fijo (no animado). Verificá con `docker info` — debe responder sin error.

**Error de conexión a SQL Server**
Verificar que el contenedor esté corriendo y que el puerto en `.env` no esté ocupado.
```bash
docker ps  # el contenedor biblioteca-sqlserver debe aparecer como "Up"
```

**Apple Silicon (M1/M2/M3) o Linux ARM64: el contenedor falla al iniciar**
`mssql/server` no tiene imagen ARM64 nativa y crashea bajo emulación. El proyecto usa `azure-sql-edge`, que sí soporta ARM64. Si al hacer pull ves que la imagen cambió respecto a lo que tenías, es para mantener compatibilidad con todos los equipos.

---

<a id="base-de-datos"></a>
## 🗄️ Base de Datos

### Entidades Principales

| Entidad | Descripción |
|---|---|
| `Libro` | Título, editorial e idioma |
| `Autor` | Datos personales y biográficos del autor |
| `Editorial` | Nombre de la editorial |
| `Idioma` | Idioma del libro |
| `Edicion` | ISBN, fecha de publicación, índice y estantería asociada |
| `Ejemplar` | Copia física de una edición, con estado actual |
| `Estanteria` | Zona física donde se ubican los ejemplares |
| `Tema` | Temas principales de una edición |
| `PalabraClave` | Palabras clave del contenido de una edición |
| `Lector` | Persona que puede realizar préstamos o consultas |
| `LectorDocente` | Especialización de Lector para docentes |
| `LectorAlumno` | Especialización de Lector para alumnos |
| `LectorGraduado` | Especialización de Lector para egresados |
| `Materia` | Materias dictadas en la universidad |
| `Prestamo` | Registro de un préstamo realizado por un lector |
| `Consulta` | Registro de consulta en sala de un ejemplar |

### Tablas de Relación

| Tabla | Relación |
|---|---|
| `Escribe` | Autores de un libro \| Autor, Libro (N:M) |
| `TrataSobre` | Temas de una edición \| Edicion, Tema (N:M) |
| `SeDescribePor` | Palabras clave de una edición \| Edicion, PalabraClave (N:M) |
| `EsBibliografiaDe` | Bibliografía (obligatoria u optativa) de una materia \| Libro, Materia (N:M) |
| `Dicta` | Materias dictadas por un docente \| LectorDocente, Materia (N:M) |
| `Recomendado` | Libros recomendados por un docente en una materia \| LectorDocente, Materia, Libro (N:M:P) |
| `SeIncluyeEn` | Ejemplares incluidos en un préstamo \| Ejemplar, Prestamo (N:M) |

### Stored Procedures

Implementados en `database/procedures/`:

| SP | Requerimiento | Función |
|---|---|---|
| `sp_estado_ejemplares` | Req 2 | Recibe `@tipo_filtro` (`'libro'`/`'autor'`/`'tema'`/`'profesor'`) y `@id_filtro`. Devuelve el estado de los ejemplares filtrados, con situación (`'En estanteria'`/`'Prestado'`/`'Vencido'`) y fecha de devolución esperada. |
| `sp_estadisticas_prestamos_mes` | Req 3 | Recibe `@anio`, `@mes`, `@agrupar_por` (`'titulo'`/`'autor'`/`'editorial'`/`'tema'`). Devuelve cantidad de préstamos del mes pedido vs mismo mes año anterior. |
| `sp_notificar_nuevo_libro` | Req 4 | Recibe `@id_libro_nuevo`. Devuelve los lectores que pidieron TODOS los libros previos de algún autor del libro nuevo (doble `NOT EXISTS`). |
| `sp_registrar_prestamo` | Tech: transacciones | Alta de préstamo dentro de una **transacción** (`SET XACT_ABORT ON` + `BEGIN TRY/CATCH`). Valida que el lector exista y que el ejemplar esté disponible. |

### Vistas

Implementadas en `database/views/`:

| Vista | Requerimiento | Contenido |
|---|---|---|
| `vw_prestamos_vencidos` | Req 1 | Préstamos activos cuya fecha límite ya pasó. Plazo derivado con `LEFT JOIN LectorDocente` (14 días si matchea, 7 si no). Incluye datos de contacto del deudor. |
| `vw_prestamos_por_mes` | Helper Req 3 | Granularidad (préstamo, ejemplar, autor, tema). Base que consume `sp_estadisticas_prestamos_mes`. |

### Triggers y Transacciones

Trigger implementado en `database/triggers/`:

| Trigger | Tabla | Regla |
|---|---|---|
| `tr_se_incluye_en_disponibilidad` | `SeIncluyeEn` | Sincroniza `Ejemplar.disponible` con el estado de los préstamos (denormalizado, opera por conjunto con `inserted`/`deleted`). |

Las **transacciones** se usan en `sp_registrar_prestamo` con `SET XACT_ABORT ON` + `BEGIN TRY / BEGIN CATCH`: si cualquier validación o trigger falla, se hace `ROLLBACK` automáticamente.

---

<a id="validacion-de-requerimientos"></a>
## 🧪 Validación de Requerimientos

Comandos T-SQL para probar cada requerimiento del spec end-to-end. Ejecutar contra la base seedeada (`./setup_database.sh --with-seed`).

### Req 1 — Préstamos vencidos a una fecha dada

> *"La consulta para obtener el listado de todos los préstamos vencidos a una fecha dada. Este listado debe contener todos los datos necesarios para identificar al deudor y reclamar el libro."*

```sql
-- Vista base: todos los préstamos activos con fecha_limite computada
SELECT * FROM vw_prestamos_activos ORDER BY fecha_limite;

-- SP — vencidos al día de hoy
EXEC sp_prestamos_vencidos_a_fecha;

-- SP — vencidos a una fecha específica (formato DD-MM-YYYY)
EXEC sp_prestamos_vencidos_a_fecha @fecha = '01-03-2026';

-- Validación: formato inválido → RAISERROR
EXEC sp_prestamos_vencidos_a_fecha @fecha = '2026-03-01';
```

### Req 2 — Estado actual de ejemplares (filtro por libro/autor/tema/profesor)

> *"La consulta para obtener para un libro dado (o para todos los libros de un cierto autor, o de un cierto tema o recomendados por cierto profesor) el estado actual de todos sus ejemplares (por ej. cuáles están en la estantería, cuándo serán devueltos los que están actualmente en préstamo, los que tienen el préstamo vencido, etc.)."*

```sql
-- 4 filtros del spec
EXEC sp_estado_ejemplares @tipo_filtro = 'libro',    @id_filtro = 1;   -- Fundamentos BD
EXEC sp_estado_ejemplares @tipo_filtro = 'autor',    @id_filtro = 1;   -- Silberschatz
EXEC sp_estado_ejemplares @tipo_filtro = 'tema',     @id_filtro = 1;   -- Base de Datos
EXEC sp_estado_ejemplares @tipo_filtro = 'profesor', @id_filtro = 1;   -- María (recomienda)

-- Validación: tipo_filtro inválido → RAISERROR
EXEC sp_estado_ejemplares @tipo_filtro = 'invalido', @id_filtro = 1;
```

### Req 3 — Estadísticas mensuales con comparativa interanual

> *"La estadística de la cantidad de libros prestados por mes, agrupados por diferentes criterios (por título, autor, editorial, tema, etc.) y su correspondiente comparativa con el mismo mes del año anterior."*

```sql
-- Vista base
SELECT DISTINCT año, mes, nombre_mes FROM vw_prestamos_por_mes ORDER BY año, mes;

-- 4 criterios del spec
EXEC sp_estadisticas_prestamos_mes @año = 2026, @mes = 1, @agrupar_por = 'titulo';
EXEC sp_estadisticas_prestamos_mes @año = 2026, @mes = 1, @agrupar_por = 'editorial';
EXEC sp_estadisticas_prestamos_mes @año = 2026, @mes = 3, @agrupar_por = 'autor';
EXEC sp_estadisticas_prestamos_mes @año = 2026, @mes = 1, @agrupar_por = 'tema';

-- Validación: criterio inválido → RAISERROR
EXEC sp_estadisticas_prestamos_mes @año = 2026, @mes = 1, @agrupar_por = 'invalido';
```

### Req 4 — Notificación a lectores ante nuevo libro

> *"Cada vez que se incorpora un nuevo libro a la biblioteca, se envían e-mails avisando del nuevo libro a todos aquellos lectores que hubieran solicitado TODOS los libros del mismo autor."*

```sql
-- Caso single-author (Stallings → debe devolver Roberto)
BEGIN TRANSACTION;
INSERT INTO Libro (titulo, id_editorial, id_idioma) VALUES ('Wireless Communications', 1, 2);
DECLARE @nuevo INT = SCOPE_IDENTITY();
INSERT INTO Escribe (id_autor, id_libro) VALUES (7, @nuevo);
EXEC sp_notificar_nuevo_libro @id_libro_nuevo = @nuevo;
ROLLBACK TRANSACTION;

-- Caso multi-author bajo interpretación B (Cormen+Leiserson → solo Diego)
BEGIN TRANSACTION;
INSERT INTO Libro (titulo, id_editorial, id_idioma) VALUES ('Algoritmos Paralelos Avanzados', 2, 1);
DECLARE @nuevo INT = SCOPE_IDENTITY();
INSERT INTO Escribe (id_autor, id_libro) VALUES (3, @nuevo), (4, @nuevo);
EXEC sp_notificar_nuevo_libro @id_libro_nuevo = @nuevo;
ROLLBACK TRANSACTION;

-- Caso préstamo + consulta combinados (Knuth → Roberto + Valentina + Ana + Javier)
BEGIN TRANSACTION;
INSERT INTO Libro (titulo, id_editorial, id_idioma) VALUES ('TAOCP Vol 5', 3, 2);
DECLARE @nuevo INT = SCOPE_IDENTITY();
INSERT INTO Escribe (id_autor, id_libro) VALUES (6, @nuevo);
EXEC sp_notificar_nuevo_libro @id_libro_nuevo = @nuevo;
ROLLBACK TRANSACTION;

-- Caso vacuous truth: autor sin libros previos → resultado vacío
BEGIN TRANSACTION;
INSERT INTO Autor (nombre, apellido, nombre_fantasia, fecha_nacimiento, biografia)
VALUES ('Ada', 'Lovelace', 'Lovelace', '1815-12-10', 'Primera programadora.');
DECLARE @autor_nuevo INT = SCOPE_IDENTITY();
INSERT INTO Libro (titulo, id_editorial, id_idioma) VALUES ('Notes on the Analytical Engine', 3, 2);
DECLARE @libro_nuevo INT = SCOPE_IDENTITY();
INSERT INTO Escribe (id_autor, id_libro) VALUES (@autor_nuevo, @libro_nuevo);
EXEC sp_notificar_nuevo_libro @id_libro_nuevo = @libro_nuevo;
ROLLBACK TRANSACTION;
```

### Tech horizontales — Triggers, Transacciones y Restricciones DDL

> *"En la resolución de algún aspecto de la implementación deberán utilizar stored procedures, vistas, triggers y transacciones."*

**Triggers** — sincronización automática de `Ejemplar.disponible`:

```sql
-- 1. Estado inicial del ejemplar libre
SELECT disponible FROM Ejemplar WHERE cod_isbn = '9780078022159' AND num_ejemplar = 3;
-- Esperado: 1

-- 2. Registrar préstamo → trigger AFTER INSERT setea disponible = 0
DECLARE @id INT;
EXEC sp_registrar_prestamo @num_lector = 5, @cod_isbn = '9780078022159', @num_ejemplar = 3, @id_prestamo = @id OUTPUT;

SELECT disponible FROM Ejemplar WHERE cod_isbn = '9780078022159' AND num_ejemplar = 3;
-- Esperado: 0 (trigger insert ejecutado)

-- 3. Devolver → trigger AFTER UPDATE setea disponible = 1
UPDATE SeIncluyeEn
SET fecha_devuelto = CAST(GETDATE() AS DATE), id_estado_devuelto = 2
WHERE id_prestamo = @id;

SELECT disponible FROM Ejemplar WHERE cod_isbn = '9780078022159' AND num_ejemplar = 3;
-- Esperado: 1 (trigger update ejecutado)
```

**Transacciones** — rollback ante error en `sp_registrar_prestamo`:

```sql
-- Caso error: ejemplar no disponible → RAISERROR + ROLLBACK
EXEC sp_registrar_prestamo @num_lector = 6, @cod_isbn = '9780078022159', @num_ejemplar = 1;

-- Caso error: edición de un solo ejemplar → "solo se puede consultar en sala"
EXEC sp_registrar_prestamo @num_lector = 5, @cod_isbn = '9780201485417', @num_ejemplar = 1;

-- Caso error: lector inexistente
EXEC sp_registrar_prestamo @num_lector = 999, @cod_isbn = '9780078022159', @num_ejemplar = 3;
```

**Restricciones DDL del DER**:

```sql
-- 1. "No puede retirar dos ejemplares de la misma edición" (PK SeIncluyeEn = id_prestamo + cod_isbn)
INSERT INTO SeIncluyeEn (id_prestamo, cod_isbn, num_ejemplar) VALUES (1, '9780078022159', 2);
-- Esperado: PK violation (préstamo 1 ya tiene un ejemplar de esa edición)

-- 2. Formato de email (CHECK constraint)
INSERT INTO Lector (nombre, apellido, cuil, telefono, email)
VALUES ('Test', 'Test', '20999999990', '0000', 'sin_arroba');
-- Esperado: CHECK constraint violation

-- 3. Dominio binario de Ejemplar.disponible (BIT)
SELECT COUNT(*) FROM Ejemplar WHERE disponible NOT IN (0, 1);
-- Esperado: 0
```

---

<a id="estructura-del-proyecto"></a>
## 📁 Estructura del Proyecto

```
database/
├── tables/
│   ├── entities/              # Tablas de entidades principales
│   │   ├── editorial.sql
│   │   ├── idioma.sql
│   │   ├── autor.sql
│   │   ├── libro.sql
│   │   ├── edicion.sql
│   │   ├── ejemplar.sql
│   │   ├── lector.sql
│   │   └── ...
│   └── relations/             # Tablas de relación N:M
│       ├── escribe.sql
│       ├── trata_sobre.sql
│       ├── se_describe_por.sql
│       ├── es_bibliografia_de.sql
│       ├── dicta.sql
│       ├── se_incluye_en.sql
│       └── recomendado.sql
├── triggers/                  # Triggers de integridad y reglas de negocio
├── procedures/                # Stored procedures
├── views/                     # Vistas
├── scripts/                   # Scripts utilitarios (init, rebuild, seed, drop)
└── docs/                      # Documentación (MER, MR, supuestos)
```

---

<a id="documentacion"></a>
## 📄 Documentación

En la carpeta `database/docs/` se encuentra:

- **Modelo de Entidad-Relación (MER)**
- **Modelo Relacional (MR)** derivado del MER
- **Supuestos asumidos** para la resolución del problema
- **Diseño físico** de la solución implementada
- **Restricciones adicionales** al modelo

---

<a id="objetivos-del-proyecto"></a>
## 🎯 Objetivos del Proyecto

Este trabajo práctico demuestra:

✅ **Diseño de Base de Datos**
- Modelado Entidad-Relación a partir de un problema del mundo real
- Derivación del Modelo Relacional
- Normalización y manejo de relaciones complejas (1:1, 1:N, N:M)
- Herencia de entidades (Lector → Docente / Alumno / Egresado)

✅ **Implementación en SQL Server**
- DDL: creación de tablas, claves primarias, foráneas y constraints
- DML: consultas, actualizaciones y datos de prueba
- Stored procedures para lógica de negocio compleja
- Vistas para simplificar consultas frecuentes
- Triggers para aplicación de reglas de integridad
- Transacciones para operaciones compuestas

✅ **Consultas y Reportes**
- Listado de préstamos vencidos con datos del deudor
- Estado actual de ejemplares por libro, autor, tema o profesor
- Estadísticas de préstamos por mes con comparativa interanual
- Identificación de lectores a notificar ante nuevo ingreso de libro

---

<a id="equipo"></a>
## 👥 Equipo

**Integrantes:**
- Borgnia Giannini Erik Gabriel
- Delgado Facundo
- Diaz Juan José
- Parise Thiago

*1er Cuatrimestre 2026*

---