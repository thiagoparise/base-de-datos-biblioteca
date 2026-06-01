#!/usr/bin/env bash
# =========================================
# Setup completo: Docker + Base de datos
# =========================================
# Uso: ./setup_database.sh [--skip-docker] [--with-seed]
#   --skip-docker  Omite el docker compose up (util si el contenedor ya esta corriendo)
#   --with-seed    Ejecuta el seed de datos iniciales
# =========================================

set -e

SKIP_DOCKER=false
WITH_SEED=false

for arg in "$@"; do
    case $arg in
        --skip-docker) SKIP_DOCKER=true ;;
        --with-seed)   WITH_SEED=true ;;
        *) echo "Argumento desconocido: $arg" >&2; exit 1 ;;
    esac
done

# Fijar CWD a la carpeta donde esta este script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"


# =========================================
# LEER .ENV
# =========================================

ENV_FILE=".env"

if [ ! -f "$ENV_FILE" ]; then
    echo "Error: No se encontro el archivo .env en $SCRIPT_DIR" >&2
    exit 1
fi

set -a
# shellcheck source=.env
source "$ENV_FILE"
set +a

PASSWORD="${MSSQL_SA_PASSWORD}"
PORT="${MSSQL_PORT}"

if [ -z "$PASSWORD" ] || [ -z "$PORT" ]; then
    echo "Error: Faltan MSSQL_SA_PASSWORD o MSSQL_PORT en el archivo .env" >&2
    exit 1
fi


# =========================================
# DOCKER
# =========================================

if [ "$SKIP_DOCKER" = false ]; then
    echo ""
    echo "========================================="
    echo " LEVANTANDO SQL SERVER EN DOCKER"
    echo "========================================="

    docker compose up -d

    echo ""
    echo "Esperando a que SQL Server inicie..."
    sleep 30
else
    echo ""
    echo "[--skip-docker] Omitiendo docker compose up..."
fi


# Helper: ejecuta sqlcmd y detiene el script si falla
invoke_sqlcmd_file() {
    local description="$1"
    local file="$2"
    local database="$3"

    echo ""
    echo "========================================="
    echo " $description"
    echo "========================================="

    local abs_file
    abs_file="$(cd "$(dirname "$file")" && pwd)/$(basename "$file")"
    local sql_dir
    sql_dir="$(dirname "$abs_file")"

    local args=(
        -S "localhost,$PORT"
        -U "sa"
        -P "$PASSWORD"
        -b
        -C
        -i "$abs_file"
    )

    if [ -n "$database" ]; then
        args+=(-d "$database")
    fi

    # Fijar el CWD al directorio del .sql para que los :r resuelvan correctamente
    (cd "$sql_dir" && sqlcmd "${args[@]}")
}


# =========================================
# INIT + REBUILD
# =========================================

invoke_sqlcmd_file \
    "CREANDO BASE DE DATOS" \
    "database/scripts/init_database.sql"

invoke_sqlcmd_file \
    "CREANDO TABLAS Y CONSTRAINTS" \
    "database/scripts/rebuild_database.sql" \
    "biblioteca"


# =========================================
# SEED (opcional)
# =========================================

if [ "$WITH_SEED" = true ]; then
    invoke_sqlcmd_file \
        "INSERTANDO DATOS INICIALES" \
        "database/scripts/seed_database.sql" \
        "biblioteca"
fi


# =========================================
# FINALIZADO
# =========================================

echo ""
echo "========================================="
echo " SETUP FINALIZADO CORRECTAMENTE"
echo "========================================="
echo ""
