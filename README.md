# Sistema de Gestión de Biblioteca Universitaria 📚

---

## Índice
- [Descripción del Proyecto](#descripcion-del-proyecto)
- [Setup de Base de Datos] (#setup-base-de-datos)
- [Base de Datos](#base-de-datos)
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

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) corriendo
- [sqlcmd](https://learn.microsoft.com/es-es/sql/tools/sqlcmd/sqlcmd-utility) instalado y en el PATH
- Archivo `.env` en la raíz del proyecto (ver `.env.example`)

### Primera vez (o rebuild completo)

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

**Error de conexión a SQL Server**
Verificar que Docker Desktop esté corriendo y que el puerto en `.env` no esté ocupado.
```powershell
docker ps  # el contenedor debe aparecer como "Up"
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
| `Palabra_Clave` | Palabras clave del contenido de una edición |
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
| `Autor_Libro` | Autores de un libro (N:M) |
| `Edicion_Tema` | Temas de una edición (N:M) |
| `Edicion_Palabra` | Palabras clave de una edición (N:M) |
| `Libro_Materia` | Bibliografía (obligatoria u optativa) de una materia (N:M) |
| `Docente_Materia` | Materias dictadas por un docente (N:M) |
| `Ejemplar_Prestamo` | Detalle de ejemplares incluidos en un préstamo |

### Stored Procedures

- *(tored procedures implementados en `database/procedures/`)*

### Vistas

Las vistas implementadas se encuentran en `database/views/` y dan soporte a las consultas más frecuentes del sistema (préstamos vencidos, estado de ejemplares, estadísticas por período).

### Triggers y Transacciones

Los triggers garantizan la integridad referencial y las reglas de negocio que no pueden expresarse solo con constraints (por ejemplo, la regla de préstamo único por edición). Las transacciones se utilizan para asegurar consistencia en operaciones compuestas como el registro de un préstamo con múltiples ejemplares.

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
│       ├── autor_libro.sql
│       ├── edicion_tema.sql
│       ├── edicion_palabra.sql
│       ├── libro_materia.sql
│       └── docente_materia.sql
├── procedures/                # Stored procedures
├── views/                     # Vistas
├── seed/                      # Datos de prueba
├── scripts/                   # Scripts utilitarios
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